#include <sourcemod>
#include <sdktools>

public Plugin myinfo = 
{
	name = "RuleMenu",
	author = "Wicked",
	description = "When client joins they get a menu popup of PRG server rules and if they dont accept they get kicked",
	version = "1",
	url = ""
};

public void OnPluginStart()
{
	
}

public void OnClientPutInServer(client)
{
	Handle h_menu= CreateMenu(h_menu);
 	SetMenuTitle(h_menu, "General Rules	DO NOT AFK or AFK Spin for credits in any server.NO racism. NO racist names allowed either. Racism is defined as DO NOT disrespect, insult, badger, harass, or bully any member, V.I.P., or admin.NO cheating, ghosting, or exploiting glitches.DO NOT advertise any kind of product or other community in the PRG servers.NO impersonation of staff members on any of the PRG servers.DO NOT mic spam, chat spam, or gun spam (lags server).NO scamming of any form or in any way.DO NOT trade/give credits away to any player under any circumstanceDo NOT delay in any kind of way.PLEASE use English when using your microphone.We DO NOT tolerate any kind of threats to the server.We DO NOT tolerate any kind of joke related to cheating or hacking in the servers.Disobeying an admin's order for an invalid reason will NOT be tolerated.");
 	AddMenuItem(h_menu, "I Agree To These Terms");
 	AddMenuItem(h_menu, "I Dont Agree To These Terms");
 	SetMenuPagination(h_menu, 2);
 	SetMenuExitBackButton(h_menu, false);	
};

public Action MenuCallBack (Handle menu, MenuAction action, int client, int position)
{
	if(action == MenuAction_Select)
	{
		char Item[20]

	if(Item, "I Agree To These Terms")
	{
	MenuAction_End
	}
	else if(Item, "I Dont Agree To These Terms")
	{
	KickClient(client, "Must Agree To Server Rules In Order To Play");
	}
}