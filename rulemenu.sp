#include <sourcemod>
#include <sdktools>
#include <clientprefs>

Handle c_allow;

public Plugin myinfo = 
{
	name = "tests",
	author = "tt",
	description = "tt",
	version = "0.5",
	url = ""
};

public void OnPluginStart()
{
	c_allow = RegClientCookie("sm_allow", "", CookieAccess_Private);
}

public void OnClientPutInServer(int client)
{
	char cookie [30];
	GetClientCookie(client, c_allow, cookie, sizeof(cookie));
	if(StrEqual("INVALID_HANDLE", cookie))
	{
		SetEntityMoveType(client, MOVETYPE_NONE);
		Handle h_menu= CreateMenu(menuCallbackS);
 		SetMenuTitle(h_menu, "General Rules	DO NOT AFK or AFK Spin for credits in any server.NO racism. NO racist names allowed either. Racism is defined as DO NOT disrespect, insult, badger, harass, or bully any member, V.I.P., or admin.NO cheating, ghosting, or exploiting glitches.DO NOT advertise any kind of product or other community in the PRG servers.NO impersonation of staff members on any of the PRG servers.DO NOT mic spam, chat spam, or gun spam (lags server).NO scamming of any form or in any way.DO NOT trade/give credits away to any player under any circumstanceDo NOT delay in any kind of way.PLEASE use English when using your microphone.We DO NOT tolerate any kind of threats to the server.We DO NOT tolerate any kind of joke related to cheating or hacking in the servers.Disobeying an admin's order for an invalid reason will NOT be tolerated.");
 		AddMenuItem(h_menu, "agree", "Do you agree to these terms");
 		AddMenuItem(h_menu, "noagree", "Do you not agree to these terms");
 		DisplayMenu(h_menu, client, MENU_TIME_FOREVER);
	}
	
	char cookie2 [30];
	GetClientCookie(client, c_allow, cookie2, sizeof(cookie2));
	
	if (StrEqual("true", cookie2))
	{
		SetEntityMoveType(client, MOVETYPE_ISOMETRIC);
	}
 	
}

public int menuCallback(Handle menu, MenuAction action, int client, int position)
{
	if(action == MenuAction_Select)
	{
		char item[20];
		GetMenuItem(menu, position, item, sizeof(item));
		if(StrEqual(item, "agree"))
		{
			SetClientCookie(client, c_allow, "true");
		}
		
		else if(StrEqual(item, "noagree"))
		{
			KickClient(client, "You have disagreed to the rules");
		}
	}
}