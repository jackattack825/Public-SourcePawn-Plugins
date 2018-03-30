
#include <sourcemod>
#include <sdktools>

public Plugin myinfo = 
{
	name = "",
	author = "AfricanSpaceJesus",
	description = "",
	version = "0.5",
	url = "http://steamcommunity.com/id/swagattack835/"
};

public void OnPluginStart()
{
	
}

public void OnClientPutInServer(int client)
{
	
	char[128] name;
	GetClientName(client, name, sizeof(name));
	char[256] info;
	Format(info, sizeof(info), "Please welcome %s to the server", name);
	PrintToChatAll(info);

}


