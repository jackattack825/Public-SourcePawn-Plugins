
#include <sourcemod>
#include <sdktools>
#include <adt_trie>

//TODO test and fix line erorrs below
/**

African | 208k: ah quick question
African | 208k: Format(query, sizeof(query), 
"SELECT * FROM wtags WHERE SteamID= %s", steamID);
African | 208k: do i need to put quotes around the %s
African | 208k: cuz that would explain why it isnt querying right

Headline: Format(query, sizeof(query), 
"SELECT * FROM wtags WHERE SteamID= \"%s\"", steamID);
Headline: should work fine

use '%s', variable

*/
//using steam id 64

/**
ShtSpk ۞[۞P۞T۞: One guy said this on alliedmod 
ShtSpk ۞[۞P۞T۞: I think nametags can be added via it "m_szCustomName"
*/

StringMap map[MAXPLAYERS + 1];
Handle g_db;
char newName[128];
char steamID[128];

char errorMSG[] = "ERROR: Database can't be connected to";

char QUERY_CreateTable[] = "CREATE TABLE IF NOT EXISTS wtags (SteamID VARCHAR(34) NOT NULL PRIMARY KEY, weapon_negev CHAR(30), \
weapon_m249 CHAR(30), weapon_bizon CHAR(30), weapon_p90 CHAR(30), weapon_scar20 CHAR(30), weapon_g3gs1 CHAR(30), \
weapon_m4a1 CHAR(30), weapon_m4a1_silencer CHAR(30), weapon_ak47 CHAR(30), weapon_aug CHAR(30), \
weapon_galilar CHAR(30), weapon_awp CHAR(30), weapon_sg556 CHAR(30), weapon_ump45 CHAR(30), \
weapon_mp7 CHAR(30), weapon_famas CHAR(30), weapon_mp9 CHAR(30), weapon_mac10 CHAR(30), \
weapon_ssg08 CHAR(30), weapon_nova CHAR(30), weapon_xm1014 CHAR(30), weapon_sawedoff CHAR(30), \ 
weapon_mag7 CHAR(30), weapon_elite CHAR(30), weapon_deagle CHAR(30), weapon_tec9 CHAR(30), \
weapon_fiveseven CHAR(30), weapon_cz75a CHAR(30), weapon_glock CHAR(30), weapon_usp_silencer CHAR(30), \
weapon_p250 CHAR(30), weapon_hkp2000 CHAR(30), weapon_bayonet CHAR(30), weapon_knife_gut CHAR(30), \
weapon_knife_flip CHAR(30), weapon_knife_m9_bayonet CHAR(30), weapon_knife_karambit CHAR(30), weapon_knife_tactical CHAR(30), \
weapon_knife_butterfly CHAR(30), weapon_c4 CHAR(30), weapon_knife_falchion CHAR(30), weapon_knife_push CHAR(30), \
weapon_revolver CHAR(30), weapon_knife_survival_bowie CHAR(30), weapon_knife CHAR(30));";

public Plugin myinfo = 
{
	name = "Weapon Tags", 
	author = "AfricanSpaceJesus", 
	description = "To set custom tags on weapons", 
	version = "1.0", 
	url = "http://steamcommunity.com/id/swagattack835/"
};

public void OnPluginStart()
{
	HookEvent("item_equip", Event_Item_Equipped);
	RegConsoleCmd("sm_settag", setTag);
	
	if (SQL_CheckConfig("wtags"))
	{
		SQL_TConnect(SQLCallback_Connect, "wtags", _);
	}
	else
	{
		PrintToServer("<wtags> datbase cfg doesn't exist in databases.cfg");
	}
	
}

public OnClientPostAdminCheck(int client)
{
	map[client] = CreateTrie();
	getTags(client);
}

public OnClientDisconnect(int client)
{
	ClearTrie(map[client]);
}

public void getTags(int client)
{
	//add tags for client to the stringmap
	
	GetClientAuthId(client, AuthId_SteamID64, steamID, sizeof(steamID));
	char query[128];
	Format(query, sizeof(query), 
		"SELECT * FROM wtags WHERE SteamID= '%s';", steamID);
	SQL_TQuery(g_db, SQLCallback_Tags, query, client, DBPrio_Normal);
}

public Action setTag(int client, int args)
{
	//set name for weapon
	
	GetCmdArg(1, newName, sizeof(newName));
	int ent = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon"); //getting weapon ent index
	SetEntPropString(ent, Prop_Send, "m_szCustomName", newName); //setting new name
	
	//get weapon name and add to table in that weapons slot based upon the clients steamid
	char wep[30];
	
	GetClientAuthId(client, AuthId_SteamID64, steamID, sizeof(steamID));
	GetClientWeapon(client, wep, sizeof(wep));
	
	SetTrieString(map[client], wep, newName, true); //add to trie
	
	char query[128];
	Format(query, sizeof(query), 
		"SELECT * FROM wtags WHERE SteamID= '%s';", steamID);

	SQL_TQuery(g_db, SQLCallback_Check, query, client, DBPrio_Normal);
	
	return Plugin_Handled;
}

public Action Event_Item_Equipped(Event event, const char[] name, bool dontBroadcast)
{
	char wep[128]; // actual default name
	char wepName[128]; // name on weapon
	
	
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	GetClientWeapon(client, wep, sizeof(wep));
	int ent = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon"); //getting weapon ent index
	GetEntPropString(ent, Prop_Send, "m_szCustomName", wepName, sizeof(wepName));
	
	if (StrEqual(wepName, wep))
	{
		bool x = GetTrieString(map[client], wep, newName, sizeof(newName));
		if (x)
			SetEntPropString(ent, Prop_Send, "m_szCustomName", newName); //setting new name
	}
	
}

//no results needed
public void SQLCallback_Void(Handle owner, Handle db, const char[] error, any data)
{
	if (db == null) // I should be checking to see if results is null, too.
	{
		LogError("Error (%i): %s", data, error);
	}
}

//connecting callback
public void SQLCallback_Connect(Handle owner, Handle db, const char[] error, any data)
{
	if (db == null)
	{
		SQL_TConnect(SQLCallback_Connect, "wtags");
	}
	else
	{
		g_db = owner;
		SQL_TQuery(g_db, SQLCallback_Void, QUERY_CreateTable, DBPrio_Normal);
	}
}

//for getting tags
public void SQLCallback_Tags(Handle owner, Handle results, const char[] error, int client)
{
	if (results == null)
		return;
	
	char wepname[128];
	char colname[128];
	SQL_FetchRow(results);
	int columns = SQL_GetFieldCount(results);
	
	for (int i = 0; i <= columns; i++)
	{
		SQL_FetchString(results, i, wepname, sizeof(wepname));
		SQL_FieldNumToName(results, i, colname, sizeof(colname));
		if (!StrEqual(wepname, ""))
			SetTrieString(map[client], colname, wepname, true);
	}
}

// for adding correct info for the wep
public void SQLCallback_Check(Handle owner, Handle results, const char[] error, int client)
{
	if (results == null)
		return;
	
	char info[256];
	char query[256];
	char wep[30];
	GetClientWeapon(client, wep, sizeof(wep));
	SQL_FetchRow(results);
	SQL_FetchString(results, 0, info, sizeof(info));
	
	if (StrEqual(info, ""))
	{
		Format(query, sizeof(query), 
			"INSERT INTO wtags(SteamID, '%s') VALUES ('%s', '%s');", wep, steamID, newName);
	}
	else
	{
		Format(query, sizeof(query), 
			"UPDATE wtags SET '%s'='%s' WHERE SteamID='%s';", wep, newName, steamID);
	}
	
	SQL_TQuery(g_db, SQLCallback_Void, query, DBPrio_Normal);
}
