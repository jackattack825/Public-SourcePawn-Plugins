

#include <sourcemod>
#include <sdktools>
#include <colors_codes>

#define IN_USE      (1 << 5)
#define MAX_BUTTONS 25

new g_LastButtons[MAXPLAYERS+1];

bool isFrozen[MAXPLAYERS + 1];

int cts;
int ts;
int ctLeft;
int tLeft;
int counter;

Handle CVAR_Dist;
Handle timer1;

public Plugin myinfo = 
{
	name = "FreezeTag",
	author = "AfricanSpaceJesus",
	description = "FreezeTag gamemode",
	version = "0.5",
	url = "https://forums.alliedmods.net/member.php?u=275905"
};

public void OnPluginStart()
{
	AddCommandListener(checkFreeze, "+attack");
	AddCommandListener(checkFreeze, "+attack2");
	AddCommandListener(attemptUnFreeze, "+use");
	
	HookEvent("player_death", setFreeze, EventHookMode_Pre);
	HookEvent("player_team", changeTeamInt, EventHookMode_Post);
	
	CVAR_Dist = CreateConVar("sm_afr_distance", "10", "Minimum distance needed to unfreeze teammate");
}




public void OnClientDisconnect(int client)
{
	isFrozen[client] = false;
}

public OnClientDisconnect_Post(client)
{
	g_LastButtons[client] = 0;
}


//Command Listeners

public Action checkFreeze(int client, const char[] command, int argc)
{
	if(isFrozen[client]==true)
		return Plugin_Handled;
	return Plugin_Continue;
}

public Action attemptUnFreeze(int client, const char[] command, int argc)
{
	int r=closestFrozenTeam(client);
	if(r==-1)
		return;
	timer1 = CreateTimer(5.0, unFreeze, r);
}

//Hook Events

public Action setFreeze(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientUserId(GetEventInt(event, "userid"));
	isFrozen[client] = true; 
	char nameClient [64];
	GetClientName(client, nameClient, sizeof(nameClient));
	SetEntityHealth(client, 100);
	SetEntityMoveType(client, MOVETYPE_NONE);
	SetEntityRenderColor(client, 0, 0, 255, 255);
	if(GetClientTeam(client)==3)
	{
		ctLeft--;
		CPrintToChatAll("{blue} %s has been frozen. %i ct's remain of %i total", nameClient, ctLeft, cts);
	}
	else if (GetClientTeam(client)==2)
	{
		tLeft--;
		CPrintToChatAll("{red} %s has been frozen. %i t's remain of %i total", nameClient, tLeft, ts);
	}
	return Plugin_Handled;
}

public Action changeTeamInt(Event event, const char[] name, bool dontBroadcast)
{
	//switch from t to ct and not a disconnect
	if (GetEventInt(event, "team")==3 && GetEventBool(event, "disconnect")==false && GetEventInt(event, "oldteam")==2)
	{
		ts--;
		tLeft--;
		cts++;
		ctLeft++;
	}
	//switch from ct to t and not a disconnect
	else if (GetEventInt(event, "team")==2 && GetEventBool(event, "disconnect")==false && GetEventInt(event, "oldteam")==3)
	{
		cts--;
		ctLeft--;
		ts++;
		tLeft++;
	}
	//switches from spectate to ct and not a disconnect
	else if (GetEventInt(event, "team")==3 && GetEventBool(event, "disconnect")==false && GetEventInt(event, "oldteam")==1)
	{
		cts++;
		ctLeft++;
	}
	//switch from spectate to t and not a disconnect
	else if (GetEventInt(event, "team")==2 && GetEventBool(event, "disconnect")==false && GetEventInt(event, "oldteam")==1)
	{
		ts++;
		tLeft++;
	}
	//player disconnect, was t
	else if (GetEventInt(event, "oldteam")==2 && GetEventBool(event, "disconnect"))
	{
		ts--;
		tLeft--;
	}
	//player disconnect, was ct
	else if (GetEventInt(event, "oldteam")==3 && GetEventBool(event, "disconnect"))
	{
		cts--;
		ctLeft--;
	}
}

//Timer Callbacks

public Action unFreeze(Handle timer, int r)
{
	SetEntityMoveType(r, MOVETYPE_ISOMETRIC);
//Set to old color?	SetEntityRenderColor(
}

public Action addTime(Handle timer, int counter)
{
	counter++;
}

//Useful Functions

public int closestFrozenTeam(int client)
{
	float cli [3];
	float targ [3];
	float dist;
	int teamMate;
	
	GetClientAbsOrigin(client, cli);
	for (int i = 1; i < MaxClients && i != client; i++)
	{
		GetClientAbsOrigin(i, targ);
		dist = GetVectorDistance(cli, targ);
		
		if(dist<=GetConVarInt(CVAR_Dist) && GetClientTeam(client)== GetClientTeam(i) && isFrozen[i] && !isFrozen[client])
			teamMate = i;
	}
	if(teamMate==0)
		return -1;
	return teamMate;
}

public Action OnPlayerRunCmd(client, &buttons, &impulse, Float:vel[3], Float:angles[3], &weapon)
{
    for (new i = 0; i < MAX_BUTTONS; i++)
    {
        new button = (1 << i);
        
        if ((buttons & button))
        {
            if (!(g_LastButtons[client] & button))
            {
                OnButtonPress(client, button);
            }
        }
        else if ((g_LastButtons[client] & button))
        {
            OnButtonRelease(client, button);
        }
    }
    
    g_LastButtons[client] = buttons;
    
    return Plugin_Continue;
   }

OnButtonPress(int client, IN_USE)
{
	int r=closestFrozenTeam(client);
	if(r==-1)
		return;
	while(counter !=5)
		timer1 = CreateTimer(1.0, addTime, counter);
	if(counter==5)
	{
		SetEntityMoveType(r, MOVETYPE_ISOMETRIC);
		SetEntityRenderColor(r, 0, 0, 0, 0);
		isFrozen[r] = false;
		if(GetClientTeam(r)==2)
		{
			char nameClient [64];
			GetClientName(client, nameClient, sizeof(nameClient));
			tLeft++;
			CPrintToChatAll("{red} %s has been unfrozen. %i t's remain of %i total", nameClient, tLeft, ts);
		}
		if(GetClientTeam(r)==3)
		{
			char nameClient [64];
			GetClientName(client, nameClient, sizeof(nameClient));
			ctLeft++;
			CPrintToChatAll("{blue} %s has been unfrozen. %i ct's remain of %i total", nameClient, ctLeft, cts);
		}
	}
}

OnButtonRelease(int client, IN_USE)
{
	int r=closestFrozenTeam(client);
	if(r==-1)
		return;
	if(counter!=5)
		counter = 0;
	else if(counter==5)
	{
		SetEntityMoveType(r, MOVETYPE_ISOMETRIC);
		SetEntityRenderColor(r, 0, 0, 0, 0);
		isFrozen[r] = false;
		if(GetClientTeam(r)==2)
		{
			char nameClient [64];
			GetClientName(client, nameClient, sizeof(nameClient));
			tLeft++;
			CPrintToChatAll("{red} %s has been unfrozen. %i t's remain of %i total", nameClient, tLeft, ts);
		}
		if(GetClientTeam(r)==3)
		{
			char nameClient [64];
			GetClientName(client, nameClient, sizeof(nameClient));
			ctLeft++;
			CPrintToChatAll("{blue} %s has been unfrozen. %i ct's remain of %i total", nameClient, ctLeft, cts);
		}
	}
}
 
