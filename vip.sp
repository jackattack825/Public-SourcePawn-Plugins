
#include <sourcemod>
#include <sdktools>
#include <cstrike>

Handle time;
int roundCounter;
bool allowRif = false;


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
	RegAdminCmd("sm_p90", CMD_P90, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_mp7", CMD_MP7, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_famas", CMD_FAMAS, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_galil", CMD_GALIL, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_scout", CMD_SSG, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_deagle", CMD_DEAGLE, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_tec9", CMD_TEC9, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_p250", CMD_P250, ADMFLAG_CUSTOM6);
	RegAdminCmd("sm_cz", CMD_CZ, ADMFLAG_CUSTOM6);
	
	HookEvent("round_start", roundStart, EventHookMode_Post);
	HookEvent("round_end", roundEnd, EventHookMode_Post);
	//HookEvent("player_chat", playerChat, EventHookMode_Post);
	
	time = CreateTimer(120.0, timer_Call, TIMER_REPEAT);
	
	AutoExecConfig(true, "vip", "sourcemod");
	
}

public bool isVip(int client)
{
	int adminId;
	adminId = GetUserAdmin(client);
	return GetAdminFlag(adminId, Admin_Custom6, Access_Effective);
}

public Action CMD_AK(int client, int args)
{
	if (IsPlayerAlive(client) && allowRif)
	{
		int entity = GetPlayerWeaponSlot(client, 0);
		if (entity != -1)
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
	if (IsPlayerAlive(client) && allowRif)
	{
		int entity = GetPlayerWeaponSlot(client, 0);
		if (entity != -1)
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
	if (IsPlayerAlive(client) && allowRif)
	{
		int entity = GetPlayerWeaponSlot(client, 0);
		if (entity != -1)
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
	if (IsPlayerAlive(client) && allowRif)
	{
		int entity = GetPlayerWeaponSlot(client, 0);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_AWP, client);
	}
	
	return Plugin_Handled;
}

public void RequestFrame_AWP(int client)
{
	GivePlayerItem(client, "weapon_awp");
}

//New Weapon CMDS

public Action CMD_P90(int client, int args)
{
	if (IsPlayerAlive(client) && allowRif)
	{
		int entity = GetPlayerWeaponSlot(client, 0);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_P90, client);
	}
	
	return Plugin_Handled;
}

public Action CMD_MP7(int client, int args)
{
	if (IsPlayerAlive(client) && allowRif)
	{
		int entity = GetPlayerWeaponSlot(client, 0);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_MP7, client);
	}
	
	return Plugin_Handled;
}

public Action CMD_FAMAS(int client, int args)
{
	if (IsPlayerAlive(client) && allowRif)
	{
		int entity = GetPlayerWeaponSlot(client, 0);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_FAMAS, client);
	}
	
	return Plugin_Handled;
}

public Action CMD_GALIL(int client, int args)
{
	if (IsPlayerAlive(client) && allowRif)
	{
		int entity = GetPlayerWeaponSlot(client, 0);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_GALIL, client);
	}
	
	return Plugin_Handled;
}

public Action CMD_SSG(int client, int args)
{
	if (IsPlayerAlive(client) && allowRif)
	{
		int entity = GetPlayerWeaponSlot(client, 0);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_SSG, client);
	}
	
	return Plugin_Handled;
}

public Action CMD_DEAGLE(int client, int args)
{
	if (IsPlayerAlive(client))
	{
		int entity = GetPlayerWeaponSlot(client, 1);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_DEAGLE, client);
	}
	
	return Plugin_Handled;
}

public Action CMD_TEC9(int client, int args)
{
	if (IsPlayerAlive(client))
	{
		int entity = GetPlayerWeaponSlot(client, 1);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_TEC9, client);
	}
	
	return Plugin_Handled;
}

public Action CMD_P250(int client, int args)
{
	if (IsPlayerAlive(client))
	{
		int entity = GetPlayerWeaponSlot(client, 1);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_P250, client);
	}
	
	return Plugin_Handled;
}

public Action CMD_CZ(int client, int args)
{
	if (IsPlayerAlive(client))
	{
		int entity = GetPlayerWeaponSlot(client, 1);
		if (entity != -1)
			AcceptEntityInput(entity, "Kill");
		
		RequestFrame(RequestFrame_CZ75A, client);
	}
	
	return Plugin_Handled;
}

//New Req Frames

public void RequestFrame_P250(int client)
{
	GivePlayerItem(client, "weapon_p250");
}

public void RequestFrame_DEAGLE(int client)
{
	GivePlayerItem(client, "weapon_deagle");
}

public void RequestFrame_TEC9(int client)
{
	GivePlayerItem(client, "weapon_tec9");
}

public void RequestFrame_CZ75A(int client)
{
	GivePlayerItem(client, "weapon_cz75a");
}

public void RequestFrame_MP7(int client)
{
	GivePlayerItem(client, "weapon_mp7");
}

public void RequestFrame_P90(int client)
{
	GivePlayerItem(client, "weapon_p90");
}

public void RequestFrame_FAMAS(int client)
{
	GivePlayerItem(client, "weapon_famas");
}

public void RequestFrame_GALIL(int client)
{
	GivePlayerItem(client, "weapon_galilar");
}

public void RequestFrame_SSG(int client)
{
	GivePlayerItem(client, "weapon_ssg08");
}

public Action roundStart(Event event, const char[] name, bool dontBroadcast)
{
	if (roundCounter >= 2 && !allowRif)
		allow_Rif();
	for (int client = 1; client < MaxClients; client++)
	{
		if (isVip(client))
		{
			CS_SetClientClanTag(client, "VIP");
			if (IsPlayerAlive(client) && allowRif)
			{
				GivePlayerItem(client, "weapon_hegrenade");
				GivePlayerItem(client, "weapon_smokegrenade");
				GivePlayerItem(client, "weapon_flashbang");
				if (GetClientTeam(client) == 2)
					GivePlayerItem(client, "weapon_molotov");
				else if (GetClientTeam(client) == 3)
					GivePlayerItem(client, "weapon_incgrenade");
				if (GetClientArmor(client) != 100)
					GivePlayerItem(client, "item_assaultsuit");
			}
		}
	}
}

public Action roundEnd(Event event, const char[] name, bool dontBroadcast)
{
	roundCounter++;
}


public Action OnClientSayCommand(int client, const char[] command, const char[] sArgs)
{
	//char mes[128];
	//GetEventString(event, "text", mes, sizeof(mes));
	//int user = GetEventInt(event, "userid");
	//int client = GetClientOfUserId(user);
	
	if (StrEqual(sArgs, "ak") || StrEqual(sArgs, "AK"))
	{
		if (IsPlayerAlive(client) && allowRif && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_AK, client);
		}
	}
	
	else if (StrEqual(sArgs, "m4a1") || StrEqual(sArgs, "M4A1"))
	{
		if (IsPlayerAlive(client) && allowRif && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_M4A1, client);
		}
	}
	
	else if (StrEqual(sArgs, "awp") || StrEqual(sArgs, "AWP"))
	{
		if (IsPlayerAlive(client) && allowRif && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_AWP, client);
		}
	}
	
	else if (StrEqual(sArgs, "m4a4") || StrEqual(sArgs, "M4A4"))
	{
		if (IsPlayerAlive(client) && allowRif && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_M4A4, client);
		}
	}
	
	else if (StrEqual(sArgs, "p90") || StrEqual(sArgs, "P90"))
	{
		if (IsPlayerAlive(client) && allowRif && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_P90, client);
		}
	}
	
	else if (StrEqual(sArgs, "mp7") || StrEqual(sArgs, "MP7"))
	{
		if (IsPlayerAlive(client) && allowRif && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_MP7, client);
		}
	}
	
	else if (StrEqual(sArgs, "famas") || StrEqual(sArgs, "FAMAS"))
	{
		if (IsPlayerAlive(client) && allowRif && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_FAMAS, client);
		}
	}
	
	else if (StrEqual(sArgs, "galil") || StrEqual(sArgs, "GALIL"))
	{
		if (IsPlayerAlive(client) && allowRif && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_GALIL, client);
		}
	}
	
	else if (StrEqual(sArgs, "scout") || StrEqual(sArgs, "SCOUT"))
	{
		if (IsPlayerAlive(client) && allowRif && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_SSG, client);
		}
	}
	
	else if (StrEqual(sArgs, "deagle") || StrEqual(sArgs, "DEAGLE"))
	{
		if (IsPlayerAlive(client) && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_DEAGLE, client);
		}
	}
	
	else if (StrEqual(sArgs, "tec9") || StrEqual(sArgs, "TEC9"))
	{
		if (IsPlayerAlive(client) && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_TEC9, client);
		}
	}
	
	else if (StrEqual(sArgs, "p250") || StrEqual(sArgs, "P250"))
	{
		if (IsPlayerAlive(client) && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_P250, client);
		}
	}
	
	else if (StrEqual(sArgs, "cz") || StrEqual(sArgs, "CZ"))
	{
		if (IsPlayerAlive(client) && isVip(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_CZ75A, client);
		}
	}
	
}

public Action timer_Call(Handle timer, Handle hndl)
{
	PrintToChatAll("[Server Name] You can choose your weapon now by writing <sm_ak>, <AK>, <ak>");
}

public void allow_Rif()
{
	allowRif = true;
	PrintToChatAll("[Server Name] VIP can now use rifles.");
}
