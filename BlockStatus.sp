
#include <sourcemod>
#include <sdktools>

#pragma newdecls required

public Plugin myinfo = 
{
	name = "BlockStatus",
	author = "AfricanSpaceJesus",
	description = "To block Source TV",
	version = "1.0",
	url = "https://forums.alliedmods.net/member.php?u=275905"
};

public void OnPluginStart()
{
	AddCommandListener(statusCall, "status");
}

public Action statusCall(int client, const char[] command, int args)
{
	PrintToConsole(client, "SourceTV is blocked");
	return Plugin_Handled;
}