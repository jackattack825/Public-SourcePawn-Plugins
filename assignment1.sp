#pragma semicolon 1

#define DEBUG

// TODO figure out country and fix aray index issues

#include <sourcemod>
#include <sdktools>
#include <geoip>



Handle hMenu;

public Plugin myinfo = 
{
	name = "Menu Test Assignment#1", 
	author = "AfricanSpaceJesus", 
	description = "Display a users name, steamid, and ip, in a menu", 
	version = "0.5", 
	url = "https://forums.alliedmods.net/member.php?u=275905"
};

public void OnPluginStart()
{
	
	RegAdminCmd("sm_getinfo", CMD_USERCHECK, ADMFLAG_GENERIC, "Checks a players Steam ID, name, and IP Address Usage <sm_checkuser +name>");
	RegAdminCmd("sm_country", CMD_Country, ADMFLAG_GENERIC);
	
}

public Action CMD_USERCHECK(int client, int args)
{
	if (args > 0)
	{
		char name[32], name1[32];
		char arg1[120];
		char steamID[32], steamID1[32];
		char ip[40], ip1[40];
		char coun[100];
		GetCmdArg(1, arg1, sizeof(arg1));
		int target = FindTarget(client, arg1, true, false);
		
		if (!IsClientInGame(target) || target == 0)
			return Plugin_Handled;
		
		GetClientName(target, name, sizeof(name));
		GetClientAuthId(target, AuthId_Steam2, steamID, sizeof(steamID), true);
		GetClientIP(target, ip, sizeof(ip), true);
		GeoipCountry(ip, coun, sizeof(coun));
		hMenu = CreateMenu(menuCallBack);
		SetMenuTitle(hMenu, "User Information");
		Format(name1, sizeof(name1), name);
		AddMenuItem(hMenu, "Name", name1);
		Format(steamID1, sizeof(steamID1), steamID);
		AddMenuItem(hMenu, "steamID", steamID1);
		Format(ip1, sizeof(ip1), ip);
		AddMenuItem(hMenu, "ip", ip1);
		AddMenuItem(hMenu, "coun", coun);
		SetMenuExitButton(hMenu, true);
		DisplayMenu(hMenu, client, 30);
		
	}
	else
	{
		char name[32], name1[32];
		char steamID[32], steamID1[32];
		char ip[40], ip1[40];
		char coun[100];
		GetClientName(client, name, sizeof(name));
		GetClientAuthId(client, AuthId_Steam2, steamID, sizeof(steamID), true);
		GetClientIP(client, ip, sizeof(ip), true);
		GeoipCountry(ip, coun, sizeof(coun));
		hMenu = CreateMenu(menuCallBack);
		SetMenuTitle(hMenu, "User Information");
		Format(name1, sizeof(name1), name);
		AddMenuItem(hMenu, "Name", name1);
		Format(steamID1, sizeof(steamID1), steamID);
		AddMenuItem(hMenu, "steamID", steamID1);
		Format(ip1, sizeof(ip1), ip);
		AddMenuItem(hMenu, "ip", ip1);
		AddMenuItem(hMenu, "coun", coun);
		SetMenuExitButton(hMenu, true);
		DisplayMenu(hMenu, client, 30);
	}
	
	return Plugin_Handled;
}


public Action CMD_Country(int client, int args)
{
	char ip[40];
	char coun[100];
	char arg1[120];
	int target = FindTarget(client, arg1, true, false);
	GetCmdArg(1, arg1, sizeof(arg1));
	GetClientIP(target, ip, sizeof(ip), true);
	GeoipCountry(ip, coun, sizeof(coun));
	
	hMenu = CreateMenu(menuCallBack);
	SetMenuTitle(hMenu, "User Country");
	AddMenuItem(hMenu, "coun", coun);
	
	return Plugin_Handled;
}


public menuCallBack(Handle h_menu, MenuAction action, client, int position)
{
	if (action == MenuAction_Select)
	{
		
	}
	else if (action == MenuAction_End)
		CloseHandle(hMenu);
} 