#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "AfricanSpaceJesus"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <cstrike>
//#include <sdkhooks>

#pragma newdecls required

EngineVersion g_Game;

public Plugin myinfo = 
{
	name = "Welcome Players",
	author = AfricanSpaceJesus,
	description = "To welcome players to the server",
	version = 1,
	url = "prgaming.net"
};

public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if(g_Game != Engine_CSGO && g_Game != Engine_CSS)
	{
		SetFailState("This plugin is for CSGO/CSS only.");	
	}
	RegAdminCmd(sm_welcome, welcomePlayer, client);
}
public void OnClientPutInServer(client)
{
	welcomePlayer();


}

public void welcomePlayer(client)
{
	new name = GetClientName();
	PrintToChatAll("Welcome %s to the server", name);
	
}
