#define DEBUG


#include <sourcemod>
#include <sdktools>
#include <colors_codes>

Handle g_Menu;
Handle g_Admins;
Handle g_Comms;
Handle g_enableCVAR;

public Plugin myinfo = 
{
	name = "1v1UpdateNotifier",
	author = "AfricanSpaceJesus",
	description = "Show updates to the 1v1 server",
	version = "1.4",
	url = "prgaming.net"
};

public void OnPluginStart()
{
	g_enableCVAR = CreateConVar("sm_show_menus", "1", "Controls whether menus are shown or not 1 is on and 0 is off");
	RegConsoleCmd("sm_updates", CMD_showUpdates);
	RegConsoleCmd("sm_commands", CMD_showCommands);
	RegConsoleCmd("sm_adminlist", CMD_showAdmins);
}

public int menuCallBack(Handle h_menu, MenuAction action, int client, int position)
{
	if(action== MenuAction_End)
		CloseHandle(g_Menu);
}

public int commsCallBack(Handle h_menu, MenuAction action, int client, int position)
{
	if(action== MenuAction_End)
		CloseHandle(g_Comms);
}

public int adminMenuCallBack(Handle h_menu, MenuAction action, int client, int position)
{
	if(action== MenuAction_End)
		CloseHandle(g_Admins);
}

public Action CMD_showUpdates(int client, int args)
{
	if(GetConVarBool(g_enableCVAR))
	{
		BuildMenu();
		DisplayMenu(g_Menu, client, 45);
	}	
	return Plugin_Continue;
}

public Action CMD_showCommands(int client, int args)
{
	if(GetConVarBool(g_enableCVAR))
	{
		buildComms();
		DisplayMenu(g_Comms, client, 45);
	}	
	return Plugin_Continue;
}

public Action CMD_showAdmins(int client, int args)
{
	if(GetConVarBool(g_enableCVAR))
	{
		buildAdmins();
		DisplayMenu(g_Admins, client, 45);
	}	
	return Plugin_Continue;
}



public void BuildMenu()
{
		g_Menu = CreateMenu(menuCallBack);
		SetMenuTitle(g_Menu, "Recent Updates");
		AddMenuItem(g_Menu, "", "Added 'Recent Updates' Notification");
		AddMenuItem(g_Menu, "", "Nametag <jake is gay> has been added referencing this server's Manager");
		AddMenuItem(g_Menu, "", "Added/Removed Various Maps");
		AddMenuItem(g_Menu, "", "Added Deagle Only Rounds");
		AddMenuItem(g_Menu, "", "Raffling has been Re-Added");
		AddMenuItem(g_Menu, "", "Math Questions have been Re-Added");
		AddMenuItem(g_Menu, "", "Type <!updates> to view this menu");
		SetMenuExitButton(g_Menu, true);
}

public void buildComms()
{
		g_Comms = CreateMenu(commsCallBack);
		SetMenuTitle(g_Comms, "Commands");
		AddMenuItem(g_Comms, "", "!guns (choose your guns/rounds)");
		AddMenuItem(g_Comms, "", "!ws (choose what skins to use)");
		AddMenuItem(g_Comms, "", "!knife (choose what knife to use)");
		AddMenuItem(g_Comms, "", "!updates (shows recent updates)");
		AddMenuItem(g_Comms, "", "!store/!shop (buy nametags/name colors ect.)");
		AddMenuItem(g_Comms, "", "!credits ( show many credits you own)");
		AddMenuItem(g_Comms, "", "!raffle (gamble your store credits)");
		AddMenuItem(g_Comms, "", "rtv (rock the vote, vote to change the map)");
		AddMenuItem(g_Comms, "", "nominate (choose a map to appear when voting)");
		AddMenuItem(g_Comms, "", "!challenge (challenge a player to a fight next round)");
		AddMenuItem(g_Comms, "", "nextmap (shows the next map to be played)");
		AddMenuItem(g_Comms, "", "Type <!commands> to view this menu");
		SetMenuExitButton(g_Comms, true);
}

public void buildAdmins()
{
		g_Admins = CreateMenu(adminMenuCallBack);
		SetMenuTitle(g_Admins, "Managers/Developers");
		AddMenuItem(g_Admins, "", "jake (Head Admin/Manager)");
		AddMenuItem(g_Admins, "", "African Space Jesus (Developer)");
		AddMenuItem(g_Admins, "", "as' (Developer)");
		AddMenuItem(g_Admins, "", "Type <!adminlist> to view this menu");
		SetMenuExitButton(g_Admins, true);
}