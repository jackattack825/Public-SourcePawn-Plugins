#include <sourcemod>
#include <sdktools>

public Plugin myinfo = 
{
	name = "Bring", 
	author = "Wicked", 
	description = "Brings player to the admin", 
	version = "1", 
	url = ""
};

public void OnPluginStart()
{
	RegAdminCmd("sm_bring", Command_Bring, ADMFLAG_SLAY, "Teleport a player to you");
}

public Action Command_Bring(client, args)
{
	
	float vec1[3];
	float vec2[3];
	float x;
	float y = 10000;
	int z;
	
	for (int i = 0; i < MAXPLAYERS && i != client; i++)
	{
		GetClientAbsOrigin(client, vec1);
		GetClientAbsOrigin(i, vec2);
		x = GetVectorDistance(vec1, vec2);
		if (x < y)
		{
			y = x;
			z = i;
		}
	}
	TeleportEntity(z, vec1, NULL_VECTOR, NULL_VECTOR);
	return Plugin_Handled;
} 