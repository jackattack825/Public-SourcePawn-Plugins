#pragma semicolon 1
/**
 * =============================================================================
 * ImDawe plugin
 * www.neogames.eu -> Plugin / Mod request section
 * SourceMod (C)2004-2007 AlliedModders LLC.  All rights reserved.
 * =============================================================================
 */
#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <colors>
 
#define VERSION "1.0"

#define MAXCATEGORIES 32
#define MAXITEMS 32
#define MAXBINDS 512

#define TEAM_SPECTATOR		1
#define TEAM_SURVIVOR		2
#define TEAM_INFECTED		3

enum ZombieTypes
{
	zSmoker 	= 1,
	zBoomer 	= 2,
	zHunter 	= 3,
	zSpitter 	= 4,
	zJockey		= 5,
	zCharger	= 6,
	zTank	= 8
};

new g_ZombieHealts[ZombieTypes];

new String:gsString[128];
new String:g_iMenuCategories[MAXCATEGORIES][128];
new String:g_iMenuItems[MAXCATEGORIES][MAXITEMS][5][128];
new String:g_iMenuGroupCategories[MAXCATEGORIES][128];
new String:g_iMenuZombieItems[4][MAXITEMS][7][128];
new String:g_iMenuSurvivorItems[MAXITEMS][4][128];
new String:g_iMenuGroupItems[MAXCATEGORIES][MAXITEMS][5][128];


new Int:g_iClientSelectedCategory[MAXPLAYERS+1];
new Int:g_iClientSelectedGroupCategory[MAXPLAYERS+1];
new Int:g_PlayerMoney[MAXPLAYERS+1];
new Int:g_MaxClients;

new Handle:g_hSetClass = INVALID_HANDLE;
new Handle:g_hCreateAbility = INVALID_HANDLE;
new any:g_oAbility;
new Handle:g_hRoundRespawn = INVALID_HANDLE;
new Handle:g_hGameConf	= INVALID_HANDLE;
new Handle:g_tVomit[MAXPLAYERS+1] = INVALID_HANDLE;
new Handle:g_BoomerDamage[MAXPLAYERS+1];
enum ItemTypes
{
	SurvivorItem,
	GroupItem,
	ZombieItem
	
};
new p_Vomit[MAXPLAYERS+1] = -1;
new p_Huntered[MAXPLAYERS+1] = 0;
new p_Jockey[MAXPLAYERS+1] = 0;
new p_Spitter[MAXPLAYERS+1] = 0;
new p_Smoker[MAXPLAYERS+1] = 0;

new p_TankHits[MAXPLAYERS+1]=0;
new p_TankBurns[MAXPLAYERS+1]=0;
new g_CommonZombieKilled[MAXPLAYERS+1] = 0;
new ReviveBeginned[MAXPLAYERS+1] = false;

enum e_PtsVars
{
	// For killing si
	sSmokerHS,
	sSmokerKill,
	sBoomerHS,
	sBoomerKill,
	sHunterHS,
	sHunterKill,
	sJockeyHS,
	sJockeyKill,
	sChargerHS,
	sChargerKill,
	sWitchHS,
	sWitchDmgHs,
	sWitchDmgCount,
	sWitchDmg,
	sWitchKill,
	sTankHS,
	sTankKill,
	sTankBurn,
	sTankBurnNum,
	sSpitterHS,
	sSpitterKill,
	
	// For killing common
	sCommonKillNum,
	sCommonKill,
	
	// For help
	sHeal,
	sDefib,
	sRevive,
	sReviveLedge,
	
	// Boomer
	zBoomerVomit,
	zBoomerExpVomit,
	zBoomerAssist,
	zBoomerAssistDamage,
	zBoomerDamage,
	// Jockey
	zJockeyRide,
	zJockeyJumpNum,
	zJockeyJump,
	// Hunter
	zHunterDamageNum,
	zHunterDamage,
	zHunterPounched,
	// Smoker
	zSmokerGrab,
	zSmokerDamageNum,
	zSmokerDamage,
	// Charger
	zChargerImpact,
	zChargerCarry,
	zChargerDamage,
	// Spitter
	zSpitterDamageNum,
	zSpitterDamage,
	zSpitterClawDamage,
	// Tank
	zTankDamage,
	
	// Special
	sGasCanPour,
	zPlayerIncap,
	zPlayerKill,
	sTankHit,
	sTankHitNumber,
	bStartPts
};

new g_PtsSettings[e_PtsVars];
new String:g_pLastBought[MAXPLAYERS+1][128];
new String:g_PlayerHordeSpawnModel[128];
new Int:g_PlayerHordeSpawnNumber;
new Int:g_WitchDmgCount[MAXPLAYERS+1];

new Handle:SQL_Hnd = INVALID_HANDLE;

#include "buy/hooks.sp"
//#include "buy/horde_menu.sp"
#include "buy/menus_base.sp"
#include "buy/menus_survivor.sp"
#include "buy/menus_zombie.sp"
#include "buy/point_system.sp"
#include "buy/binds.sp"
#include "buy/sql_base.sp"


public Plugin:myinfo =
{
	name = "[L4D2] Store",
	author = "ImDawe",
	description = "Store for Left 4 Dead",
	version = VERSION,
	url = "http://www.neogames.eu/"
};

public OnPluginStart()
{
	InitSql();
	g_MaxClients = GetMaxClients();
	InitGameConf();
	
	InitPointSystem();
	
	g_ZombieHealts[zSmoker]		= FindConVar("z_gas_health");
	g_ZombieHealts[zBoomer] 	= FindConVar("z_exploding_health");
	g_ZombieHealts[zHunter] 	= FindConVar("z_hunter_health");
	g_ZombieHealts[zSpitter]	= FindConVar("z_spitter_health");
	g_ZombieHealts[zJockey]		= FindConVar("z_jockey_health");
	g_ZombieHealts[zCharger]	= FindConVar("z_charger_health");
	g_ZombieHealts[zTank]	= FindConVar("z_tank_health");
	
	// Player commands
	// Display Store menu
	RegConsoleCmd("sm_buy", 	BuyMenu, 	"Display store menu");
	RegConsoleCmd("sm_shop", 	BuyMenu, 	"Display store menu");
	RegConsoleCmd("sm_usepoints", 	BuyMenu, 	"Display store menu");
	// Display points
	RegConsoleCmd("sm_points", 	ShowPoints, "Display points");
	RegConsoleCmd("sm_pts", 	ShowPoints, "Display points");
	RegConsoleCmd("sm_cash", 	ShowPoints, "Display points");
	// Rebuy last item
	RegConsoleCmd("sm_repeatbuy", 	RebuyItem, "Display points");
	RegConsoleCmd("sm_rebuy", 	RebuyItem, "Display points");
	
	// Admin commands
	//RegAdminCmd("sm_horde_menu", HordeMenu, ADMFLAG_RCON, "Adding credit for user");
	RegAdminCmd("sm_buy_addpoints", AddPts, ADMFLAG_RCON, "Adding credit for user");
	RegAdminCmd("sm_buy_addpoints_all", AddPtsAll, ADMFLAG_RCON, "Add credit for everyone");
	RegAdminCmd("sm_buy_reload_configs", ReloadConfigs, ADMFLAG_RCON, "Reload config files at all.");
	RegAdminCmd("sm_buy_listpts", ListCredits, ADMFLAG_RCON, "List credits for users");
	
	// Store adds
	CreateTimer(60.0, StoreAdds, INVALID_HANDLE, TIMER_REPEAT);
	// Horde spawner
	CreateTimer(5.0, HordeSpawner, INVALID_HANDLE, TIMER_REPEAT);
	// Checking binds
	AddCommandListener(LookForBindEvent);
}

public Action:RebuyItem(client, args)
{
	FakeClientCommand(client, g_pLastBought[client]);
}

public Action:ListCredits(client, args)
{
	new String:replydata[512];
	decl String:cname[128];
	for(new i=1;i<=g_MaxClients;++i)
	{
		if(IsValidClient(i))
		{
		GetClientName(i, cname, 128);
		Format(replydata, 512, "%s$%d : %s\n", replydata, g_PlayerMoney[i], cname);
		}
	}
	ReplyToCommand(client, replydata);
}

public OnClientAuthorized(client, const String:auth[])
{
	if(IsFakeClient(client))
	{
		//PrintToServer("[DEBUG] It is a bot. OnClientAuthorized");
		return;
	}
	if(CheckHandle(SQL_Hnd))
	{
		g_PlayerMoney[client]=-1;
		Format(gsString, 128, "SELECT points, extra FROM users WHERE steamid='%s'", auth);
		SQL_TQuery(SQL_Hnd, OnClientAuthorizedHandle, gsString, client);
	}else{
		PrintToServer("[ERROR] SQL not connected.");
	}
}

public OnClientDisconnect(client)
{
	if(IsClientInGame(client) && IsFakeClient(client))
	{
		//PrintToServer("[DEBUG] It is a bot. OnClientDisconnect");
		return;
	}
	if(CheckHandle(SQL_Hnd) && g_PlayerMoney[client] != -1)
	{
		decl String:auth[64];
		GetClientAuthString(client, auth, 64);
		Format(gsString, 128, "UPDATE users SET points='%d' WHERE steamid='%s'", g_PlayerMoney[client], auth);
		SQL_FastQuery(SQL_Hnd, gsString);
		g_PlayerMoney[client]=-1;
	}else{
		PrintToServer("[ERROR] SQL not connected.");
	}

}

public Action:StoreAdds(Handle:timer, any:data)
{
	CPrintToChatAll("{green}[STORE]{default} You can get extra items! Just write {green}!buy{default} into chat");
}

public Action:ReloadConfigs(client, args)
{
	ReplyToCommand(client, "Reloading configuration files...");
	ReadConfigs();
}

public Action:AddPtsAll(client, args)
{
	if(GetCmdArgs() == 0)
	{
		ReplyToCommand(client, "sm_buy_addpoints_all <points>");
	}
	decl buff[32];
	GetCmdArg(1, buff, 32);
	for(new i=1;i<g_MaxClients;++i)
	{
		if(IsValidClient(i))
		{
			AddMoneyToUser(i, StringToInt(buff), "from {green}ADMIN{default}");
		}
		
	}
}

public Action:AddPts(client, args)
{
	if(GetCmdArgs() == 0)
	{
		ReplyToCommand(client, "sm_buy_addpoints <steamid> <points>");
	}
	new String:SteamID[64];
	new String:ArgString[256];
	GetCmdArgString(ArgString, 256);
	new buff[2][128];
	ExplodeString(ArgString, " ", buff, 2, 128);
	for(new i=1;i<g_MaxClients;++i)
	{
		if(IsClientInGame(i) && !IsFakeClient(i))
		{
			GetClientAuthString(i, SteamID, 64);
			if(StrEqual(SteamID, buff[0]))
			{
				AddMoneyToUser(i, StringToInt(buff[1]), "from {green}ADMIN{default}");
			}
			
		}
		
	}
}

public OnMapStart()
{
	InitSql();
	PrecacheModel("models/props_fortifications/orange_cone001_reference.mdl");
	ReadConfigs();
	g_PlayerHordeSpawnNumber=0;
}

public ReadConfigs()
{
	BuildPath(Path_SM, gsString, sizeof(gsString), "configs/store_items.cfg");
	new Int:c=0;
	new Handle:kv = CreateKeyValues("Store");
	FileToKeyValues(kv, gsString);
	KvGotoFirstSubKey(kv);
	do
	{
		KvGetSectionName(kv, g_iMenuCategories[c], 64);
		if(KvGotoFirstSubKey(kv))
			{
				new i=0;
				do
				{
					KvGetSectionName(kv, g_iMenuItems[c][i][0], 64);
					KvGetString(kv, "cost", g_iMenuItems[c][i][1], 64);
					KvGetString(kv, "bind", g_iMenuItems[c][i][2], 64);
					KvGetString(kv, "item", g_iMenuItems[c][i][3], 64);
					KvGetString(kv, "type", g_iMenuItems[c][i][4], 64, "1");
					++i;
				}while(KvGotoNextKey(kv));
				KvGoBack(kv);
			}
	++c;
	}while(KvGotoNextKey(kv));
	CloseHandle(kv);
	
	BuildPath(Path_SM, gsString, sizeof(gsString), "configs/store_groupitems.cfg");
	c=0;
	kv = CreateKeyValues("Store");
	FileToKeyValues(kv, gsString);
	KvGotoFirstSubKey(kv);
	do
	{
		KvGetSectionName(kv, g_iMenuGroupCategories[c], 64);
		if(KvGotoFirstSubKey(kv))
			{
				new i=0;
				do
				{
					KvGetSectionName(kv, g_iMenuGroupItems[c][i][0], 64);
					KvGetString(kv, "cost", g_iMenuGroupItems[c][i][1], 64);
					KvGetString(kv, "bind", g_iMenuGroupItems[c][i][2], 64);
					KvGetString(kv, "item", g_iMenuGroupItems[c][i][3], 64);
					KvGetString(kv, "type", g_iMenuGroupItems[c][i][4], 64, "1");
					++i;
				}while(KvGotoNextKey(kv));
				KvGoBack(kv);
			}
	++c;
	}while(KvGotoNextKey(kv));
	CloseHandle(kv);
	
	BuildPath(Path_SM, gsString, sizeof(gsString), "configs/store_survivors.cfg");
	c=0;
	kv = CreateKeyValues("Zombies");
	FileToKeyValues(kv, gsString);
	KvGotoFirstSubKey(kv);
	do
	{
		new i=0;
		do
		{
			KvGetSectionName(kv, g_iMenuSurvivorItems[i][3], 64);
			KvGetString(kv, "name", g_iMenuSurvivorItems[i][0], 64);
			KvGetString(kv, "cost", g_iMenuSurvivorItems[i][1], 64);
			KvGetString(kv, "bind", g_iMenuSurvivorItems[i][2], 64);
			++i;
		}while(KvGotoNextKey(kv));
		KvGoBack(kv);
	}while(KvGotoNextKey(kv));
	CloseHandle(kv);
	
	BuildPath(Path_SM, gsString, sizeof(gsString), "configs/store_zombies.cfg");
	c=0;
	kv = CreateKeyValues("Zombies");
	FileToKeyValues(kv, gsString);
	KvGotoFirstSubKey(kv);
	do
	{
		KvGetSectionName(kv, gsString, 64);
		if(StrEqual(gsString, "Basics"))
		{
			c=0;
		}
		if(StrEqual(gsString, "BecomeSpecial"))
		{
			c=1;
		}
		if(StrEqual(gsString, "SpecialSpawn"))
		{
			c=2;
		}
		if(StrEqual(gsString, "HordeSpawn"))
		{
			c=3;
		}
		if(KvGotoFirstSubKey(kv))
			{
				new i=0;
				
				do
				{
					KvGetSectionName(kv, g_iMenuZombieItems[c][i][0], 64);
					KvGetString(kv, "cost", g_iMenuZombieItems[c][i][1], 64);
					KvGetString(kv, "bind", g_iMenuZombieItems[c][i][2], 64);
					switch(c)
					{
						case 0:
							KvGetString(kv, "command", g_iMenuZombieItems[c][i][3], 64);
						case 1:
							KvGetString(kv, "zombieid", g_iMenuZombieItems[c][i][3], 64);
						case 2:
							KvGetString(kv, "zombieid", g_iMenuZombieItems[c][i][3], 64);
						case 3:
						{
							KvGetString(kv, "number", g_iMenuZombieItems[c][i][3], 64);
							KvGetString(kv, "model", g_iMenuZombieItems[c][i][4], 64);
							if(PrecacheModel(g_iMenuZombieItems[c][i][4]) == 0)
								PrintToServer("[ERROR] Model precache failed \"%s\"!", g_iMenuZombieItems[c][i][4]);
						}
					}
					++i;
				}while(KvGotoNextKey(kv));
				KvGoBack(kv);
			}
	}while(KvGotoNextKey(kv));
	CloseHandle(kv);
	
	// Zombies no cfg, just suicide/extra hp, respawn as another, change zombie type, aspawn zombie bot horde
	
	
	BuildPath(Path_SM, gsString, sizeof(gsString), "configs/store_points.cfg");
	kv = CreateKeyValues("Points");
	FileToKeyValues(kv, gsString);
	KvGotoFirstSubKey(kv);
	g_PtsSettings[sSmokerHS]			=	KvGetNum(kv, "smooker_headshot");
	g_PtsSettings[sSmokerKill]			=	KvGetNum(kv, "smoker_kill");
	g_PtsSettings[sBoomerHS]			=	KvGetNum(kv, "boomer_headshot");
	g_PtsSettings[sBoomerKill]			=	KvGetNum(kv, "boomer_kill");		
	g_PtsSettings[sHunterHS]			=	KvGetNum(kv, "hunter_headshot");
	g_PtsSettings[sHunterKill]			=	KvGetNum(kv, "hunter_kill");
	g_PtsSettings[sJockeyHS]			=	KvGetNum(kv, "jockey_headshot");
	g_PtsSettings[sJockeyKill]			=	KvGetNum(kv, "jockey_kill");
	g_PtsSettings[sSpitterHS]			=	KvGetNum(kv, "spitter_headshot");
	g_PtsSettings[sSpitterKill]			=	KvGetNum(kv, "spitter_kill");
	g_PtsSettings[sChargerHS]			=	KvGetNum(kv, "charger_headshot");
	g_PtsSettings[sChargerKill]			=	KvGetNum(kv, "charger_kill");
	g_PtsSettings[sWitchHS]				=	KvGetNum(kv, "witch_headshot");
	g_PtsSettings[sWitchKill]			=	KvGetNum(kv, "witch_kill");
	g_PtsSettings[sWitchDmgHs]			=	KvGetNum(kv, "witch_damage_hs");
	g_PtsSettings[sWitchDmgCount]		=	KvGetNum(kv, "witch_damage_num");
	g_PtsSettings[sWitchDmg]			=	KvGetNum(kv, "witch_damage");
	g_PtsSettings[sTankHS]				=	KvGetNum(kv, "tank_headshot");
	g_PtsSettings[sTankKill]			=	KvGetNum(kv, "tank_kill");
	g_PtsSettings[sTankBurn]			=	KvGetNum(kv, "tank_burn");
	g_PtsSettings[sTankBurnNum]			=	KvGetNum(kv, "tank_burn_number");
	g_PtsSettings[sCommonKillNum]		=	KvGetNum(kv, "common_kill_number");
	g_PtsSettings[sCommonKill]			=	KvGetNum(kv, "common_kill");
	g_PtsSettings[sHeal]				=	KvGetNum(kv, "heal_friend");
	g_PtsSettings[sDefib]				=	KvGetNum(kv, "defib_friend");
	g_PtsSettings[sRevive]				=	KvGetNum(kv, "revive_friend");
	g_PtsSettings[sReviveLedge]			=	KvGetNum(kv, "revive_friend_ledge");
	g_PtsSettings[zBoomerVomit]			=	KvGetNum(kv, "boomer_vomit");
	g_PtsSettings[zBoomerExpVomit]		=	KvGetNum(kv, "boomer_vomit_explode");
	g_PtsSettings[zBoomerAssist]		=	KvGetNum(kv, "boomer_assist");
	g_PtsSettings[zBoomerAssistDamage]	=	KvGetNum(kv, "boomer_assist_damage");
	g_PtsSettings[zBoomerDamage]		=	KvGetNum(kv, "boomer_damage");
	g_PtsSettings[zJockeyRide]			=	KvGetNum(kv, "jockey_ride");
	g_PtsSettings[zJockeyJumpNum]		=	KvGetNum(kv, "jockey_damage_number");
	g_PtsSettings[zJockeyJump]			=	KvGetNum(kv, "jockey_damage");
	g_PtsSettings[zHunterDamageNum]		=	KvGetNum(kv, "hunter_punched");
	g_PtsSettings[zHunterDamage]		=	KvGetNum(kv, "hunter_damage_number");
	g_PtsSettings[zHunterPounched]		=	KvGetNum(kv, "hunter_damage");
	g_PtsSettings[zSmokerGrab]			=	KvGetNum(kv, "smoker_grab");
	g_PtsSettings[zSmokerDamageNum]		=	KvGetNum(kv, "smoker_damage_number");
	g_PtsSettings[zSmokerDamage]		=	KvGetNum(kv, "smoker_damage");
	g_PtsSettings[zChargerImpact]		=	KvGetNum(kv, "charger_impact");
	g_PtsSettings[zChargerCarry]		=	KvGetNum(kv, "charger_carry");
	g_PtsSettings[zChargerDamage]		=	KvGetNum(kv, "charger_damage");
	g_PtsSettings[zSpitterDamageNum]	=	KvGetNum(kv, "spitter_damage_number");
	g_PtsSettings[zSpitterDamage]		=	KvGetNum(kv, "spitter_damage");
	g_PtsSettings[zSpitterClawDamage]	=	KvGetNum(kv, "spitter_damage_claw");
	g_PtsSettings[zTankDamage]			=	KvGetNum(kv, "tank_damage");
	g_PtsSettings[zPlayerIncap]			=	KvGetNum(kv, "player_incap");
	g_PtsSettings[zPlayerKill]			=	KvGetNum(kv, "player_kill");
	g_PtsSettings[sGasCanPour]			=	KvGetNum(kv, "gascanpour");
	g_PtsSettings[sTankHit]				=	KvGetNum(kv, "tank_hit");
	g_PtsSettings[sTankHitNumber]		=	KvGetNum(kv, "tank_hit_number");
	g_PtsSettings[bStartPts]			=	KvGetNum(kv, "start_points");
	CloseHandle(kv);
}


public Action:BuyMenu(client, args)
{
	if (!IsClientInGame(client))
		return Plugin_Handled;
	if(args > 0)
	{
		decl String:buffer[128];
		GetCmdArg(1, buffer, 128);
		LookForBindEvent(client, buffer, 0);
		return Plugin_Handled;
	}
	switch(GetClientTeam( client ))
	{
		case TEAM_SPECTATOR:
			CPrintToChat(client, "{green}[STORE]{default} Can not use {green}!buy{default} command while you are in spectator.");
		case TEAM_SURVIVOR:
			SurvivorMenu(client);
		case TEAM_INFECTED:
			ZombieMenuMenu(client);
	}
	return Plugin_Handled;
}

public Action:ShowPoints(client, args)
{
	CPrintToChat(client, "{green}[STORE]{default} You have {green}$%d{default} money", g_PlayerMoney[client]);
	return Plugin_Handled;
}

public AddMoneyToUser(client_id, cost, const String:forwhat[])
{
	if(cost == -1)
		return;
	if(IsValidClient(client_id))
	{
		g_PlayerMoney[client_id] = g_PlayerMoney[client_id]+cost;
		CPrintToChat(client_id, "{green}[STORE]{default} You got {green}$%d{default} %s.", cost, forwhat, g_PlayerMoney[client_id]);
	}
}

public RemoveMoneyFromUser(client_id, cost)
{
	g_PlayerMoney[client_id] = g_PlayerMoney[client_id]-cost;
	CPrintToChat(client_id, "{green}[STORE]{default} You now have {green}$%d{default}.", g_PlayerMoney[client_id]);
}


public bool:PlayerCanBuy(client_id, cost)
{
	if(g_PlayerMoney[client_id] < cost)
		{
		CPrintToChat(client_id, "{green}[STORE]{default} You have no enough money, need {green}$%d{default}. Now have {green}$%d{default}.", cost, g_PlayerMoney[client_id]);
		return false;
		}else{
		return true;
		}
}

public Sub_IsPlayerGhost(any:Client)
{
	if (GetEntProp(Client, Prop_Send, "m_isGhost"))
		return true;
	else
		return false;
}

public PlayerZombieSpawnAs(Client, zombieID)
{
	if(IsValidEdict(Client))
	{
		new WeaponIndex;
		while ((WeaponIndex = GetPlayerWeaponSlot(Client, 0)) != -1)
		{
			RemovePlayerItem(Client, WeaponIndex);
			RemoveEdict(WeaponIndex);
		}
		SDKCall(g_hSetClass, Client, zombieID);
		AcceptEntityInput(MakeCompatEntRef(GetEntProp(Client, Prop_Send, "m_customAbility")), "Kill");
		SetEntProp(Client, Prop_Send, "m_customAbility", GetEntData(SDKCall(g_hCreateAbility, Client), g_oAbility));
	}
}

public SpawnZombie(client, String:type[], number)
{
	if(IsValidClient(client))
	{
		new flags = GetCommandFlags("z_spawn");
		SetCommandFlags("z_spawn", flags & ~FCVAR_CHEAT);
		Format(gsString, 128, "z_spawn %s auto", type);
		FakeClientCommand(client, gsString);
		SetCommandFlags("z_spawn", flags|FCVAR_CHEAT);
	}
}

public OnEntityCreated(entity, const String:classname[])
{
	if(g_PlayerHordeSpawnNumber >= 0 && StrEqual(classname, "infected"))
	{
		if(!StrEqual(g_PlayerHordeSpawnModel, "default"))
		{
			SetEntityModel(entity, g_PlayerHordeSpawnModel);
			--g_PlayerHordeSpawnNumber;
			//PrintToChatAll("Entity created.. model:%s", g_PlayerHordeSpawnModel);
		}
	}
	
}

public Action:HordeSpawner(Handle:timer, any:data)
{
	new client = 0;
	for(new i=0;i<MAXPLAYERS+1;++i)
		{
		if(IsValidClient(i))
			client = i;
		}
	if(g_PlayerHordeSpawnNumber > 0)
	{
		new flags = GetCommandFlags("z_spawn");
		SetCommandFlags("z_spawn", flags & ~FCVAR_CHEAT);
		for(new i=0;i<g_PlayerHordeSpawnNumber;++i)
			FakeClientCommand(client, "z_spawn common auto");
		SetCommandFlags("z_spawn", flags|FCVAR_CHEAT);
		CheatCommand(client, "director_force_panic_event");
	}
	
}


public SpawnZombieHorde(client, number, String:model[])
{
	if(!IsModelPrecached(model))
	{
		strcopy(g_PlayerHordeSpawnModel, 128, "default");
		g_PlayerHordeSpawnNumber = number;
	}else{
		strcopy(g_PlayerHordeSpawnModel, 128, model);
		g_PlayerHordeSpawnNumber = number;
	}
	new flags = GetCommandFlags("z_spawn");
	SetCommandFlags("z_spawn", flags & ~FCVAR_CHEAT);
	for(new i=0;i<number;++i)
		FakeClientCommand(client, "z_spawn common auto");
    SetCommandFlags("z_spawn", flags|FCVAR_CHEAT);
	CheatCommand(client, "director_force_panic_event");
    return Plugin_Continue;
}

stock CheatCommand(client, String:command[], String:arguments[]="")
{
	new userflags = GetUserFlagBits(client);
	SetUserFlagBits(client, ADMFLAG_ROOT);
	new flags = GetCommandFlags(command);
	SetCommandFlags(command, flags & ~FCVAR_CHEAT);
	FakeClientCommand(client, "%s %s", command, arguments);
	SetCommandFlags(command, flags);
	SetUserFlagBits(client, userflags);
}


stock bool:IsValidClient(client, bool:nobots = true)
{ 
    if (client <= 0 || client > g_MaxClients || !IsClientConnected(client) || (nobots && IsFakeClient(client)))
    {
        return false; 
    }
    return IsClientInGame(client); 
}