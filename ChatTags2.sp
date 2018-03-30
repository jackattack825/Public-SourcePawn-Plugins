
#include <sourcemod>
#include <sdktools>
#include <chat-processor>
#include <colorvariables>
#include <admin>
 
#pragma semicolon 1
#pragma newdecls required
 
ArrayList list;
 
bool g_bHasTag[MAXPLAYERS + 1];
char g_sClientTag[MAXPLAYERS + 1][32];
char g_sClientColor[MAXPLAYERS + 1][32];
 
public Plugin myinfo =
{
    name = "",
    author = "AfricanSpaceJesus",
    description = "",
    version = "0.5",
    url = "http://steamcommunity.com/id/swagattack835/"
};
 
public void OnMapStart()
{
    if (list == null)
    {
        list = new ArrayList(256);
    }
    else
    {
        list.Clear();
    }
   
    loadArrayList();
}
 
public void OnClientPostAdminCheck(int client)
{
    setClientTag(client);
}
 
public void OnClientConnected(int client)
{
    ResetVars(client);
}
 
public void OnClientDisconnect(int client)
{
    ResetVars(client);
}
 
void ResetVars(int client)
{
    g_bHasTag[client] = false;
    g_sClientColor[client] = "";
    g_sClientTag[client] = "";
}
 
public Action CP_OnChatMessage(int & author, ArrayList recipients, char[] flagstring, char[] name, char[] message, bool & processcolors, bool & removecolors)
{
    if (IsFakeClient(author))
        return Plugin_Handled;
   
    if (g_bHasTag[author])
    {
        Format(name, MAXLENGTH_NAME, "{%s}[%s] %s", g_sClientColor[author], g_sClientTag[author], name);
        Format(message, MAXLENGTH_MESSAGE, "{default} %s", message);
       
        processcolors = true;
        removecolors = false;
    }
 
    return Plugin_Changed;
}
 
public void setClientTag(int client)
{
    char line[256];
    char temp[3][128];
    int i = 0;
    bool found = false;
   
    while (i < list.Length && !found)
    {
        list.GetString(i, line, sizeof(line));
        ExplodeString(line, " ", temp, sizeof(temp), sizeof(temp[]));
       
        int flag = ReadFlagString(temp[0]);
        if ((GetUserFlagBits(client) & flag) == flag)
        {
            strcopy(g_sClientTag[client], sizeof(g_sClientTag[]), temp[1]);
            strcopy(g_sClientColor[client], sizeof(g_sClientColor[]), temp[2]);
            found = true;
        }
        else
        {
            i++;
        }
    }
}
 
public void loadArrayList()
{
    char path[128];
    BuildPath(Path_SM, path, sizeof(path), "/configs/ChatTags.txt");
    Handle file = OpenFile(path, "r", false);
    char line[128];
    int i = 0;
   
    while (!IsEndOfFile(file) && ReadFileLine(file, line, sizeof(line)))
    {
        list.PushString(line);
        i++;
    }
}