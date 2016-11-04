// Created by Direct to Web's Project Builder Wizard

import com.webobjects.foundation.*;
import com.webobjects.appserver.*;
import com.webobjects.directtoweb.*;

public class Main extends WOComponent {
    public String username;
    public String password;
    public boolean wantsWebAssistant = false;

    public Main(WOContext aContext) {
        super(aContext);
    }

    public WOComponent defaultPage() {
        if (isAssistantCheckboxVisible()) {
            D2W.factory().setWebAssistantEnabled(wantsWebAssistant);
        }
        return D2W.factory().defaultPage(session());
    }

    public boolean isAssistantCheckboxVisible() {
        String s = System.getProperty("D2WWebAssistantEnabled");
        return s == null || NSPropertyListSerialization.booleanForString(s);
    }
}
