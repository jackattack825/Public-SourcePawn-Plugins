#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "AfricanSpaceJesus"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <cstrike>
//#include <sdkhooks>
Handle g_enableCVAR;

#pragma newdecls required

EngineVersion g_Game;

public Plugin myinfo = 
{
	name = "Welcome Players",
	author = PLUGIN_AUTHOR,
	description = "To welcome players to the server",
	version = PLUGIN_VERSION,
	url = "https://forums.alliedmods.net/member.php?u=275905"
};

public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if(g_Game != Engine_CSGO && g_Game != Engine_CSS)
	
	{
		SetFailState("This plugin is for CSGO/CSS only.");	
	}
	g_enableCVAR= CreateConVar("sm_welcome", 1, "Controls whether welcome message is shown or not 1 is on and 0 is off");
	RegAdminCmd("sm_welcome", welcomePlayer(client)), ADMFLAG_CUSTOM6, "Welomes a player to the server Usage <sm_welcome>.");
	
}
public void OnClientPutInServer(int client)
{
		if(GetConVarBool(g_enableCVAR)==1))
		{
			welcomePlayer();
		}


}

public Action:welcomePlayer(client)
{
	if(FindConVar("sm_welcome")==1)
		{
		new String:name[32] = GetClientName(client, name, sizeOf(name));
		PrintToChatAll("Please welcome %s to the server", name);
		}
	
}
