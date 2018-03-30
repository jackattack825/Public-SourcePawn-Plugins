#include <sourcemod>
#include <sdktools>



public Plugin myinfo = 
{
	name = "ShowCommands",
	author = "AfricanSpaceJesus",
	description = "To show the commands that can be used",
	version = "1",
	url = "https://forums.alliedmods.net/member.php?u=275905"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_commands", CMD_Commands);
}

public Action CMD_Commands(int client, int args)
{
	char sPath[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, sizeof(sPath), "configs/commands.cfg");
	
	if (!FileExists(sPath))
	{
		LogError("[CBS] Error: Can not find commands file %s", sPath);
		SetFailState("[CBS] Error: Can not find commands file %s", sPath);
	}
	
	File file = OpenFile(sPath, "r");
	char buffer[256];
	while (!file.EndOfFile() && file.ReadLine(buffer, sizeof(buffer)))
	{
		int i = -1;
		i = FindCharInString(buffer, '\n', true);
		
		if(i != -1) 
			buffer[i] = '\0';
			
		TrimString(buffer);
		PrintToChat(client, ("%s", buffer));
	
	}
	return Plugin_Handled;
}