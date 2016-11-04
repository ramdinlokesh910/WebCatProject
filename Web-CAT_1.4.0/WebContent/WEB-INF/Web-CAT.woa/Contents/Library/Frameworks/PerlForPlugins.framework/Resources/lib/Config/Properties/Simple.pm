package Config::Properties::Simple;

use 5.006;

our $VERSION = '0.07';

use strict;
use warnings;
use Carp;

use Config::Properties;
use Config::Find;

our @ISA=qw(Config::Properties Config::Find);

sub new {
    my ($class, %opts)=@_;

    my $defaults;
    if (defined $opts{defaults}) {
	$defaults=Config::Properties->new();
	for my $k (keys %{$opts{defaults}}) {
	    $defaults->setProperty($k, $opts{defaults}->{$k})
	}
    }

    my $this=$class->SUPER::new($defaults);

    $this->{simple_opts}=\%opts;

    exists $opts{format}
	and $this->setFormat($opts{format});

    unless ($opts{noread}
	    or (exists $opts{mode} and $opts{mode}=~/^w(?:rite)?/i)) {
	my $fn=$this->{simple_fn}=$this->find(%opts);
	unless (defined $fn) {
	    return $this if ($opts{optional} and !defined $opts{file})
		or croak 'configuration file not found';
	}
	my $fh=IO::File->new($fn, "r");
	unless ($fh) {
	    return $this if ($opts{optional} and !defined $opts{file})
		or croak 'unable to open configuration file for reading';
	}
	$this->load($fh);
	close $fh
	    or croak 'unable to read configuration file';

	my $required=$opts{required};
	if (defined $required) {
	    UNIVERSAL::isa($required, 'ARRAY')
		or croak "invalid object passed for 'required' option, array reference expected";
	    foreach my $req (@{$required}) {
		die "required property '$req' not found in $fn";
	    }
	}
    }

    return $this;
}

sub file_name { shift->{simple_fn} }

sub save {
    my $this=shift;
    my %opts= (%{$this->{simple_opts}}, mode => 'w', @_);
    my $fh=$this->open(%opts)
	or croak 'unable to open configuration file for writing';
    my $header=$opts{header}
	|| 'Automatically generated configuration file';
    $this->SUPER::save($fh, $header);
    close $fh
	or croak 'unable to write configuration file';
}

sub fail {
    my ($this, $error)=@_;
    die "$error at ".$this->file_name." line ".$this->line_number."\n";
}

sub validate {
    my ($this, $key, $value) = @_;
    my $vtor=$this->{simple_opts}{validate};
    if (defined $vtor) {
	my $fn=$this->{simple_fn};
	if (UNIVERSAL::isa($vtor, 'CODE')) {
	    return &$vtor($key, $value, $this);
	}
	elsif (UNIVERSAL::isa($vtor, 'ARRAY')) {
	    foreach my $vtor2 (@{$vtor}) {
		if (UNIVERSAL::isa($vtor2, 'Regexp')) {
		    return $value if $key=~$vtor2;
		}
		else {
		    return $value if $vtor2 eq $key;
		}
	    }
	    $this->fail("unknow property '$key' found");
	}
	elsif (UNIVERSAL::isa($vtor, 'HASH')) {
	    # warn "validate is hash";
	    my $vtor2;
	    if (exists $vtor->{$key}) {
		$vtor2=$vtor->{$key}
	    }
	    elsif (exists $vtor->{__default}) {
		$vtor2=$vtor->{__default}
	    }
	    else {
		$this->fail("unknow property '$key' found");
	    }
	    if (UNIVERSAL::isa($vtor2, 'CODE')) {
		return &$vtor($key, $value, $this);
	    }
	    elsif (UNIVERSAL::isa($vtor2, 'Regexp')) {
		return $value if $value=~$vtor2;
		$this->fail("property '$key' value '$value' is not allowed: it doesn't match regexp '$vtor2'");
	    }
	    elsif (UNIVERSAL::isa($vtor2, 'ARRAY')) {
		return $value if grep { $value eq $_} @{$vtor2};
		$this->fail("property '$key' value '$value' is not allowed");
	    }
	    elsif (UNIVERSAL::isa($vtor2, 'HASH')) {
		return $vtor2->{$value} if exists $vtor2->{$value};
		$this->fail("property '$key' value '$value' is not allowed");
	    }
	    elsif ($vtor2=~/^s(?:tring)?$/i or $vtor2=~/^a(?:ny)?$/i) {
		return $value;
	    }
	    elsif ($vtor2=~/^b(?:oolean)?$/i) {
		return 1 if ( $value eq '1' or
			      $value=~/^y(?:es)?$/i or
			      $value=~/^t(?:rue)?$/i);
		return 0 if ( $value eq '' or
			      $value eq '0' or
			      $value=~/^no?$/i or
			      $value=~/^f(?:alse)?$/i);
		$this->fail("property '$key' value '$value' is not allowed: boolean expected");
	    }
	    elsif ($vtor2=~/^u(?:nsigned)?$/i) {
		return int $1 if $value=~/^(\d+)$/;
		$this->fail("property '$key' value '$value' is not allowed: unsigned integer expected");
	    }
	    elsif ($vtor2=~/^i(?:nteger)?$/i) {
		return int $1 if $value=~/^([+\-]?\d+)$/;
		$this->fail("property '$key' value '$value' is not allowed: integer expected");
	    }
	    elsif ($vtor2=~/^f(?:loat)?$/i or $vtor2=~/^n(?:umber)?$/i) {
		return 0+$1 if $value=~/^([+-]?(?:\d+|\d*\.\d+|\d+\.\d*)(?:[eE][+-]?\d+)?)$/;
		$this->fail("property '$key' value '$value' is not allowed: number expected");
	    }
	    else {
		croak "invalid object '$vtor2' for validate";
	    }
	}
	else {
	    croak "invalid object '$vtor' for validate";
	}
    }
    return $value;
}

1;
__END__

=head1 NAME

Config::Properties::Simple - Perl extension to manage configuration files.

=head1 SYNOPSIS

  use Config::Properties::Simple;

  my $cfg=Config::Properties::Simple->new();
  my $foo=$cfg->getProperty('foo', 'default foo');

  $cfg->setProperty(bar => 'my bar')
  $cfg->save

  my $cfg2=Config::Properties::Simple->new(
    name => 'app/file',
    file => $opt_c,
    optional => 1,
    validate => { Foo => 'boolean',
                  MyHexProp => qr/^0x[0-9a-f]+$/i,
                  Odd => sub {
                    my ($key, $value, $cfg)=@_;
                    $value = int $value;
                    $value & 1 or
                      $cfg->fail("$value is not odd");
                    $value } },
    defaults => { Foo => 1,
                  MyHexProp => '0x45' },
    required => [qw( Foo )] );


=head1 ABSTRACT

Wrapper around L<Config::Properties> to simplify its use.

=head1 DESCRIPTION

This package mix functionality in L<Config::Properties> and
L<Config::Find> packages to provide a simple access to
configuration files.

It changes C<new> and C<save> methods of L<Config::Properties> (every
other method continues to work as usual):

=over 4

=item Config::Properties::Simple-E<gt>new(%opts)

creates a new L<Config::Properties::Simple> object and reads on the
configuration file determined by the options passed through C<%opts>.

The supported options are:

=over 4

=item C<defaults =E<gt> {...}>

hash reference containing default values for the configuration keys
(similar to C<defaultProperties> field in the original
C<Config::Properties::new> constructor).

=item C<noread =E<gt> 1>

=item C<mode =E<gt> "write">

stops properties for being read from a file.

=item C<optional =E<gt> 1>

by default an exception is thrown when the configuration file can not
be found or opened, this option makes the constructor succeed anyway.

If the C<file> option is included and defined the constructor dies
even with C<optional> set.

=item C<format =E<gt> $format>

equivalent to calling C<setFormat> method.

=item C<validate =E<gt> ...>

sets conditions that the properties in the configuration file have to
meet.

There are several formats allowed:

=over 4

=item C<validate =E<gt> \&subroutine>

calls the subroutine as

  &subroutine($key, $value, $cfg)

subroutine should call C<$cfg-E<gt>fail($error)> if the pair
C<$key>/C<$value> is not valid or return a normalized value for
C<$value> (usually, just C<$value>) if it is good.

=item C<validate =E<gt> \@array>

only properties in C<@array> are allowed. Regexp are also allowed
inside de array. i.e.:

   validate => [ qr/^Foo\.\w+$/, qw(Bar Doz) ],


=item C<validate =E<gt> \%hash>

C<%hash> allows to set a condition for every property.

There could be an additional C<__default> entry to be applied to
properties that don't have their own entries.

Supported conditions are:

=over 4

=item C<\&subroutine>

calls the subroutine as

  &subroutine($key, $value, $cfg)

subroutine should call C<$cfg-E<gt>fail($error)> if the pair
C<$key>/C<$value> is not valid or return a normalized value for
C<$value> (usually, just C<$value>) if it is good.

=item C<\@array>

property value has to be in C<@array>.

=item C<\%hash>

C<$hash{$value}> has to exist and its value is returned instead of the
original C<$value>.

=item C<qr/regular expression/>

C<$value> has to match the regular expression.

=item C<b> or C<boolean>

C<$value> has to be a boolean value.

Valid true values are C<y>, C<yes>, C<t>, C<true>, C<1>.

Valid false values are C<n>, C<no>, C<f>, C<false>, C<0>, C<>.

Case doesn't matter.

=item C<u> or C<unsigned>

unsigned integer.

=item C<i> or C<integer>

integer

=item C<f>, C<float>, C<n> or C<number>

float number

=item C<s>, C<string>, C<a> or C<any>

anything is ok.

=back

=back

=item C<required =E<gt> [...]>

properties that have to be included in the configuration file. When
someone is missing, an exception is raised telling the user the
reason.

=back

Any option accepted by L<Config::Find> can also be used in C<new>
method.

=item $this-E<gt>save(%opts)

creates a new configuration file with the properties defined in the
object.

C<%opts> are passed to Config::Find to determine the configuration
file name and location.

=item $this-E<gt>fail($error)

method to be called from inside validation subs to report an error. It
appends the filename and the line number to the error and throws an
exception that if uncatched will show the user what went wrong.

=back

=head2 EXPORT

None, this package is OO.


=head1 SEE ALSO

L<Config::Properties>, L<Config::Find>.

=head1 AUTHOR

Salvador Fandi�o, E<lt>sfandino@yahoo.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Salvador Fandi�o

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
