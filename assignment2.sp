#pragma semicolon 1

#define DEBUG



#include <sourcemod>
#include <sdktools>



Handle g_enableColorMenu;
Handle colorMenu;

public Plugin myinfo = 
{
	name = "Menu Test Assignment#2",
	author = "AfricanSpaceJesus",
	description = "Displays a menu to change your player model color",
	version = "0.5",
	url = "https://forums.alliedmods.net/member.php?u=275905"
};

public void OnPluginStart()
{
	g_enableColorMenu = CreateConVar("sm_afr_colormenu", "1", "Controls whether plugin is on or not 1 is on and 0 is off");
	AutoExecConfig(true, "colormenu");
	
	
}
public Action HookPlayerChat(int client, const char[] command, int args)
{
    if (!IsValidClient(client))
        return Plugin_Continue;
 
    char szText[256];
    GetCmdArg(1, szText, sizeof(szText));
     if(GetConVarBool(g_enableColorMenu))
    {
    	if(StrEqual(szText, "colormenu"))
    	{
 			colorMenu = CreateMenu(menuCallBack);
        	SetMenuTitle(colorMenu, "Change your player model color");
        	SetMenuPagination(colorMenu, 4);
        	AddMenuItem(colorMenu, "Red", "Red");
        	AddMenuItem(colorMenu, "Green", "Green");
        	AddMenuItem(colorMenu, "Blue", "Blue");
        	AddMenuItem(colorMenu, "Default", "Default");
        	SetMenuExitButton(colorMenu, true);
        	DisplayMenu(colorMenu, client, 30);
    	}
	}
}

/*public Action:OnClientSayCommand(int client, const char[] command, const char[] sArgs) {
    if(GetConVarBool(g_enableColorMenu))
    {
    	if (StrEqual(command, "colormenu", false))
    	{
        	colorMenu = CreateMenu(menuCallBack);
        	SetMenuTitle(colorMenu, "Change your player model color");
        	SetMenuPagination(colorMenu, 4);
        	AddMenuItem(colorMenu, "Red", "Red");
        	AddMenuItem(colorMenu, "Green", "Green");
        	AddMenuItem(colorMenu, "Blue", "Blue");
        	AddMenuItem(colorMenu, "Default", "Default");
        	SetMenuExitButton(colorMenu, true);
        	DisplayMenu(colorMenu, client, 30);
    	}
    	
    }
}*/  


public menuCallBack(Handle h_menu, MenuAction action, client, int position)
{
	if(action== MenuAction_Select)
	{
		char ident[30];
		
		GetMenuItem(colorMenu, position, ident, sizeof(ident));
		
		if(StrEqual(ident, "Red"))
		{
			SetEntityRenderColor(client, 255, 0, 0, 255);
			PrintToChat(client, "You have changed your player model to be red");
		}	
		else if(StrEqual(ident, "Blue"))
		{
			SetEntityRenderColor(client, 0, 0, 255, 255);
			PrintToChat(client, "You have changed your player model to be blue");
		}	
		else if(StrEqual(ident, "Green"))
		{
			SetEntityRenderColor(client, 0, 255, 0 ,255);
			PrintToChat(client, "You have changed your player model to be green");
		}	
		else if(StrEqual(ident, "Default"))
		{
			SetEntityRenderColor(client, 255, 255, 255, 255);
			PrintToChat(client, "You have changed your player model to be default");
		}	
	}
	else if(action== MenuAction_End)
		CloseHandle(colorMenu);
}