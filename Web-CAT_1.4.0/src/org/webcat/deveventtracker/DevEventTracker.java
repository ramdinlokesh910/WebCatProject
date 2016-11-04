/*==========================================================================*\
 |  $Id: DevEventTracker.java,v 1.2 2015/11/30 15:45:37 stedwar2 Exp $
 |*-------------------------------------------------------------------------*|
 |  Copyright (C) 2015 Virginia Tech
 |
 |  This file is part of Web-CAT.
 |
 |  Web-CAT is free software; you can redistribute it and/or modify
 |  it under the terms of the GNU Affero General Public License as published
 |  by the Free Software Foundation; either version 3 of the License, or
 |  (at your option) any later version.
 |
 |  Web-CAT is distributed in the hope that it will be useful,
 |  but WITHOUT ANY WARRANTY; without even the implied warranty of
 |  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 |  GNU General Public License for more details.
 |
 |  You should have received a copy of the GNU Affero General Public License
 |  along with Web-CAT; if not, see <http://www.gnu.org/licenses/>.
\*==========================================================================*/

package org.webcat.deveventtracker;

import org.webcat.core.Subsystem;

//-------------------------------------------------------------------------
/**
 * A subsystem to support IDE-based development data tracking, based on
 * the HackyStats project.
 *
 * @author  Stephen Edwards
 * @author  Last changed by $Author: stedwar2 $
 * @version $Revision: 1.2 $, $Date: 2015/11/30 15:45:37 $
 */
public class DevEventTracker
    extends Subsystem
{
    //~ Constructors ..........................................................

    // ----------------------------------------------------------
    /**
     * Creates a new DevEventTracker subsystem object.
     */
    public DevEventTracker()
    {
        super();
    }
}
