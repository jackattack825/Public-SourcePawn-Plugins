
#include <sourcemod>
#include <sdktools>
#include <smlib>


public Plugin myinfo = 
{
	name = "StripWeapons",
	author = "AfricanSpaceJesus",
	description = "To strip weapons at the start of a round",
	version = "1",
	url = ""
};

public void OnPluginStart()
{
	HookEvent("round_start", OnRoundStart, EventHookMode_Post);
}

public Action OnRoundStart (Event event, const char[] name, bool dontBroadcast)
{
	for (int i = 1; i < MAXPLAYERS + 1; i++)
	{
		Client_RemoveAllWeapons(i, "", true);
		GivePlayerItem(i, "weapon_knife");
	}
}
