#pragma semicolon 1

#define DEBUG



#include <sourcemod>
#include <sdktools>

#pragma newdecls required

Handle g_enableIDCHECK;

public Plugin myinfo = 
{
	name = "Check Steam ID",
	author = "AfricanSpaceJesus",
	description = "To check the Steam ID of any player on the server",
	version = "0.5",
	url = "https://forums.alliedmods.net/member.php?u=275905"
};

public void OnPluginStart()
{
	
	g_enableCVAR = CreateConVar("sm_steamidchecker", "1", "Controls whether plugin is on or not 1 is on and 0 is off");
	AutoExecConfig(true, "steamidchecker");
	RegAdminCmd("sm_idcheck", CMD_IDCHECK, ADMFLAG_GENERIC, "Checks a players Steam ID Usage <sm_idcheck + name>.");
	
}

public Action:CMD_IDCHECK(int client, int args)
{
	if(GetConVarInt(g_enableIDCHECK)==1)
	{
		if(args==1)
		{
			char name[32];
			char steamID[32];
			int target = FindTarget(client, target);
			GetClientName(target, name, sizeof(name));
			GetClientAuthId(target, AuthId_Steam2, steamID, "32", true);
			PrintToChat(client, "%s has %s", name, steamID);
		}
		else
		{
			char name[32];
			char steamID[32];
			GetClientName(client, name, sizeof(name));
			GetClientAuthId(client, AuthId_Steam2, steamID, "32", true);
			PrintToChat("%s has %s", name, steamID);
		}


	}



}
