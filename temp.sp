
#include <sourcemod>
#include <sdktools>

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

public Action CP_OnChatMessage(int & author, ArrayList recipients, char[] flagstring, char[] name, char[] message, bool & processcolors, bool & removecolors)
{
	if (IsFakeClient(author))
		return Plugin_Handled;
	Format(name, sizeof(name), "{%s}[%s] %s", cTags[author][2], cTags[author][1], name);
	Format(message, sizeof(message), "{default} %s", message);
	return Plugin_Changed;
} 