
#include <sourcemod>
#include <sdktools>
#include <chat-processor>
#include <colorvariables>
#include <admin>

char cTags[64][3][128];
char tags[20][3][128];

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
	readFile();
}

public OnClientPostAdminCheck(int client)
{
	setTag(client);
}

/*public Action OnClientSayCommand(int client, const char[] command, const char[] sArgs)
{
	if (!StrEqual(cTags[client][0], "") && StrEqual("say", command))
	{
		char name[128];
		char tag[128];
		char temp[128];
		char final[128];
		GetClientName(client, name, sizeof(name));
		Format(tag, sizeof(tag), "{%s}[%s]", cTags[client][2], cTags[client][1]);
		Format(temp, sizeof(temp), "{default} %s: %s", name, sArgs);
		Format(final, sizeof(final), "%s %s", tag, temp);
		CPrintToChatAll("%s", final);
		
		
	}
	
	return Plugin_Handled;
*/

public Action CP_OnChatMessage(int & author, ArrayList recipients, char[] flagstring, char[] name, char[] message, bool & processcolors, bool & removecolors)
{
	if (IsFakeClient(author))
		return Plugin_Handled;
	Format(name, MAXLENGTH_NAME, "{%s}[%s] %s", cTags[author][2], cTags[author][1], name);
	Format(message, MAXLENGTH_MESSAGE, "{default} %s", message);
	return Plugin_Changed;
} 

public void setTag(int client)
{
	for (int i = 0; i < sizeof(tags); i++)
	{
		int flag = ReadFlagString(tags[i][0]);
		if (GetUserFlagBits(client) & flag == flag)
		{
			cTags[i][0] = tags[i][0];
			cTags[i][1] = tags[i][1];
			cTags[i][2] = tags[i][2];
		}
	}
}

public void readFile()
{
	char path[128];
	BuildPath(Path_SM, path, sizeof(path), "/configs/ChatTags.txt");
	Handle file = OpenFile(path, "r", false);
	char line[128];
	char array[3][128];
	int i = 0;
	
	while (!IsEndOfFile(file) && ReadFileLine(file, line, sizeof(line)))
	{
		ExplodeString(line, " ", array, sizeof(array), sizeof(array[]));
		tags[i][0] = array[0];
		tags[i][1] = array[1];
		tags[i][2] = array[2];
		i++;
	}
	
}
