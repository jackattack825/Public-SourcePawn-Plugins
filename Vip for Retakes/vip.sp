
#include <sourcemod>
#include <sdktools>
#include <colors_codes>
#include <cstrike>

Handle roundsTilRifles;
Handle time;
int roundCounter;

public Plugin myinfo = 
{
	name = "Vip Addons",
	author = "AfricanSpaceJesus",
	description = "",
	version = "1.0",
	url = "http://steamcommunity.com/id/swagattack835/"
};

public void OnPluginStart()
{
	RegAdminCmd("sm_ak", CMD_AK, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_m4a1", CMD_M4A1, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_m4a4", CMD_M4A4, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_awp", CMD_AWP, ADMFLAG_CUSTOM6);
	
	HookEvent("round_start", roundStart, EventHookMode_Post);
	
	time = CreateTimer(30.0, timer_Call, TIMER_REPEAT);
	
	AutoExecConfig(true, "vip.cfg", "sourcemod")
	roundsTilRifles= CreateConVar("sm_roundstilrifles", "1");
}

public bool isVip(int client)
{
	int adminId;
	adminId = GetUserAdmin(client);
	return GetAdminFlag(adminId, Admin_Custom6, Access_Effective);
}

public Action CMD_AK(int client, int args) 
{ 
    if(IsPlayerAlive(client) && GetConVarInt(roundsTilRifles) < roundCounter) 
    { 
        int entity = GetPlayerWeaponSlot(client, 0); 
        if(entity != -1) 
            AcceptEntityInput(entity, "Kill");         

        RequestFrame(RequestFrame_AK, client); 
    } 
         
    return Plugin_Handled; 
} 

public void RequestFrame_AK(int client) 
{ 
    GivePlayerItem(client, "weapon_ak47"); 
}  

public Action CMD_M4A1(int client, int args) 
{ 
    if(IsPlayerAlive(client) && GetConVarInt(roundsTilRifles) < roundCounter) 
    { 
        int entity = GetPlayerWeaponSlot(client, 0); 
        if(entity != -1) 
            AcceptEntityInput(entity, "Kill");         

        RequestFrame(RequestFrame_M4A1, client); 
    } 
         
    return Plugin_Handled; 
} 

public void RequestFrame_M4A1(int client) 
{ 
    GivePlayerItem(client, "weapon_m4a1_silencer"); 
}  

public Action CMD_M4A4(int client, int args) 
{ 
    if(IsPlayerAlive(client) && GetConVarInt(roundsTilRifles) < roundCounter) 
    { 
        int entity = GetPlayerWeaponSlot(client, 0); 
        if(entity != -1) 
            AcceptEntityInput(entity, "Kill");         

        RequestFrame(RequestFrame_M4A4, client); 
    } 
         
    return Plugin_Handled; 
} 

public void RequestFrame_M4A4(int client) 
{ 
    GivePlayerItem(client, "weapon_m4a1"); 
}

public Action CMD_AWP(int client, int args) 
{ 
    if(IsPlayerAlive(client) && GetConVarInt(roundsTilRifles) < roundCounter) 
    { 
        int entity = GetPlayerWeaponSlot(client, 0); 
        if(entity != -1) 
            AcceptEntityInput(entity, "Kill");         

        RequestFrame(RequestFrame_AWP, client); 
    } 
         
    return Plugin_Handled; 
} 

public void RequestFrame_AWP(int client) 
{ 
    GivePlayerItem(client, "weapon_awp"); 
}


public Action roundStart(Event event, const char[] name, bool dontBroadcast)
{
	roundCounter++;
	
	for (int client = 1; client < MAXPLAYERS; client++)
	{
		if(isVip(client) && IsPlayerAlive(client))
		{
			GivePlayerItem(client, "weapon_hegrenade");
			GivePlayerItem(client, "weapon_smokegrenade");
			if(GetClientTeam(client)==2)
				GivePlayerItem(client, "weapon_molotov");
			else if(GetClientTeam(client)==3)
				GivePlayerItem(client, "weapon_incgrenade");
		}
	}
}

public Action timer_Call(Handle timer, Handle hndl)
{
	for (int i = 1; i < MAXPLAYERS; i++)
	{
		if(isVip(i))
			CPrintToChat(i, "{red} [RBE] {green} You can choose your weapon now by writing !awp, !ak, !m4a1, !m4a4");
	}
}
