
#include <sourcemod>
#include <sdktools>



public Plugin myinfo = 
{
	name = "HideGOTV",
	author = "AfricanSpaceJesus",
	description = "To block Source TV",
	version = "1.0",
	url = "https://forums.alliedmods.net/member.php?u=275905"
};

public void OnPluginStart()
{
	AddCommandListener(statusCall, "status");
	RegConsoleCmd("status", dispInfo);
}

public Action statusCall(int client, const char[] command, int args)
{
	return Plugin_Handled;
}

public Action dispInfo(int client, int args)
{
	PrintToConsole(client, "hostname: fc csgo\nversion : 1.35.6.4 secure \nudp/ip  : 188.166.76.76:27015 \nos      :  Linux \ntype    :  community dedicated");
	char mapName[64];
	GetCurrentMap(mapName, sizeof(mapName));
	PrintToConsole(client, "map     : %s ", mapName);
	int bots;
	for (int i = 1; i < MaxClients; i++)
		{
			if(IsFakeClient(i))
				bots++;
		}
	int humans = MaxClients - bots;
	PrintToConsole(client, "players : %i humans, %i bots (%i/0 max)", humans, bots, MaxClients);

	PrintToConsole(client, "%s  %-40s %s", "UserID", "AuthID", "Name");

	decl String:sAuthID[64];

	for (int i = 1; i <= MaxClients; i++)
	{
		if (!IsClientConnected(i))
			continue;
		
		if (!GetClientAuthString(i, sAuthID, sizeof(sAuthID), true))
		{
			if (GetClientAuthString(i, sAuthID, sizeof(sAuthID), false))
			{
				Format(sAuthID, sizeof(sAuthID), "%s (Not Validated)", sAuthID);
			}
			else
			{
				strcopy(sAuthID, sizeof(sAuthID), "Unknown");
			}
		}
		
		PrintToConsole(client, "%6d  %-40s %N", GetClientUserId(i), sAuthID, i);
	}
	
}