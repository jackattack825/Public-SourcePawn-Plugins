
#include <sourcemod>
#include <sdktools>

#define MAX_BUTTONS 25
#define IN_JUMP			(1 << 1)

new g_LastButtons[MAXPLAYERS+1];
Handle ti;
float loc[MAXPLAYERS + 1][3];


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

}

public OnClientDisconnect_Post(client)
{
    g_LastButtons[client] = 0;
}

public Action:OnPlayerRunCmd(client, &buttons, &impulse, Float:vel[3], Float:angles[3], &weapon)
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

OnButtonPress(client, button)
{
    if(button== IN_JUMP)
    {
   		ti= CreateTimer(0.1, incHeight, client, TIMER_REPEAT);
  	}
}

OnButtonRelease(client, button)
{
    if(button== IN_JUMP)
    {
   		KillTimer(ti, true);
  	}
}

public Action incHeight(Handle timer, int client)
{
	GetClientAbsOrigin(client, loc[client]);
	loc[client][2] += 1.0;
	TeleportEntity(client, loc[client], NULL_VECTOR, NULL_VECTOR);
}