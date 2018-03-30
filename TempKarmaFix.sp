
#include <sourcemod>
#include <sdktools>
#include <console>
#include <clients>
#include <admin>

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

public OnClientAuthorized(int client, const char[] auth)
{
	char name[128];
	GetClientName(client, name, sizeof(name));
	ServerCommand("sm_setkarma %s 100", name);
}
