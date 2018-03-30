
#include <sourcemod>
#include <sdktools>


public Plugin myinfo = 
{
	name = "WelcomePlayers",
	author = "AfricanSpaceJesus",
	description = "To welcome pleyrs when they join",
	version = "0.5",
	url = ""
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_welcome", CMD_Welcome);
	
}

public void OnClientPutInServer(int client)
{
		char name [64];
		GetClientName(client, name, sizeof(name));
		PrintToChatAll("Please welcome %s", name);
}

public Action CMD_Welcome(int client, int args)
{
	char name [64];
	char arg1 [64];
	GetCmdArg(1, arg1, sizeof(arg1));
	int target = FindTarget(client, arg1);
	GetClientName(target, name, sizeof(name));
	PrintToChat(client, "You have targeted %s", name);
}
