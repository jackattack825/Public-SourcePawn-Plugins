
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
	RegAdminCmd("sm_country", CMD_Country);
	RegAdminCmd("sm_check", CMD_Check);
}

public Action CMD_Country(int client, int args)
{

}

public Action CMD_Check(int client, int args)
{

}
