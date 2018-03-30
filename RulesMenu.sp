
#include <sourcemod>
#include <sdktools>
#include <clientprefs>


Handle fileName;
Handle timeToDisplay;
Handle timer1;
Handle ruleMenu;
Handle agreed;


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
	fileName = CreateConVar("sm_filename", "rules.txt", "Name of the file with rules for the menu");
	timeToDisplay = CreateConVar("sm_whentodisplaymenu", "10", "When to display the menu for the client");
	
	agreed = RegClientCookie("agreed", "Has user accepted the rules", CookieAccess_Private);
	
	RegConsoleCmd("sm_rulesmenu", CMD_Rules);
	
	AutoExecConfig(true, "rulesmenu", "sourcemod");
}

public void OnClientPutInServer(int client)
{
	char cook[64];
	GetClientCookie(client, agreed, cook, sizeof(cook));
	if (StrEqual(cook, ""))
	{
		SetEntityMoveType(client, MOVETYPE_NONE);
		timer1 = CreateTimer(GetConVarInt(timeToDisplay), showMenu, client);
	}
}

public Action showMenu(Handle timer, int client)
{
	buildMenu(client);
	DisplayMenu(ruleMenu, client, MENU_TIME_FOREVER);
}

public Action CMD_Rules(int client, int args)
{
	buildMenu(client);
	DisplayMenu(ruleMenu, client, MENU_TIME_FOREVER);
}

public void buildMenu(int client)
{
	ruleMenu = CreateMenu(menuCallback);
	char fileName1[128];
	char line[128];
	char path[128];
	Handle file;
	GetConVarString(fileName, fileName1, sizeof(fileName1));
	
	BuildPath(Path_SM, path, sizeof(path), "configs/%s", fileName1);

	file = OpenFile(path, "r", false);
	
	SetMenuTitle(ruleMenu, "RULES");
	AddMenuItem(ruleMenu, "s", "Select anything to agree");
	
	while (!IsEndOfFile(file) && ReadFileLine(file, line, sizeof(line)))
	{
		AddMenuItem(ruleMenu, "s", ("%s", line));
	}
}

public int menuCallback(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		SetClientCookie(client, agreed, "yes");
		SetEntityMoveType(client, MOVETYPE_ISOMETRIC);
	}
	
} 