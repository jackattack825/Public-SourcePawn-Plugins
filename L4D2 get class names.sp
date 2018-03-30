
#include <sourcemod>
#include <sdktools>

public Plugin myinfo = 
{
	name = "GetZombieClassNames",
	author = "AfricanSpaceJesus",
	description = "",
	version = "0.5",
	url = "http://steamcommunity.com/id/swagattack835/"
};

public void OnPluginStart()
{
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Post);
}

stock getZombieType(client)
{
	int x = GetEntProp(client, Prop_Send, "m_zombieClass");
    return x;
}

public Action Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	int attacker = GetEventInt(event, "attacker");
	int client = GetClientOfUserId(attacker);
	int class = getZombieType(client);
	char class1[64];
	IntToString(class, class1, sizeof(class1));
	PrintToChat(client, ("%i - zombie type has been killed", class1));
}
  