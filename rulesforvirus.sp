//TODO building path, finish opening file and displaying menu

#include <sourcemod>
#include <sdktools>
#include <clientprefs>


Handle cookie;

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
	cookie=RegClientCookie("readRules", "Used to know if client has agreed to the rules", CookieAccess_Private);
}

public OnClientPutInServer(int client){
	char[128] cook;
	GetClientCookie(client, cookie, cook, sizeof(cook));

	if(!StrEqual(cook, "true")){
		SetEntityMoveType(client, MOVETYPE_NONE);
		buildMenu(client);
	}



}

public buildMenu(int client){

	Handle rules=CreateMenu(rulesCallback);
	SetMenuTitle(rules, "Select Anywhere to Agree");

	//read file and add lines
	char[[PLATFORM_MAX_PATH] path;
	BuildPath(Path_SM, path, sizeof(path),  );
	Handle file=OpenFile();
}

public int rulesCallback(Handle menu, MenuAction action, int client, int item){


}
