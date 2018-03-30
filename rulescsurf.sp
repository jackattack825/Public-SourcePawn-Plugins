#pragma semicolon 1

#define DEBUG


Handle g_cookie_ReadRules

#include <sourcemod>
#include <sdktools>



public Plugin myinfo = 
{
	name = "CombatSurf Force View Rules",
	author = "AfricanSpaceJesus",
	description = "Force players to agree to server rules before playing",
	version = "0.5",
	url = "prgaming.net"
};

public void OnPluginStart()
{
	g_cookie_ReadRules = RegClientCookie("readRules", CookieAccess_Private);
	
}

public Action OnClientPutInServer(int client)
{
	if(AreClientCookiesCached(client)
	{
		char[12] cookieValue;
		GetClientCookie(client, g_cookie_ReadRules, cookieValue, sizeof(cookieValue))


	}
	
	SetClientCookie(client, g_cookie_ReadRules, "1");



}