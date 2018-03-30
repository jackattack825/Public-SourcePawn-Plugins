#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <multicolors>
#include <clientprefs>
#include <KZTimer>

#pragma semicolon 1

// global handles
new Handle:rCookie = INVALID_HANDLE;

// global booleans
bool accept[MAXPLAYERS+1];

public Plugin myinfo = 
{ 
	name		= "Rules", 
	author	  	= "JWL", 
	description = "Displays the Rules", 
	version	 	= "2.0", 
	url		 	= "http://climbcove.com/" 
}; 

public void OnPluginStart()
{
	// commands
	RegConsoleCmd("sm_rules", CMD_Rules);
	
	// hook player spawn
	HookEvent("player_spawn", Event_OnPlayerSpawn, EventHookMode_Post);
	
	// create client cookie for storing accept / deny
	rCookie = RegClientCookie("accept_cookie", "Stores accept/deny.", CookieAccess_Private);
	
	// adds late-loading support for caching cookies
	for (new i = MaxClients; i > 0; --i)
	{
		if (!AreClientCookiesCached(i))
		{
			continue;
		}
		
		OnClientCookiesCached(i);
	}
}

public OnClientConnected(client)
{
	// set accept to false, to make sure new players need to read rules
	accept[client] = false;
}

public Action CMD_Rules(int client, int args)
{
	// send Rules menu to client on !rules
	ShowRules(client);
	
	return Plugin_Handled;
}

public Action:Event_OnPlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	// create timer to send !rules menu to client, fix to get around Climbers Menu pop-up
	CreateTimer(5.0, StartMsgTimer, client,TIMER_FLAG_NO_MAPCHANGE);			
}

public Action:StartMsgTimer(Handle:timer, any:client)
{
	// return if not a client
	if(client == 0)
		return;
	
	// show the rules menu to the client after 5 seconds
	if (IsClientConnected(client) && IsClientInGame(client) && !IsFakeClient(client))
	{
		if(IsPlayerAlive(client))
		{
			if(!accept[client])
				ShowRules(client);
		}
	}		
}

public void ShowRules(int client)
{
	// create rules menu
	Handle rules = CreateMenu(RulesHandler);
	
	// little hack to create non-selectable menu items w/o numbers
	SetMenuTitle(rules, "> > Server Rules < <\n-No mic spamming.\n-No scripting.\n-No advertising other servers.\n-No racism/sexism.\n-No religious/political talks.\n-No harassing admins.");
	AddMenuItem(rules, "ACCEPT", "Accept");
	AddMenuItem(rules, "DENY", "Deny");
	
	// freeze player when rules menu is activated
	FreezePlayer(client); 
	
	// do not have exit button, so client has to choose accept / deny
	SetMenuExitButton(rules, false);
	
	KZTimer_StopUpdatingOfClimbersMenu(client);
	
	DisplayMenu(rules, client, MENU_TIME_FOREVER); 
}
 

public RulesHandler(Handle:menu, MenuAction:action, client, item)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			// grab menu items
			decl String:item_name[64];
			GetMenuItem(menu, item, item_name, sizeof(item_name));
			
			if (StrEqual(item_name, "ACCEPT"))
			{
				// string for storing choice
				char choice[8];
				
				accept[client] = true;
				
				// convert accept to string, store in cookie
				IntToString(accept[client], choice, sizeof(choice));
				SetClientCookie(client, rCookie, choice);
				
				CloseHandle(menu);  
				
				// unfreeze player
				UnFreezePlayer(client);
				
				// open climbers menu back up after client accepts rules
				ClientCommand(client, "sm_menu");
			}
			else if (StrEqual(item_name, "DENY"))
			{
				// string for storing choice 
				char wchoice[8];
				
				accept[client] = false;
				
				// convert accept to string, store in cookie
				IntToString(accept[client], wchoice, sizeof(wchoice));
				SetClientCookie(client, rCookie, wchoice);
				
				CloseHandle(menu);
				
				// kick client from server for denying rules
				KickClient(client, "You didn't accept the rules"); 
			}
		}
	}
}

public OnClientCookiesCached(client)
{
	// string for storing choice
	char sChoice[8];
	
	// grab the cookie
	GetClientCookie(client, rCookie, sChoice, 8);
	
	// if accept is '1', client has already accepted rules
	if(StrEqual(sChoice, "1"))
		accept[client] = true;
}  

public FreezePlayer(client)
{
	// set movement value to 0, client can't move
	SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 0.0);
}

public UnFreezePlayer(client)
{
	// set movement value to 1, client can move
	SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", 1.0);
}