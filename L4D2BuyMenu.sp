
#include <sourcemod>
#include <sdktools>
#include <colors_codes>

/* TODO FINISH Infected BUY MENU CMDS, FIX suicide, ADD CMD OPTIONS FOR SHORTCUTS

*/


#define ZOMBIECLASS_SMOKER 1
#define ZOMBIECLASS_BOOMER 2
#define ZOMBIECLASS_HUNTER 3
#define ZOMBIECLASS_SPITTER 4
#define ZOMBIECLASS_JOCKEY 5
#define ZOMBIECLASS_CHARGER 6
#define ZOMBIECLASS_WITCH 7
#define ZOMBIECLASS_TANK 8
#define ZOMBIECLASS_RARE 9

//TEAM 2 is Survivors, Team 3 is INFECTED!

// Timer for sending message
Handle h_Time;

// Global Ints
int i_Money[MAXPLAYERS + 1];
int i_Ress[MAXPLAYERS + 1];

// Menu handles

//Survivor Menus
Handle h_Surviv;
Handle h_Equip;
Handle h_Weap;
Handle h_Mel;
Handle h_Other;
Handle h_GEquip;
Handle h_GWeap;
Handle h_GMel;

//Infected Menus
Handle h_Infect;
Handle h_Basic;
Handle h_Spec;
Handle h_Spawn;
Handle h_SpOth;

//CVARS
Handle h_Healing_Price;
Handle h_Healing_Short;
Handle h_Ress_Price;
Handle h_Ress_Short;
Handle h_FirstAid_Price;
Handle h_FirstAid_Short;
Handle h_Defibrillator_Price;
Handle h_Defibrillator_Short;
Handle h_PainPill_Price;
Handle h_PainPill_Short;
Handle h_Adrena_Price;
Handle h_Adrena_Short;
Handle h_Ammo_Price;
Handle h_Ammo_Short;
Handle h_BileBomb_Price;
Handle h_BileBomb_Short;
Handle h_PipeBomb_Price;
Handle h_PipeBomb_Short;
Handle h_Molly_Price;
Handle h_Molly_Short;
Handle h_Incendiary_Price;
Handle h_Incendiary_Short;
Handle h_Explosive_Price;
Handle h_Explosive_Short;
Handle h_Laser_Price;
Handle h_Laser_Short;
Handle h_Pistol_Price;
Handle h_Pistol_Short;
Handle h_Magnum_Price;
Handle h_Magnum_Short;
Handle h_ChromeShot_Price;
Handle h_ChromeShot_Short;
Handle h_PumpShot_Price;
Handle h_PumpShot_Short;
Handle h_SMG_Price;
Handle h_SMG_Short;
Handle h_SMG_Silent_Price;
Handle h_SMG_Silent_Short;
Handle h_AutoShot_Price;
Handle h_AutoShot_Short;
Handle h_Spas_Price;
Handle h_Spas_Short;
Handle h_CombatRifle_Price;
Handle h_CombatRifle_Short;
Handle h_AK_Price;
Handle h_AK_Short;
Handle h_Desert_Price;
Handle h_Desert_Short;
Handle h_Hunt_Price;
Handle h_Hunt_Short;
Handle h_Snipe_Price;
Handle h_Snipe_Short;
Handle h_Grena_Price;
Handle h_Grena_Short;
Handle h_M60_Price;
Handle h_M60_Short;
Handle h_Crow_Price;
Handle h_Crow_Short;
Handle h_BaseBall_Price;
Handle h_BaseBall_Short;
Handle h_Guitar_Price;
Handle h_Guitar_Short;
Handle h_Pan_Price;
Handle h_Pan_Short;
Handle h_Golf_Price;
Handle h_Golf_Short;
Handle h_Axe_Price;
Handle h_Axe_Short;
Handle h_Katana_Price;
Handle h_Katana_Short;
Handle h_Machete_Price;
Handle h_Machete_Short;
Handle h_ChainSaw_Price;
Handle h_ChainSaw_Short;
Handle h_OxyTank_Price;
Handle h_OxyTank_Short;
Handle h_ProTank_Price;
Handle h_ProTank_Short;
Handle h_FireCrate_Price;
Handle h_FireCrate_Short;
Handle h_IncendAmmo_Price;
Handle h_IncendAmmo_Short;
Handle h_ExplosAmmo_Price;
Handle h_ExplosAmmo_Short;
Handle h_AmmoPile_Price;
Handle h_AmmoPile_Short;

Handle h_GHealing_Price;
Handle h_GHealing_Short;
Handle h_GRess_Price;
Handle h_GRess_Short;
Handle h_GFirstAid_Price;
Handle h_GFirstAid_Short;
Handle h_GDefibrillator_Price;
Handle h_GDefibrillator_Short;
Handle h_GPainPill_Price;
Handle h_GPainPill_Short;
Handle h_GAdrena_Price;
Handle h_GAdrena_Short;
Handle h_GAmmo_Price;
Handle h_GAmmo_Short;
Handle h_GBileBomb_Price;
Handle h_GBileBomb_Short;
Handle h_GPipeBomb_Price;
Handle h_GPipeBomb_Short;
Handle h_GMolly_Price;
Handle h_GMolly_Short;
Handle h_GIncendiary_Price;
Handle h_GIncendiary_Short;
Handle h_GExplosive_Price;
Handle h_GExplosive_Short;
Handle h_GLaser_Price;
Handle h_GLaser_Short;
Handle h_GPistol_Price;
Handle h_GPistol_Short;
Handle h_GMagnum_Price;
Handle h_GMagnum_Short;
Handle h_GChromeShot_Price;
Handle h_GChromeShot_Short;
Handle h_GPumpShot_Price;
Handle h_GPumpShot_Short;
Handle h_GSMG_Price;
Handle h_GSMG_Short;
Handle h_GSMG_Silent_Price;
Handle h_GSMG_Silent_Short;
Handle h_GAutoShot_Price;
Handle h_GAutoShot_Short;
Handle h_GSpas_Price;
Handle h_GSpas_Short;
Handle h_GCombatRifle_Price;
Handle h_GCombatRifle_Short;
Handle h_GAK_Price;
Handle h_GAK_Short;
Handle h_GDesert_Price;
Handle h_GDesert_Short;
Handle h_GHunt_Price;
Handle h_GHunt_Short;
Handle h_GSnipe_Price;
Handle h_GSnipe_Short;
Handle h_GGrena_Price;
Handle h_GGrena_Short;
Handle h_GM60_Price;
Handle h_GM60_Short;
Handle h_GCrow_Price;
Handle h_GCrow_Short;
Handle h_GBaseBall_Price;
Handle h_GBaseBall_Short;
Handle h_GGuitar_Price;
Handle h_GGuitar_Short;
Handle h_GPan_Price;
Handle h_GPan_Short;
Handle h_GGolf_Price;
Handle h_GGolf_Short;
Handle h_GAxe_Price;
Handle h_GAxe_Short;
Handle h_GKatana_Price;
Handle h_GKatana_Short;
Handle h_GMachete_Price;
Handle h_GMachete_Short;
Handle h_GChainSaw_Price;
Handle h_GChainSaw_Short;


Handle h_Healing_Infect_Price;
Handle h_Healing_Infect_Short;
Handle h_Suicide_Infect_Price;
Handle h_Suicide_Infect_Short;
Handle h_Smoker_Infect_Price;
Handle h_Smoker_Infect_Short;
Handle h_Boomer_Infect_Price;
Handle h_Boomer_Infect_Short;
Handle h_Hunter_Infect_Price;
Handle h_Hunter_Infect_Short;
Handle h_Spitter_Infect_Price;
Handle h_Spitter_Infect_Short;
Handle h_Jockey_Infect_Price;
Handle h_Jockey_Infect_Short;
Handle h_Charger_Infect_Price;
Handle h_Charger_Infect_Short;
Handle h_Tank_Infect_Price;
Handle h_Tank_Infect_Short;
Handle h_Spawn_Smoker_Infect_Price;
Handle h_Spawn_Smoker_Infect_Short;
Handle h_Spawn_Boomer_Infect_Price;
Handle h_Spawn_Boomer_Infect_Short;
Handle h_Spawn_Hunter_Infect_Price;
Handle h_Spawn_Hunter_Infect_Short;
Handle h_Spawn_Spitter_Infect_Price;
Handle h_Spawn_Spitter_Infect_Short;
Handle h_Spawn_Jockey_Infect_Price;
Handle h_Spawn_Jockey_Infect_Short;
Handle h_Spawn_Charger_Infect_Price;
Handle h_Spawn_Charger_Infect_Short;
Handle h_Spawn_Tank_Infect_Price;
Handle h_Spawn_Tank_Infect_Short;
Handle h_Spawn_Mob_Infect_Price;
Handle h_Spawn_Mob_Infect_Short;
Handle h_Spawn_MegaMob_Infect_Price;
Handle h_Spawn_MegaMob_Infect_Short;
Handle h_Spawn_Witch_Infect_Price;
Handle h_Spawn_Witch_Infect_Short;
Handle h_Spawn_WitchBride_Infect_Price;
Handle h_Spawn_WitchBride_Infect_Short;
Handle h_Spawn_CedaHorde_Infect_Price;
Handle h_Spawn_CedaHorde_Infect_Short;
Handle h_Spawn_ClownHorde_Infect_Price;
Handle h_Spawn_ClownHorde_Infect_Short;
Handle h_Spawn_MudHorde_Infect_Price;
Handle h_Spawn_MudHorde_Infect_Short;
Handle h_Spawn_RoadHorde_Infect_Price;
Handle h_Spawn_RoadHorde_Infect_Short;
Handle h_Spawn_RiotHorde_Infect_Price;
Handle h_Spawn_RiotHorde_Infect_Short;
Handle h_Spawn_JimmyHorde_Infect_Price;
Handle h_Spawn_JimmyHorde_Infect_Short;
Handle h_Spawn_FallenHorde_Infect_Price;
Handle h_Spawn_FallenHorde_Infect_Short;

Handle h_MoneyfromDamage;

Handle h_MoneyfromHunter;
Handle h_MoneyfromSmoker;
Handle h_MoneyfromBoomer;
Handle h_MoneyfromTank;
Handle h_MoneyfromSurvivor;
Handle h_MoneyfromWitch;
Handle h_MoneyfromJockey;
Handle h_MoneyfromCharger;
Handle h_MoneyfromSpitter;
Handle h_MoneyfromRare;



public Plugin myinfo = 
{
	name = "BuyMenuL4D2", 
	author = "AfricanSpaceJesus", 
	description = "To have a menu for survivors and infected to use", 
	version = "0.5", 
	url = "http://steamcommunity.com/id/swagattack835/"
};

public void OnPluginStart()
{
	
	
	AutoExecConfig(true, "buymenu", "sourcemod");
	
	//Hook Events
	
	HookEvent("player_team", Event_SwitchTeam, EventHookMode_Post);
	HookEvent("player_hurt", Event_PlayerHurt, EventHookMode_Post);
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Post);
	HookEvent("player_death", Event_PlayerDeath_Pre, EventHookMode_Pre);
	
	
	//CMDS
	RegConsoleCmd("sm_buy", openMenu);
	RegConsoleCmd("sm_store", openMenu);
	RegConsoleCmd("sm_buymenu", openMenu);
	RegConsoleCmd("sm_shop", openMenu);
	RegConsoleCmd("sm_money", showMoney);
	RegConsoleCmd("sm_points", showMoney);
	RegAdminCmd("sm_addpoints", addPoints, ADMFLAG_BAN);
	
	//Timers
	h_Time = CreateTimer(300.0, menuMessage, _, TIMER_REPEAT);
	
	//CVARS
	
	h_Healing_Price = CreateConVar("sm_healing_price", "50");
	h_Healing_Short = CreateConVar("sm_healing_short", "heal");
	h_Ress_Price = CreateConVar("sm_ress_price", "50");
	h_Ress_Short = CreateConVar("sm_ress_short", "ress");
	h_FirstAid_Price = CreateConVar("sm_firstaid_price", "50");
	h_FirstAid_Short = CreateConVar("sm_firstaid_short", "aid");
	h_Defibrillator_Price = CreateConVar("sm_defibrillator_price", "50");
	h_Defibrillator_Short = CreateConVar("sm_defibrillator_short", "defib");
	h_PainPill_Price = CreateConVar("sm_painpill_price", "50");
	h_PainPill_Short = CreateConVar("sm_painpill_short", "pill");
	h_Adrena_Price = CreateConVar("sm_adren_price", "50");
	h_Adrena_Short = CreateConVar("sm_adren_short", "adren");
	h_Ammo_Price = CreateConVar("sm_ammo_price", "50");
	h_Ammo_Short = CreateConVar("sm_ammo_short", "ammo");
	h_BileBomb_Price = CreateConVar("sm_bilebomb_price", "50");
	h_BileBomb_Short = CreateConVar("sm_bilebomb_short", "bile");
	h_PipeBomb_Price = CreateConVar("sm_pipebomb_price", "50");
	h_PipeBomb_Short = CreateConVar("sm_pipebomb_short", "pipe");
	h_Molly_Price = CreateConVar("sm_molly_price", "50");
	h_Molly_Short = CreateConVar("sm_molly_short", "molly");
	h_Incendiary_Price = CreateConVar("sm_incendiary_price", "50");
	h_Incendiary_Short = CreateConVar("sm_incendiary_short", "incend");
	h_Explosive_Price = CreateConVar("sm_explosive_price", "50");
	h_Explosive_Short = CreateConVar("sm_explosive_short", "explos");
	h_Laser_Price = CreateConVar("sm_laser_price", "50");
	h_Laser_Short = CreateConVar("sm_laser_short", "laser");
	h_Pistol_Price = CreateConVar("sm_pistol_price", "50");
	h_Pistol_Short = CreateConVar("sm_pistol_short", "pistol");
	h_Magnum_Price = CreateConVar("sm_magnum_price", "50");
	h_Magnum_Short = CreateConVar("sm_magnum_short", "magnum");
	h_ChromeShot_Price = CreateConVar("sm_chromeshot_price", "50");
	h_ChromeShot_Short = CreateConVar("sm_chromeshot_short", "chrome");
	h_PumpShot_Price = CreateConVar("sm_pumpshot_price", "50");
	h_PumpShot_Short = CreateConVar("sm_pumpshot_short", "pump");
	h_SMG_Price = CreateConVar("sm_smg_price", "50");
	h_SMG_Short = CreateConVar("sm_smg_short", "smg");
	h_SMG_Silent_Price = CreateConVar("sm_smgsilent_price", "50");
	h_SMG_Silent_Short = CreateConVar("sm_smgsilent_short", "smgsilent");
	h_AutoShot_Price = CreateConVar("sm_autoshot_price", "50");
	h_AutoShot_Short = CreateConVar("sm_sutoshot_short", "auto");
	h_Spas_Price = CreateConVar("sm_spas_price", "50");
	h_Spas_Short = CreateConVar("sm_spas_short", "spas");
	h_CombatRifle_Price = CreateConVar("sm_combat_price", "50");
	h_CombatRifle_Short = CreateConVar("sm_combat_short", "combat");
	h_AK_Price = CreateConVar("sm_ak_price", "50");
	h_AK_Short = CreateConVar("sm_ak_short", "ak");
	h_Desert_Price = CreateConVar("sm_desert_price", "50");
	h_Desert_Short = CreateConVar("sm_desert_short", "desert");
	h_Hunt_Price = CreateConVar("sm_hunt_price", "50");
	h_Hunt_Short = CreateConVar("sm_hunt_price", "hunt");
	h_Snipe_Price = CreateConVar("sm_snipe_price", "50");
	h_Snipe_Short = CreateConVar("sm_snipe_short", "snipe");
	h_Grena_Price = CreateConVar("sm_grena_price", "50");
	h_Grena_Short = CreateConVar("sm_grena_short", "grena");
	h_M60_Price = CreateConVar("sm_m60_price", "50");
	h_M60_Short = CreateConVar("sm_m60_short", "m60");
	h_Crow_Price = CreateConVar("sm_crow_price", "50");
	h_Crow_Short = CreateConVar("sm_crow_short", "crow");
	h_BaseBall_Price = CreateConVar("sm_baseball_price", "50");
	h_BaseBall_Short = CreateConVar("sm_baseball_short", "bat");
	h_Guitar_Price = CreateConVar("sm_guitar_price", "50");
	h_Guitar_Short = CreateConVar("sm_guitar_short", "guitar");
	h_Pan_Price = CreateConVar("sm_pan_price", "50");
	h_Pan_Short = CreateConVar("sm_pan_short", "pan");
	h_Golf_Price = CreateConVar("sm_golf_price", "50");
	h_Golf_Short = CreateConVar("sm_golf_short", "club");
	h_Axe_Price = CreateConVar("sm_axe_price", "50");
	h_Axe_Short = CreateConVar("sm_axe_short", "axe");
	h_Katana_Price = CreateConVar("sm_katana_price", "50");
	h_Katana_Short = CreateConVar("sm_katana_short", "katana");
	h_Machete_Price = CreateConVar("sm_machete_price", "50");
	h_Machete_Short = CreateConVar("sm_machete_short", "machete");
	h_ChainSaw_Price = CreateConVar("sm_saw_price", "50");
	h_ChainSaw_Short = CreateConVar("sm_saw_short", "saw");
	h_OxyTank_Price = CreateConVar("sm_oxy_price", "50");
	h_OxyTank_Short = CreateConVar("sm_oxy_short", "oxy");
	h_ProTank_Price = CreateConVar("sm_protank_price", "50");
	h_ProTank_Short = CreateConVar("sm_protank_short", "pro");
	h_FireCrate_Price = CreateConVar("sm_firecrate_price", "50");
	h_FireCrate_Short = CreateConVar("sm_firecrate_short", "fire");
	h_IncendAmmo_Price = CreateConVar("sm_incendammo_price", "50");
	h_IncendAmmo_Short = CreateConVar("sm_incendammo_short", "incendammo");
	h_ExplosAmmo_Price = CreateConVar("sm_explosammo_price", "50");
	h_ExplosAmmo_Short = CreateConVar("sm_explosammo_short", "explosammo");
	h_AmmoPile_Price = CreateConVar("sm_ammopile_price", "50");
	h_AmmoPile_Short = CreateConVar("sm_ammopile_short", "ammopile");
	
	h_Healing_Infect_Price = CreateConVar("sm_heal_infected_price", "50");
	h_Healing_Infect_Short = CreateConVar("sm_heal_infected_short", "heal");
	h_Suicide_Infect_Price = CreateConVar("sm_suicide_infected_price", "50");
	h_Suicide_Infect_Short = CreateConVar("sm_suicide_infected_short", "sui");
	h_Smoker_Infect_Price = CreateConVar("sm_smoker_infected_price", "50");
	h_Smoker_Infect_Short = CreateConVar("sm_smoker_infected_short", "smo");
	h_Boomer_Infect_Price = CreateConVar("sm_boomer_infected_price", "50");
	h_Boomer_Infect_Short = CreateConVar("sm_boomer_infected_short", "boom");
	h_Hunter_Infect_Price = CreateConVar("sm_hunter_infected_price", "50");
	h_Hunter_Infect_Short = CreateConVar("sm_hunter_infected_short", "hunt");
	h_Spitter_Infect_Price = CreateConVar("sm_spit_infected_price", "50");
	h_Spitter_Infect_Short = CreateConVar("sm_spit_infected_short", "spit");
	h_Jockey_Infect_Price = CreateConVar("sm_jock_infected_price", "50");
	h_Jockey_Infect_Short = CreateConVar("sm_jock_infected_short", "jock");
	h_Charger_Infect_Price = CreateConVar("sm_charger_infected_price", "50");
	h_Charger_Infect_Short = CreateConVar("sm_charger_infected_short", "charg");
	h_Tank_Infect_Price = CreateConVar("sm_tank_infected_price", "50");
	h_Tank_Infect_Short = CreateConVar("sm_tank_infected_short", "tank");
	h_Spawn_Smoker_Infect_Price = CreateConVar("sm_smoke_infected_price", "50");
	h_Spawn_Smoker_Infect_Short = CreateConVar("sm_smoke_infected_short", "smoke");
	h_Spawn_Boomer_Infect_Price = CreateConVar("sm_boom_infected_price", "50");
	h_Spawn_Boomer_Infect_Short = CreateConVar("sm_boom_infected_short", "boom");
	h_Spawn_Hunter_Infect_Price = CreateConVar("sm_hunter_infected_price", "50");
	h_Spawn_Hunter_Infect_Short = CreateConVar("sm_hunter_infected_short", "hunter");
	h_Spawn_Spitter_Infect_Price = CreateConVar("sm_spitter_infected_price", "50");
	h_Spawn_Spitter_Infect_Short = CreateConVar("sm_spitter_infected_short", "spitter");
	h_Spawn_Jockey_Infect_Price = CreateConVar("sm_jockey_infected_price", "50");
	h_Spawn_Jockey_Infect_Short = CreateConVar("sm_jockey_infected_short", "jockey");
	h_Spawn_Charger_Infect_Price = CreateConVar("sm_charger_infected_price", "50");
	h_Spawn_Charger_Infect_Short = CreateConVar("sm_charger_infected_short", "charger");
	h_Spawn_Tank_Infect_Price = CreateConVar("sm_tank2_infected_price", "50");
	h_Spawn_Tank_Infect_Short = CreateConVar("sm_tank2_infected_short", "tank2");
	h_Spawn_Mob_Infect_Price = CreateConVar("sm_mob_infected_price", "50");
	h_Spawn_Mob_Infect_Short = CreateConVar("sm_mob_infected_short", "mob");
	h_Spawn_MegaMob_Infect_Price = CreateConVar("sm_megmob_infected_price", "50");
	h_Spawn_MegaMob_Infect_Short = CreateConVar("sm_megmob_infected_short", "megmob");
	h_Spawn_Witch_Infect_Price = CreateConVar("sm_witch_infected_price", "50");
	h_Spawn_Witch_Infect_Short = CreateConVar("sm_witch_infected_short", "witch");
	h_Spawn_WitchBride_Infect_Price = CreateConVar("sm_bride_infected_price", "50");
	h_Spawn_WitchBride_Infect_Short = CreateConVar("sm_bride_infected_short", "bride");
	h_Spawn_CedaHorde_Infect_Price = CreateConVar("sm_ceda_infected_price", "50");
	h_Spawn_CedaHorde_Infect_Short = CreateConVar("sm_ceda_infected_short", "ceda");
	h_Spawn_ClownHorde_Infect_Price = CreateConVar("sm_clown_infected_price", "50");
	h_Spawn_ClownHorde_Infect_Short = CreateConVar("sm_clown_infected_short", "clown");
	h_Spawn_MudHorde_Infect_Price = CreateConVar("sm_mud_infected_price", "50");
	h_Spawn_MudHorde_Infect_Short = CreateConVar("sm_mud_infected_short", "mud");
	h_Spawn_RoadHorde_Infect_Price = CreateConVar("sm_road_infected_price", "50");
	h_Spawn_RoadHorde_Infect_Short = CreateConVar("sm_road_infected_short", "road");
	h_Spawn_RiotHorde_Infect_Price = CreateConVar("sm_riot_infected_price", "50");
	h_Spawn_RiotHorde_Infect_Short = CreateConVar("sm_riot_infected_short", "riot");
	h_Spawn_JimmyHorde_Infect_Price = CreateConVar("sm_jim_infected_price", "50");
	h_Spawn_JimmyHorde_Infect_Short = CreateConVar("sm_jim_infected_short", "jim");
	h_Spawn_FallenHorde_Infect_Price = CreateConVar("sm_fall_infected_price", "50");
	h_Spawn_FallenHorde_Infect_Short = CreateConVar("sm_fall_infected_short", "fall");
	
	h_MoneyfromDamage = CreateConVar("sm_percentmoneyfromdamage", "0.25");
	
	h_MoneyfromHunter = CreateConVar("sm_moneyfromhunter", "50");
	h_MoneyfromSmoker = CreateConVar("sm_moneyfromsmoker", "50");
	h_MoneyfromBoomer = CreateConVar("sm_moneyfromboomer", "50");
	h_MoneyfromTank = CreateConVar("sm_moneyfromtank", "50");
	h_MoneyfromSurvivor = CreateConVar("sm_moneyfromsurvivor", "50");
	h_MoneyfromWitch = CreateConVar("sm_moneyfromwitch", "50");
	h_MoneyfromJockey = CreateConVar("sm_moneyfromjockey", "50");
	h_MoneyfromCharger = CreateConVar("sm_moneyfromcharger", "50");
	h_MoneyfromSpitter = CreateConVar("sm_moneyfromspitter", "50");
	h_MoneyfromRare = CreateConVar("sm_moneyfromrare", "50");
	
	h_GHealing_Price = CreateConVar("sm_ghealing_price", "50");
	h_GHealing_Short = CreateConVar("sm_ghealing_short", "gheal");
	h_GRess_Price = CreateConVar("sm_gress_price", "50");
	h_GRess_Short = CreateConVar("sm_gress_short", "gress");
	h_GFirstAid_Price = CreateConVar("sm_gfirstaid_price", "50");
	h_GFirstAid_Short = CreateConVar("sm_gfirstaid_short", "gfirst");
	h_GDefibrillator_Price = CreateConVar("sm_gdefib_price", "50");
	h_GDefibrillator_Short = CreateConVar("sm_gdefib_short", "gdefib");
	h_GPainPill_Price = CreateConVar("sm_gpainpill_price", "50");
	h_GPainPill_Short = CreateConVar("sm_gpainpill_short", "gpain");
	h_GAdrena_Price = CreateConVar("sm_gadrena_price", "50");
	h_GAdrena_Short = CreateConVar("sm_gadrena_short", "gadrena");
	h_GAmmo_Price = CreateConVar("sm_gammo_price", "50");
	h_GAmmo_Short = CreateConVar("sm_gammo_short", "gammo");
	h_GBileBomb_Price = CreateConVar("sm_gbilebomb_price", "50");
	h_GBileBomb_Short = CreateConVar("sm_gbilebomb_short", "gbile");
	h_GPipeBomb_Price = CreateConVar("sm_gpipebomb_price", "50");
	h_GPipeBomb_Short = CreateConVar("sm_gpipebomb_short", "gpipe");
	h_GMolly_Price = CreateConVar("sm_gmolly_price", "50");
	h_GMolly_Short = CreateConVar("sm_gmolly_short", "gmolly");
	h_GIncendiary_Price = CreateConVar("sm_gincend_price", "50");
	h_GIncendiary_Short = CreateConVar("sm_gincend_short", "gincend");
	h_GExplosive_Price = CreateConVar("sm_gexplos_price", "50");
	h_GExplosive_Short = CreateConVar("sm_gexplos_short", "gexplos");
	h_GLaser_Price = CreateConVar("sm_glaser_price", "50");
	h_GLaser_Short = CreateConVar("sm_glaser_short", "glaser");
	h_GPistol_Price = CreateConVar("sm_gpistol_price", "50");
	h_GPistol_Short = CreateConVar("sm_gpistol_short", "gpistol");
	h_GMagnum_Price = CreateConVar("sm_gmagnum_price", "50");
	h_GMagnum_Short = CreateConVar("sm_gmagnum_short", "gmagnum");
	h_GChromeShot_Price = CreateConVar("sm_gchromeshot_price", "50");
	h_GChromeShot_Short = CreateConVar("sm_gchromeshot_short", "gchrome");
	h_GPumpShot_Price = CreateConVar("sm_gpumpshot_price", "50");
	h_GPumpShot_Short = CreateConVar("sm_gpumpshot_short", "gpump");
	h_GSMG_Price = CreateConVar("sm_gsmg_price", "50");
	h_GSMG_Short = CreateConVar("sm_gsmg_short", "gsmg");
	h_GSMG_Silent_Price = CreateConVar("sm_gsmgsilent_price", "50");
	h_GSMG_Silent_Short = CreateConVar("sm_gsmgsilent_short", "gsmgsilent");
	h_GAutoShot_Price = CreateConVar("sm_gautoshot_price", "50");
	h_GAutoShot_Short = CreateConVar("sm_gsutoshot_short", "gauto");
	h_GSpas_Price = CreateConVar("sm_gspas_price", "50");
	h_GSpas_Short = CreateConVar("sm_gspas_short", "gspas");
	h_GCombatRifle_Price = CreateConVar("sm_gcombatrifle_price", "50");
	h_GCombatRifle_Short = CreateConVar("sm_gcombatrifle_short", "gcombat");
	h_GAK_Price = CreateConVar("sm_gak_price", "50");
	h_GAK_Short = CreateConVar("sm_gak_short", "gak");
	h_GDesert_Price = CreateConVar("sm_gdesert_price", "50");
	h_GDesert_Short = CreateConVar("sm_gdesert_short", "gdesert");
	h_GHunt_Price = CreateConVar("sm_ghunt_price", "50");
	h_GHunt_Short = CreateConVar("sm_ghunt_short", "ghunt");
	h_GSnipe_Price = CreateConVar("sm_gsnipe_price", "50");
	h_GSnipe_Short = CreateConVar("sm_gsnipe_short", "gsnipe");
	h_GGrena_Price = CreateConVar("sm_ggrena_price", "50");
	h_GGrena_Short = CreateConVar("sm_ggrena_short", "ggrena");
	h_GM60_Price = CreateConVar("sm_gm60_price", "50");
	h_GM60_Short = CreateConVar("sm_gm60_price", "gm60");
	h_GCrow_Price = CreateConVar("sm_gcrow_price", "50");
	h_GCrow_Short = CreateConVar("sm_gcrow_short", "gcrow");
	h_GBaseBall_Price = CreateConVar("sm_gbaseball_price", "50");
	h_GBaseBall_Short = CreateConVar("sm_gbaseball_short", "gbase");
	h_GGuitar_Price = CreateConVar("sm_gguitar_price", "50");
	h_GGuitar_Short = CreateConVar("sm_gguitar_short", "gguitar");
	h_GPan_Price = CreateConVar("sm_gpan_price", "50");
	h_GPan_Short = CreateConVar("sm_gpan_short", "gpan");
	h_GGolf_Price = CreateConVar("sm_ggolf_price", "50");
	h_GGolf_Short = CreateConVar("sm_ggolf_short", "ggolf");
	h_GAxe_Price = CreateConVar("sm_gaxe_price", "50");
	h_GAxe_Short = CreateConVar("sm_gaxe_short", "gaxe");
	h_GKatana_Price = CreateConVar("sm_gkatana_price", "50");
	h_GKatana_Short = CreateConVar("sm_gkatana_short", "gkatana");
	h_GMachete_Price = CreateConVar("sm_gmachete_price", "50");
	h_GMachete_Short = CreateConVar("sm_gmachete_short", "gmachete");
	h_GChainSaw_Price = CreateConVar("sm_gchainsaw_price", "50");
	h_GChainSaw_Short = CreateConVar("sm_gshainsaw_short", "gsaw");
	
}

public void OnClientDisconnect(int client)
{
	i_Money[client] = 0;
}

public Action addPoints(int client, int args)
{
	CPrintToChatAll("{green} Adding credits");
	if (args == 0)
	{
		CPrintToChat(client, "{green}Specify a player");
	}
	else if (args == 1)
	{
		char arg1[120];
		char money[64];
		char name[64];
		int mula;
		GetCmdArg(1, arg1, sizeof(arg1));
		GetCmdArg(2, money, sizeof(money));
		int target = FindTarget(client, arg1, true, false);
		GetClientName(target, name, sizeof(name));
		mula = StringToInt(money);
		
		if (!IsClientInGame(target) || target == 0)
			return Plugin_Handled;
		
		i_Money[target] += mula;
		CPrintToChatAll("{green} %s recieved %i credits", name, money);
	}
	
	return Plugin_Handled;
}

public Action openMenu(int client, int args)
{
	if (args == 0)
	{
		//check if player is a survivor or infected and set up correct menu
		if (GetClientTeam(client) == 2)
		{
			buildSurvivMenu(client);
			DisplayMenu(h_Surviv, client, MENU_TIME_FOREVER);
		}
		else if (GetClientTeam(client) == 3)
		{
			buildInfectMenu(client);
			DisplayMenu(h_Infect, client, MENU_TIME_FOREVER);
		}
	}
	else if (args == 1)
	{
		//Check arg for shortcuts from cvar
		char info[64];
		char short[64];
		GetCmdArg(1, info, sizeof(info));
		
		GetConVarString(h_Pistol_Short, short, sizeof(short));
		
		if (StrEqual(info, short) && GetClientTeam(client) == 2)
		{
			givePistol(client);
		}
		
	}
	
	return Plugin_Handled;
}

public Action showMoney(int client, int args)
{
	char money[10];
	IntToString(i_Money[client], money, sizeof(money));
	CPrintToChat(client, ("[STORE] {green} You have $%s", money));
}


//Menu Builders


//Survivor Menus
public void buildSurvivMenu(int client)
{
	h_Surviv = CreateMenu(survivMenuCall);
	SetMenuTitle(h_Surviv, "Survivors");
	
	char money[10];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	
	Format(info, sizeof(info), "You have %s money", money);
	
	AddMenuItem(h_Surviv, "money", ("%s", info));
	AddMenuItem(h_Surviv, "equip", "Equipment");
	AddMenuItem(h_Surviv, "weap", "Weapons");
	AddMenuItem(h_Surviv, "mel", "Melee");
	AddMenuItem(h_Surviv, "other", "Others");
	AddMenuItem(h_Surviv, "g_equip", "Group Equipment");
	AddMenuItem(h_Surviv, "g_weap", "Group Weapons");
	AddMenuItem(h_Surviv, "g_mel", "Group Melee");
}

public void buildEquipMenu(int client)
{
	h_Equip = CreateMenu(equipMenuCall);
	SetMenuTitle(h_Equip, "1. Equipment");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	
	Format(info, sizeof(info), "You have %s money", money);
	
	AddMenuItem(h_Equip, "money", ("%s", info));
	
	GetConVarString(h_Healing_Price, price, sizeof(price));
	GetConVarString(h_Healing_Short, short, sizeof(short));
	Format(info, sizeof(info), "Healing (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "heal", ("%s", info));
	
	GetConVarString(h_Ress_Price, price, sizeof(price));
	GetConVarString(h_Ress_Short, short, sizeof(short));
	Format(info, sizeof(info), "Resurrection (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "resurr", ("%s", info));
	
	GetConVarString(h_FirstAid_Price, price, sizeof(price));
	GetConVarString(h_FirstAid_Short, short, sizeof(short));
	Format(info, sizeof(info), "First Aid Kit (%s) - $%s", short, price);
	
	
	AddMenuItem(h_Equip, "first", ("%s", info));
	
	GetConVarString(h_Defibrillator_Price, price, sizeof(price));
	GetConVarString(h_Defibrillator_Short, short, sizeof(short));
	Format(info, sizeof(info), "Defibrillator (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "defib", ("%s", info));
	
	GetConVarString(h_PainPill_Price, price, sizeof(price));
	GetConVarString(h_PainPill_Short, short, sizeof(short));
	Format(info, sizeof(info), "Pain Pills (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "pill", ("%s", info));
	
	GetConVarString(h_Adrena_Price, price, sizeof(price));
	GetConVarString(h_Adrena_Short, short, sizeof(short));
	Format(info, sizeof(info), "Adrenaline (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "adren", ("%s", info));
	
	GetConVarString(h_Ammo_Price, price, sizeof(price));
	GetConVarString(h_Ammo_Short, short, sizeof(short));
	Format(info, sizeof(info), "Ammo (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "ammo", ("%s", info));
	
	SetMenuPagination(h_Equip, 8);
	
	AddMenuItem(h_Equip, "money", ("You have $%s", money));
	
	GetConVarString(h_BileBomb_Price, price, sizeof(price));
	GetConVarString(h_BileBomb_Short, short, sizeof(short));
	Format(info, sizeof(info), "Bile Bomb (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "bile", ("%s", info));
	
	GetConVarString(h_PipeBomb_Price, price, sizeof(price));
	GetConVarString(h_PipeBomb_Short, short, sizeof(short));
	Format(info, sizeof(info), "Pipe Bomb (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "pipe", ("%s", info));
	
	GetConVarString(h_Molly_Price, price, sizeof(price));
	GetConVarString(h_Molly_Short, short, sizeof(short));
	Format(info, sizeof(info), "Molotov (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "molly", ("%s", info));
	
	GetConVarString(h_Incendiary_Price, price, sizeof(price));
	GetConVarString(h_Incendiary_Short, short, sizeof(short));
	Format(info, sizeof(info), "Incendiary Ammo (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "incend", ("%s", info));
	
	GetConVarString(h_Explosive_Price, price, sizeof(price));
	GetConVarString(h_Explosive_Short, short, sizeof(short));
	Format(info, sizeof(info), "Explosive Ammo (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "explos", ("%s", info));
	
	GetConVarString(h_Laser_Price, price, sizeof(price));
	GetConVarString(h_Laser_Short, short, sizeof(short));
	Format(info, sizeof(info), "Laser Sight (%s) - $%s", short, price);
	
	AddMenuItem(h_Equip, "laser", ("%s", info));
	
	SetMenuExitBackButton(h_Equip, true);
}

public void buildWeapMenu(int client)
{
	h_Weap = CreateMenu(weapMenuCall);
	SetMenuTitle(h_Weap, "2. Weapons");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	Format(info, sizeof(info), "You have $%s", money);
	
	AddMenuItem(h_Weap, "money", ("%s", info));
	
	GetConVarString(h_Pistol_Price, price, sizeof(price));
	GetConVarString(h_Pistol_Short, short, sizeof(short));
	Format(info, sizeof(info), "Pistol (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "pist", ("%s", info));
	
	GetConVarString(h_Magnum_Price, price, sizeof(price));
	GetConVarString(h_Magnum_Short, short, sizeof(short));
	Format(info, sizeof(info), "Magnum (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "mag", ("%s", info));
	
	GetConVarString(h_ChromeShot_Price, price, sizeof(price));
	GetConVarString(h_ChromeShot_Short, short, sizeof(short));
	Format(info, sizeof(info), "Chrome Shotgun (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "chrome", ("%s", info));
	
	GetConVarString(h_PumpShot_Price, price, sizeof(price));
	GetConVarString(h_PumpShot_Short, short, sizeof(short));
	Format(info, sizeof(info), "Pump Shotgun (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "pump", ("%s", info));
	
	GetConVarString(h_SMG_Price, price, sizeof(price));
	GetConVarString(h_SMG_Short, short, sizeof(short));
	Format(info, sizeof(info), "SMG (%s) - $%i", short, price);
	
	AddMenuItem(h_Weap, "smg", ("%s", info));
	
	GetConVarString(h_SMG_Silent_Price, price, sizeof(price));
	GetConVarString(h_SMG_Silent_Short, short, sizeof(short));
	Format(info, sizeof(info), "Silent SMG (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "silent", ("%s", info));
	
	GetConVarString(h_AutoShot_Price, price, sizeof(price));
	GetConVarString(h_AutoShot_Short, short, sizeof(short));
	Format(info, sizeof(info), "Auto Shotgun (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "auto", ("%s", info));
	
	SetMenuPagination(h_Weap, 8);
	
	Format(info, sizeof(info), "You have $%s", money);
	
	AddMenuItem(h_Weap, "money", ("%s", info));
	
	GetConVarString(h_Spas_Price, price, sizeof(price));
	GetConVarString(h_Spas_Short, short, sizeof(short));
	Format(info, sizeof(info), "Spas Shotgun (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "spas", ("%s", info));
	
	GetConVarString(h_CombatRifle_Price, price, sizeof(price));
	GetConVarString(h_CombatRifle_Short, short, sizeof(short));
	Format(info, sizeof(info), "Combat Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "rifle", ("%s", info));
	
	GetConVarString(h_AK_Price, price, sizeof(price));
	GetConVarString(h_AK_Short, short, sizeof(short));
	Format(info, sizeof(info), "Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "ak", ("%s", info));
	
	GetConVarString(h_Desert_Price, price, sizeof(price));
	GetConVarString(h_Desert_Short, short, sizeof(short));
	Format(info, sizeof(info), "Desert Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "desert", ("%s", info));
	
	GetConVarString(h_Hunt_Price, price, sizeof(price));
	GetConVarString(h_Hunt_Short, short, sizeof(short));
	Format(info, sizeof(info), "Hunting Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "hunt", ("%s", info));
	
	GetConVarString(h_Snipe_Price, price, sizeof(price));
	GetConVarString(h_Snipe_Short, short, sizeof(short));
	Format(info, sizeof(info), "Sniper Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "snipe", ("%s", info));
	
	GetConVarString(h_Grena_Price, price, sizeof(price));
	GetConVarString(h_Grena_Short, short, sizeof(short));
	Format(info, sizeof(info), "Grenade Launcher (%s) - $%s", short, price);
	
	AddMenuItem(h_Weap, "launch", ("%s", info));
	
	SetMenuExitBackButton(h_Weap, true);
	
	GetConVarString(h_M60_Price, price, sizeof(price));
	GetConVarString(h_M60_Short, short, sizeof(short));
	Format(info, sizeof(info), "M60 Rifle (%s) - $%i", short, price);
	
	AddMenuItem(h_Weap, "m60", ("%s", info));
}

public void buildMelMenu(int client)
{
	h_Mel = CreateMenu(melMenuCall);
	SetMenuTitle(h_Mel, "3. Melee");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	
	AddMenuItem(h_Mel, "money", ("You have $%s", money));
	
	GetConVarString(h_Crow_Price, price, sizeof(price));
	GetConVarString(h_Crow_Short, short, sizeof(short));
	Format(info, sizeof(info), "Crowbar (%s) - $%i", short, price);
	
	AddMenuItem(h_Mel, "crow", ("%s", info));
	
	GetConVarString(h_BaseBall_Price, price, sizeof(price));
	GetConVarString(h_BaseBall_Short, short, sizeof(short));
	Format(info, sizeof(info), "Baseball Bat (%s) - $%i", short, price);
	
	AddMenuItem(h_Mel, "bat", ("%s", info));
	
	GetConVarString(h_Guitar_Price, price, sizeof(price));
	GetConVarString(h_Guitar_Short, short, sizeof(short));
	Format(info, sizeof(info), "Electric Guitar (%s) - $%i", short, price);
	
	AddMenuItem(h_Mel, "elec", ("%s", info));
	
	GetConVarString(h_Pan_Price, price, sizeof(price));
	GetConVarString(h_Pan_Short, short, sizeof(short));
	Format(info, sizeof(info), "Frying Pan (%s) - $%i", short, price);
	
	AddMenuItem(h_Mel, "pan", ("%s", info));
	
	GetConVarString(h_Golf_Price, price, sizeof(price));
	GetConVarString(h_Golf_Short, short, sizeof(short));
	Format(info, sizeof(info), "Golf Club (%s) - $%i", short, price);
	
	AddMenuItem(h_Mel, "golf", ("%s", info));
	
	GetConVarString(h_Axe_Price, price, sizeof(price));
	GetConVarString(h_Axe_Short, short, sizeof(short));
	Format(info, sizeof(info), "Fire Axe (%s) - $%i", short, price);
	
	AddMenuItem(h_Mel, "axe", ("%s", info));
	
	GetConVarString(h_Katana_Price, price, sizeof(price));
	GetConVarString(h_Katana_Short, short, sizeof(short));
	Format(info, sizeof(info), "Katana (%s) - $%i", short, price);
	
	AddMenuItem(h_Mel, "kat", ("%s", info));
	
	SetMenuPagination(h_Mel, 8);
	
	Format(info, sizeof(info), "You have $%s", money);
	
	AddMenuItem(h_Mel, "money", ("%s", info));
	
	GetConVarString(h_Machete_Price, price, sizeof(price));
	GetConVarString(h_Machete_Short, short, sizeof(short));
	Format(info, sizeof(info), "Machete (%s) - $%i", short, price);
	
	AddMenuItem(h_Mel, "mach", ("%s", info));
	
	GetConVarString(h_ChainSaw_Price, price, sizeof(price));
	GetConVarString(h_ChainSaw_Short, short, sizeof(short));
	Format(info, sizeof(info), "Chain Saw (%s) - $%i", short, price);
	
	AddMenuItem(h_Mel, "saw", ("%s", info));
	
	
	SetMenuExitBackButton(h_Mel, true);
	
}

public void buildOthMenu(int client)
{
	h_Other = CreateMenu(othMenuCall);
	SetMenuTitle(h_Other, "4. Others");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	Format(info, sizeof(info), "You have $%s", money);
	
	AddMenuItem(h_Other, "money", ("%s", info));
	
	GetConVarString(h_OxyTank_Price, price, sizeof(price));
	GetConVarString(h_OxyTank_Short, short, sizeof(short));
	Format(info, sizeof(info), "Oxygen Tank (%s) - $%s", short, price);
	
	AddMenuItem(h_Other, "oxy", ("%s", info));
	
	GetConVarString(h_ProTank_Price, price, sizeof(price));
	GetConVarString(h_ProTank_Short, short, sizeof(short));
	Format(info, sizeof(info), "Propane Tank (%s) - $%s", short, price);
	
	
	AddMenuItem(h_Other, "prop", ("%s", info));
	
	GetConVarString(h_FireCrate_Price, price, sizeof(price));
	GetConVarString(h_FireCrate_Short, short, sizeof(short));
	Format(info, sizeof(info), "Fireworks Crate (%s) - $%s", short, price);
	
	AddMenuItem(h_Other, "fire", ("%s", info));
	
	GetConVarString(h_IncendAmmo_Price, price, sizeof(price));
	GetConVarString(h_IncendAmmo_Short, short, sizeof(short));
	Format(info, sizeof(info), "Incendiary Ammo (%s) - $%s", short, price);
	
	AddMenuItem(h_Other, "incend", ("%s", info));
	
	GetConVarString(h_ExplosAmmo_Price, price, sizeof(price));
	GetConVarString(h_ExplosAmmo_Short, short, sizeof(short));
	Format(info, sizeof(info), "Explosive Ammo (%s) - $%s", short, price);
	
	AddMenuItem(h_Other, "explos", ("%s", info));
	
	GetConVarString(h_AmmoPile_Price, price, sizeof(price));
	GetConVarString(h_AmmoPile_Short, short, sizeof(short));
	Format(info, sizeof(info), "Ammo Pile (%s) - $%s", short, price);
	
	AddMenuItem(h_Other, "ammo", ("%s", info));
	
	SetMenuPagination(h_Other, 7);
	
	SetMenuExitBackButton(h_Other, true);
	
}

public void buildGEquipMenu(int client)
{
	h_GEquip = CreateMenu(gequipMenuCall);
	SetMenuTitle(h_GEquip, "5. Group Equipment");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	Format(info, sizeof(info), "You have $%s", money);
	
	AddMenuItem(h_GEquip, "money", ("%s", info));
	
	GetConVarString(h_GHealing_Price, price, sizeof(price));
	GetConVarString(h_GHealing_Short, short, sizeof(short));
	Format(info, sizeof(info), "Healing (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "heal", ("%s", info));
	
	GetConVarString(h_GRess_Price, price, sizeof(price));
	GetConVarString(h_GRess_Short, short, sizeof(short));
	Format(info, sizeof(info), "Resurrection (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "resurr", ("%s", info));
	
	GetConVarString(h_GFirstAid_Price, price, sizeof(price));
	GetConVarString(h_GFirstAid_Short, short, sizeof(short));
	Format(info, sizeof(info), "First Aid Kit (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "first", ("%s", info));
	
	GetConVarString(h_GDefibrillator_Price, price, sizeof(price));
	GetConVarString(h_GDefibrillator_Short, short, sizeof(short));
	Format(info, sizeof(info), "Defibrillator (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "defib", ("%s", info));
	
	GetConVarString(h_GPainPill_Price, price, sizeof(price));
	GetConVarString(h_GPainPill_Short, short, sizeof(short));
	Format(info, sizeof(info), "Pain Pills (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "pill", ("%s", info));
	
	GetConVarString(h_GAdrena_Price, price, sizeof(price));
	GetConVarString(h_GAdrena_Short, short, sizeof(short));
	Format(info, sizeof(info), "Adrenaline (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "adren", ("%s", info));
	
	GetConVarString(h_GAmmo_Price, price, sizeof(price));
	GetConVarString(h_GAmmo_Short, short, sizeof(short));
	Format(info, sizeof(info), "Ammo (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "ammo", ("%s", info));
	
	SetMenuPagination(h_Equip, 7);
	
	Format(info, sizeof(info), "You have $%s", money);
	
	AddMenuItem(h_GEquip, "money", ("%s", info));
	
	GetConVarString(h_GBileBomb_Price, price, sizeof(price));
	GetConVarString(h_GBileBomb_Short, short, sizeof(short));
	Format(info, sizeof(info), "Bile Bomb (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "bile", ("%s", info));
	
	GetConVarString(h_GPipeBomb_Price, price, sizeof(price));
	GetConVarString(h_GPipeBomb_Short, short, sizeof(short));
	Format(info, sizeof(info), "Pipe Bomb (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "pipe", ("%s", info));
	
	GetConVarString(h_GMolly_Price, price, sizeof(price));
	GetConVarString(h_GMolly_Short, short, sizeof(short));
	Format(info, sizeof(info), "Molotov (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "molly", ("%s", info));
	
	GetConVarString(h_GIncendiary_Price, price, sizeof(price));
	GetConVarString(h_GIncendiary_Short, short, sizeof(short));
	Format(info, sizeof(info), "Incendiary Ammo (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "incend", ("%s", info));
	
	GetConVarString(h_GExplosive_Price, price, sizeof(price));
	GetConVarString(h_GExplosive_Short, short, sizeof(short));
	Format(info, sizeof(info), "Explosive Ammo (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "explos", ("%s", info));
	
	GetConVarString(h_GLaser_Price, price, sizeof(price));
	GetConVarString(h_GLaser_Short, short, sizeof(short));
	Format(info, sizeof(info), "Laser Sight (%s) - $%s", short, price);
	
	AddMenuItem(h_GEquip, "laser", ("%s", info));
	
	SetMenuExitBackButton(h_Equip, true);
}

public void buildGWeapMenu(int client)
{
	h_GWeap = CreateMenu(weapMenuCall);
	SetMenuTitle(h_Weap, "6. Group Weapons");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	Format(info, sizeof(info), "You have $%s", money);
	
	AddMenuItem(h_GWeap, "money", ("%s", info));
	
	GetConVarString(h_GPistol_Price, price, sizeof(price));
	GetConVarString(h_GPistol_Short, short, sizeof(short));
	Format(info, sizeof(info), "Pistol (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "pist", ("%s", info));
	
	GetConVarString(h_GMagnum_Price, price, sizeof(price));
	GetConVarString(h_GMagnum_Short, short, sizeof(short));
	Format(info, sizeof(info), "Magnum (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "mag", ("%s", info));
	
	GetConVarString(h_GChromeShot_Price, price, sizeof(price));
	GetConVarString(h_GChromeShot_Short, short, sizeof(short));
	Format(info, sizeof(info), "Chrome Shotgun (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "chrome", ("%s", info));
	
	GetConVarString(h_GPumpShot_Price, price, sizeof(price));
	GetConVarString(h_GPumpShot_Short, short, sizeof(short));
	Format(info, sizeof(info), "Pump Shotgun (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "pump", ("%s", info));
	
	GetConVarString(h_GSMG_Price, price, sizeof(price));
	GetConVarString(h_GSMG_Short, short, sizeof(short));
	Format(info, sizeof(info), "SMG (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "smg", ("%s", info));
	
	GetConVarString(h_GSMG_Silent_Price, price, sizeof(price));
	GetConVarString(h_GSMG_Silent_Short, short, sizeof(short));
	Format(info, sizeof(info), "Silent SMG (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "silent", ("%s", money));
	
	GetConVarString(h_GAutoShot_Price, price, sizeof(price));
	GetConVarString(h_GAutoShot_Short, short, sizeof(short));
	Format(info, sizeof(info), "Auto Shotgun (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "auto", ("%s", info));
	
	SetMenuPagination(h_GWeap, 8);
	
	Format(info, sizeof(info), "You have $%s", money);
	
	AddMenuItem(h_GWeap, "money", ("%s", info));
	
	GetConVarString(h_GSpas_Price, price, sizeof(price));
	GetConVarString(h_GSpas_Short, short, sizeof(short));
	Format(info, sizeof(info), "Spas Shotgun (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "spas", ("%s", info));
	
	GetConVarString(h_GCombatRifle_Price, price, sizeof(price));
	GetConVarString(h_GCombatRifle_Short, short, sizeof(short));
	Format(info, sizeof(info), "Combat Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "rifle", ("%s", info));
	
	GetConVarString(h_GAK_Price, price, sizeof(price));
	GetConVarString(h_GAK_Short, short, sizeof(short));
	Format(info, sizeof(info), "AK47 Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "ak", ("%s", info));
	
	GetConVarString(h_GDesert_Price, price, sizeof(price));
	GetConVarString(h_GDesert_Short, short, sizeof(short));
	Format(info, sizeof(info), "Desert Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "desert", ("%s", info));
	
	GetConVarString(h_GHunt_Price, price, sizeof(price));
	GetConVarString(h_GHunt_Short, short, sizeof(short));
	Format(info, sizeof(info), "Hunting Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "hunt", ("%s", info));
	
	GetConVarString(h_GSnipe_Price, price, sizeof(price));
	GetConVarString(h_GSnipe_Short, short, sizeof(short));
	Format(info, sizeof(info), "Sniper Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "snipe", ("%s", info));
	
	GetConVarString(h_GGrena_Price, price, sizeof(price));
	GetConVarString(h_GGrena_Short, short, sizeof(short));
	Format(info, sizeof(info), "Grenade Launcher (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "launch", ("%s", info));
	
	SetMenuExitBackButton(h_GWeap, true);
	
	GetConVarString(h_GM60_Price, price, sizeof(price));
	GetConVarString(h_GM60_Short, short, sizeof(short));
	Format(info, sizeof(info), "M60 Rifle (%s) - $%s", short, price);
	
	AddMenuItem(h_GWeap, "m60", ("%s", info));
}

public void buildGMelMenu(int client)
{
	h_GMel = CreateMenu(melMenuCall);
	SetMenuTitle(h_GMel, "7. Group Melee");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	Format(info, sizeof(info), "You have $%s", money);
	
	AddMenuItem(h_GMel, "money", ("%s", info));
	
	GetConVarString(h_GCrow_Price, price, sizeof(price));
	GetConVarString(h_GCrow_Short, short, sizeof(short));
	Format(info, sizeof(info), "Crowbar (%s) - $%s", short, price);
	
	AddMenuItem(h_GMel, "crow", ("%s", info));
	
	GetConVarString(h_GBaseBall_Price, price, sizeof(price));
	GetConVarString(h_GBaseBall_Short, short, sizeof(short));
	Format(info, sizeof(info), "Baseball Bat (%s) - $%s", short, price);
	
	AddMenuItem(h_GMel, "bat", ("%s", info));
	
	GetConVarString(h_GGuitar_Price, price, sizeof(price));
	GetConVarString(h_GGuitar_Short, short, sizeof(short));
	Format(info, sizeof(info), "Electric Guitar (%s) - $%s", short, price);
	
	AddMenuItem(h_GMel, "elec", ("%s", info));
	
	GetConVarString(h_GPan_Price, price, sizeof(price));
	GetConVarString(h_GPan_Short, short, sizeof(short));
	Format(info, sizeof(info), "Frying Pan (%s) - $%s", short, price);
	
	AddMenuItem(h_GMel, "pan", ("%s", info));
	
	GetConVarString(h_GGolf_Price, price, sizeof(price));
	GetConVarString(h_GGolf_Short, short, sizeof(short));
	Format(info, sizeof(info), "Golf Club (%s) - $%s", short, price);
	
	AddMenuItem(h_GMel, "golf", ("%s", info));
	
	GetConVarString(h_GAxe_Price, price, sizeof(price));
	GetConVarString(h_GAxe_Short, short, sizeof(short));
	Format(info, sizeof(info), "Fire Axe (%s) - $%s", short, price);
	
	AddMenuItem(h_GMel, "axe", ("%s", info));
	
	GetConVarString(h_GKatana_Price, price, sizeof(price));
	GetConVarString(h_GKatana_Short, short, sizeof(short));
	Format(info, sizeof(info), "Katana (%s) - $%s", short, price);
	
	AddMenuItem(h_GMel, "kat", ("%s", info));
	
	SetMenuPagination(h_GMel, 8);
	
	AddMenuItem(h_GMel, "money", ("You have $%s", money));
	
	GetConVarString(h_GMachete_Price, price, sizeof(price));
	GetConVarString(h_GMachete_Short, short, sizeof(short));
	Format(info, sizeof(info), "Machete (%s) - $%s", short, price);
	
	AddMenuItem(h_GMel, "mach", ("%s", info));
	
	GetConVarString(h_GChainSaw_Price, price, sizeof(price));
	GetConVarString(h_GChainSaw_Short, short, sizeof(short));
	Format(info, sizeof(info), "Chain Saw (%s) - $%s", short, price);
	
	AddMenuItem(h_GMel, "saw", ("%s", info));
	
	
	SetMenuExitBackButton(h_GMel, true);
}


//Infected Menus

public void buildInfectMenu(int client)
{
	h_Infect = CreateMenu(infectMenuCall);
	SetMenuTitle(h_Infect, "Infected");
	
	char money[10];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	
	AddMenuItem(h_Infect, "money", ("You have $%s", money));
	AddMenuItem(h_Infect, "bas", "Basics");
	AddMenuItem(h_Infect, "spec", "Become Special");
	AddMenuItem(h_Infect, "spaspec", "Spawn Special");
	AddMenuItem(h_Infect, "oth", "Spawn Other");
}

public void buildBasMenu(int client)
{
	h_Basic = CreateMenu(basMenuCall);
	SetMenuTitle(h_Basic, "1. Basics");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	
	
	AddMenuItem(h_Basic, "money", ("You have $%s", money));
	Format(info, sizeof(info), "You have $%s", money)
	
	GetConVarString(h_Healing_Infect_Price, price, sizeof(price));
	GetConVarString(h_Healing_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Healing (%s) - $%s", short, price)
	
	AddMenuItem(h_Basic, "heal", ("%s", info));
	
	GetConVarString(h_Suicide_Infect_Price, price, sizeof(price));
	GetConVarString(h_Suicide_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Suicide (%s) - $%s", short, price)
	
	AddMenuItem(h_Basic, "sui", ("%s", info));
	
	SetMenuPagination(h_Basic, 3);
	
	SetMenuExitBackButton(h_Basic, true);
	
}

public void buildSpecMenu(int client)
{
	h_Spec = CreateMenu(specMenuCall);
	SetMenuTitle(h_Spec, "2. Special Infected");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	Format(info, sizeof(info), "You have $%s", money)
	
	AddMenuItem(h_Spec, "money", ("You have $%s", money));
	
	GetConVarString(h_Smoker_Infect_Price, price, sizeof(price));
	GetConVarString(h_Smoker_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Smoker (%s) - $%s", short, price)
	
	AddMenuItem(h_Spec, "smoke", ("%s", info));
	
	GetConVarString(h_Boomer_Infect_Price, price, sizeof(price));
	GetConVarString(h_Boomer_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Boomer (%s) - $%s", short, price)
	
	AddMenuItem(h_Spec, "boom", ("%s", info));
	
	GetConVarString(h_Hunter_Infect_Price, price, sizeof(price));
	GetConVarString(h_Hunter_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Hunter (%s) - $%s", short, price)
	
	AddMenuItem(h_Spec, "hunt", ("%s", info));
	
	GetConVarString(h_Spitter_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spitter_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Spitter (%s) - $%s", short, price)
	
	AddMenuItem(h_Spec, "spit", ("%s", info));
	
	GetConVarString(h_Jockey_Infect_Price, price, sizeof(price));
	GetConVarString(h_Jockey_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Jockey (%s) - $%s", short, price)
	
	AddMenuItem(h_Spec, "jock", ("%s", info));
	
	GetConVarString(h_Charger_Infect_Price, price, sizeof(price));
	GetConVarString(h_Charger_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Charger (%s) - $%s", short, price)
	
	AddMenuItem(h_Spec, "char", ("%s", info));
	
	GetConVarString(h_Tank_Infect_Price, price, sizeof(price));
	GetConVarString(h_Tank_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Tank (%s) - $%s", short, price)
	
	AddMenuItem(h_Spec, "tank", ("%s", info));
	
	SetMenuPagination(h_Spec, 8);
	
	SetMenuExitBackButton(h_Spec, true);
	
}

public void buildSpawnMenu(int client)
{
	h_Spawn = CreateMenu(spawnMenuCall);
	SetMenuTitle(h_Spawn, "3. Spawn Special");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	Format(info, sizeof(info), "You have $%s", money)
	
	AddMenuItem(h_Spawn, "money", ("%s", info));
	
	GetConVarString(h_Spawn_Smoker_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_Smoker_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Smoker (%s) - $%s", short, price)
	
	AddMenuItem(h_Spawn, "smoke", ("%s", info));
	
	GetConVarString(h_Spawn_Boomer_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_Boomer_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Boomer (%s) - $%s", short, price)
	
	AddMenuItem(h_Spawn, "boom", ("%s", info));
	
	GetConVarString(h_Spawn_Hunter_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_Hunter_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Hunter (%s) - $%s", short, price)
	
	AddMenuItem(h_Spawn, "hunt", ("%s", info));
	
	GetConVarString(h_Spawn_Spitter_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_Spitter_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Machete (%s) - $%s", short, price)
	
	AddMenuItem(h_Spawn, "spit", ("%s", info));
	
	GetConVarString(h_Spawn_Jockey_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_Jockey_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Jockey (%s) - $%s", short, price)
	
	AddMenuItem(h_Spawn, "jock", ("%s", info));
	
	GetConVarString(h_Spawn_Charger_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_Charger_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Charger (%s) - $%s", short, price)
	
	AddMenuItem(h_Spawn, "char", ("%s", info));
	
	GetConVarString(h_Spawn_Tank_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_Tank_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Tank (%s) - $%s", short, price)
	
	AddMenuItem(h_Spawn, "tank", ("%s", info));
	
	SetMenuPagination(h_Spawn, 8);
	
	SetMenuExitBackButton(h_Spawn, true);
	
}

public void buildSpawnOthMenu(int client)
{
	h_SpOth = CreateMenu(spawnOthMenuCall);
	SetMenuTitle(h_SpOth, "4. Spawn Other");
	
	char money[10];
	char price[64];
	char short[64];
	char info[64];
	
	IntToString(i_Money[client], money, sizeof(money));
	Format(info, sizeof(info), "You have $%s", money)
	
	AddMenuItem(h_SpOth, "money", ("%s", info));
	
	GetConVarString(h_Spawn_Mob_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_Mob_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Mob (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "mob", ("%s", info));
	
	GetConVarString(h_Spawn_MegaMob_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_MegaMob_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Mega Mob (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "megmob", ("%s", info));
	
	GetConVarString(h_Spawn_Witch_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_Witch_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Witch (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "witch", ("%s", info));
	
	GetConVarString(h_Spawn_WitchBride_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_WitchBride_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Bride (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "bride", ("%s", info));
	
	GetConVarString(h_Spawn_CedaHorde_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_CedaHorde_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Ceda Horde (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "ceda", ("%s", info));
	
	GetConVarString(h_Spawn_ClownHorde_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_ClownHorde_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Clown Horde (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "clown", ("%s", info));
	
	GetConVarString(h_Spawn_MudHorde_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_MudHorde_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Mud Horde (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "mud", ("%s", info));
	
	SetMenuPagination(h_SpOth, 8);
	
	Format(info, sizeof(info), "You have %s", money)
	
	AddMenuItem(h_SpOth, "money", ("%s", info));
	
	GetConVarString(h_Spawn_RoadHorde_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_RoadHorde_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Roadcrew Horde (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "road", ("%s", info));
	
	GetConVarString(h_Spawn_RiotHorde_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_RiotHorde_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Riot Horde (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "riot", ("%s", info));
	
	GetConVarString(h_Spawn_JimmyHorde_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_JimmyHorde_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Jimmy Horde (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "jim", ("%s", info));
	
	GetConVarString(h_Spawn_FallenHorde_Infect_Price, price, sizeof(price));
	GetConVarString(h_Spawn_FallenHorde_Infect_Short, short, sizeof(short));
	Format(info, sizeof(info), "Fallen SUrvivor Horde (%s) - $%s", short, price)
	
	AddMenuItem(h_SpOth, "fall", ("%s", info));
	
	SetMenuExitBackButton(h_SpOth, true);
	
}

//Menu Callbacks

//Survivor Menu Callbacks
public int survivMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_Surviv, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "equip"))
		{
			buildEquipMenu(client);
			DisplayMenu(h_Equip, client, MENU_TIME_FOREVER);
		}
		else if (StrEqual(menitem, "weap"))
		{
			buildWeapMenu(client);
			DisplayMenu(h_Weap, client, MENU_TIME_FOREVER);
		}
		else if (StrEqual(menitem, "mel"))
		{
			buildMelMenu(client);
			DisplayMenu(h_Mel, client, MENU_TIME_FOREVER);
		}
		else if (StrEqual(menitem, "other"))
		{
			buildOthMenu(client);
			DisplayMenu(h_Other, client, MENU_TIME_FOREVER);
		}
		else if (StrEqual(menitem, "g_equip"))
		{
			buildGEquipMenu(client);
			DisplayMenu(h_GEquip, client, MENU_TIME_FOREVER);
		}
		else if (StrEqual(menitem, "g_weap"))
		{
			buildGWeapMenu(client);
			DisplayMenu(h_GWeap, client, MENU_TIME_FOREVER);
		}
		else if (StrEqual(menitem, "g_mel"))
		{
			buildGMelMenu(client);
			DisplayMenu(h_GMel, client, MENU_TIME_FOREVER);
		}
		
	}
	else if (action == MenuAction_Cancel)
	{
		
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int equipMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_Equip, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "heal"))
		{
			giveHeal(client);
		}
		else if (StrEqual(menitem, "res"))
		{
			giveResurr(client);
		}
		else if (StrEqual(menitem, "defib"))
		{
			giveDefib(client);
		}
		else if (StrEqual(menitem, "pill"))
		{
			givePill(client);
		}
		else if (StrEqual(menitem, "adren"))
		{
			giveAdren(client);
		}
		else if (StrEqual(menitem, "ammo"))
		{
			giveAmmo(client);
		}
		else if (StrEqual(menitem, "bile"))
		{
			giveBile(client);
		}
		else if (StrEqual(menitem, "pipe"))
		{
			givePipe(client);
		}
		else if (StrEqual(menitem, "molly"))
		{
			giveMolly(client);
		}
		else if (StrEqual(menitem, "incend"))
		{
			giveIncend(client);
		}
		else if (StrEqual(menitem, "explos"))
		{
			giveExplos(client);
		}
		else if (StrEqual(menitem, "laser"))
		{
			giveLaser(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildSurvivMenu(client);
			DisplayMenu(h_Surviv, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int weapMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_Weap, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "pistol"))
		{
			givePistol(client);
		}
		else if (StrEqual(menitem, "magnum"))
		{
			giveMagnum(client);
		}
		else if (StrEqual(menitem, "chrome"))
		{
			giveChrome(client);
		}
		else if (StrEqual(menitem, "SMG"))
		{
			giveSMG(client);
		}
		else if (StrEqual(menitem, "silent"))
		{
			giveSMGSilent(client);
		}
		else if (StrEqual(menitem, "auto"))
		{
			giveAuto(client);
		}
		else if (StrEqual(menitem, "spas"))
		{
			giveSpas(client);
		}
		else if (StrEqual(menitem, "combat"))
		{
			giveCombat(client);
		}
		else if (StrEqual(menitem, "ak"))
		{
			giveAK(client);
		}
		else if (StrEqual(menitem, "desert"))
		{
			giveDesert(client);
		}
		else if (StrEqual(menitem, "hunt"))
		{
			giveHunt(client);
		}
		else if (StrEqual(menitem, "snipe"))
		{
			giveSnipe(client);
		}
		else if (StrEqual(menitem, "launch"))
		{
			giveLaunch(client);
		}
		else if (StrEqual(menitem, "m60"))
		{
			giveM60(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildSurvivMenu(client);
			DisplayMenu(h_Surviv, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int melMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_Mel, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "crow"))
		{
			giveCrow(client);
		}
		else if (StrEqual(menitem, "bat"))
		{
			giveBat(client);
		}
		else if (StrEqual(menitem, "elec"))
		{
			giveElec(client);
		}
		else if (StrEqual(menitem, "pan"))
		{
			givePan(client);
		}
		else if (StrEqual(menitem, "golf"))
		{
			giveGolf(client);
		}
		else if (StrEqual(menitem, "axe"))
		{
			giveAxe(client);
		}
		else if (StrEqual(menitem, "katana"))
		{
			giveKat(client);
		}
		else if (StrEqual(menitem, "mach"))
		{
			giveMach(client);
		}
		else if (StrEqual(menitem, "saw"))
		{
			giveSaw(client);
		}
		
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildSurvivMenu(client);
			DisplayMenu(h_Surviv, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int othMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_Other, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "oxy"))
		{
			giveOxy(client);
		}
		else if (StrEqual(menitem, "prop"))
		{
			giveProp(client);
		}
		else if (StrEqual(menitem, "Fire"))
		{
			giveFire(client);
		}
		else if (StrEqual(menitem, "incend"))
		{
			giveIncendAm(client);
		}
		else if (StrEqual(menitem, "explos"))
		{
			giveExplosAm(client);
		}
		else if (StrEqual(menitem, "ammo"))
		{
			giveAmPile(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildSurvivMenu(client);
			DisplayMenu(h_Surviv, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int gequipMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_GEquip, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "heal"))
		{
			giveGHeal(client);
		}
		else if (StrEqual(menitem, "res"))
		{
			giveGResurr(client);
		}
		else if (StrEqual(menitem, "defib"))
		{
			giveGDefib(client);
		}
		else if (StrEqual(menitem, "pill"))
		{
			giveGPill(client);
		}
		else if (StrEqual(menitem, "adren"))
		{
			giveGAdren(client);
		}
		else if (StrEqual(menitem, "ammo"))
		{
			giveGAmmo(client);
		}
		else if (StrEqual(menitem, "bile"))
		{
			giveGBile(client);
		}
		else if (StrEqual(menitem, "pipe"))
		{
			giveGPipe(client);
		}
		else if (StrEqual(menitem, "molly"))
		{
			giveGMolly(client);
		}
		else if (StrEqual(menitem, "incend"))
		{
			giveGIncend(client);
		}
		else if (StrEqual(menitem, "explos"))
		{
			giveGExplos(client);
		}
		else if (StrEqual(menitem, "laser"))
		{
			giveGLaser(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildSurvivMenu(client);
			DisplayMenu(h_Surviv, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int gweapMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_GWeap, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "pistol"))
		{
			giveGPistol(client);
		}
		else if (StrEqual(menitem, "magnum"))
		{
			giveGMagnum(client);
		}
		else if (StrEqual(menitem, "chrome"))
		{
			giveGChrome(client);
		}
		else if (StrEqual(menitem, "SMG"))
		{
			giveGSMG(client);
		}
		else if (StrEqual(menitem, "silent"))
		{
			giveGSMGSilent(client);
		}
		else if (StrEqual(menitem, "auto"))
		{
			giveGAuto(client);
		}
		else if (StrEqual(menitem, "spas"))
		{
			giveGSpas(client);
		}
		else if (StrEqual(menitem, "combat"))
		{
			giveGCombat(client);
		}
		else if (StrEqual(menitem, "ak"))
		{
			giveGAK(client);
		}
		else if (StrEqual(menitem, "desert"))
		{
			giveGDesert(client);
		}
		else if (StrEqual(menitem, "hunt"))
		{
			giveGHunt(client);
		}
		else if (StrEqual(menitem, "snipe"))
		{
			giveGSnipe(client);
		}
		else if (StrEqual(menitem, "launch"))
		{
			giveGLaunch(client);
		}
		else if (StrEqual(menitem, "m60"))
		{
			giveGM60(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildSurvivMenu(client);
			DisplayMenu(h_Surviv, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int gmelMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_GMel, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "crow"))
		{
			giveGCrow(client);
		}
		else if (StrEqual(menitem, "bat"))
		{
			giveGBat(client);
		}
		else if (StrEqual(menitem, "elec"))
		{
			giveGElec(client);
		}
		else if (StrEqual(menitem, "pan"))
		{
			giveGPan(client);
		}
		else if (StrEqual(menitem, "golf"))
		{
			giveGGolf(client);
		}
		else if (StrEqual(menitem, "axe"))
		{
			giveGAxe(client);
		}
		else if (StrEqual(menitem, "katana"))
		{
			giveGKat(client);
		}
		else if (StrEqual(menitem, "mach"))
		{
			giveGMach(client);
		}
		else if (StrEqual(menitem, "saw"))
		{
			giveGSaw(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildSurvivMenu(client);
			DisplayMenu(h_Surviv, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

//Infected Menu Callbacks

public int infectMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_Infect, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "bas"))
		{
			buildBasMenu(client);
			DisplayMenu(h_Basic, client, MENU_TIME_FOREVER);
		}
		else if (StrEqual(menitem, "spec"))
		{
			buildSpecMenu(client);
			DisplayMenu(h_Spec, client, MENU_TIME_FOREVER);
		}
		else if (StrEqual(menitem, "spaspec"))
		{
			buildSpawnMenu(client);
			DisplayMenu(h_Spawn, client, MENU_TIME_FOREVER);
		}
		else if (StrEqual(menitem, "oth"))
		{
			buildSpawnOthMenu(client);
			DisplayMenu(h_SpOth, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int basMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_Basic, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "heal"))
		{
			giveIHeal(client);
		}
		else if (StrEqual(menitem, "sui"))
		{
			giveISui(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildInfectMenu(client);
			DisplayMenu(h_Infect, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int specMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_Spec, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "smoke"))
		{
			giveISmoke(client);
		}
		else if (StrEqual(menitem, "boom"))
		{
			giveIBoom(client);
		}
		else if (StrEqual(menitem, "hunt"))
		{
			giveIHunt(client);
		}
		else if (StrEqual(menitem, "spit"))
		{
			giveISpit(client);
		}
		else if (StrEqual(menitem, "jock"))
		{
			giveIJock(client);
		}
		else if (StrEqual(menitem, "char"))
		{
			giveIChar(client);
		}
		else if (StrEqual(menitem, "tank"))
		{
			giveITank(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildInfectMenu(client);
			DisplayMenu(h_Infect, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int spawnMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_Spawn, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "smoke"))
		{
			giveISSmoke(client);
		}
		else if (StrEqual(menitem, "boom"))
		{
			giveISBoom(client);
		}
		else if (StrEqual(menitem, "hunt"))
		{
			giveISHunt(client);
		}
		else if (StrEqual(menitem, "spit"))
		{
			giveISSpit(client);
		}
		else if (StrEqual(menitem, "jock"))
		{
			giveISJock(client);
		}
		else if (StrEqual(menitem, "char"))
		{
			giveISChar(client);
		}
		else if (StrEqual(menitem, "tank"))
		{
			giveISTank(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildInfectMenu(client);
			DisplayMenu(h_Infect, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

public int spawnOthMenuCall(Menu menu, MenuAction action, int client, int item)
{
	if (action == MenuAction_Select)
	{
		char menitem[64];
		GetMenuItem(h_SpOth, item, menitem, sizeof(menitem));
		
		if (StrEqual(menitem, "mob"))
		{
			giveISMob(client);
		}
		else if (StrEqual(menitem, "witch"))
		{
			giveISWitch(client);
		}
		else if (StrEqual(menitem, "bride"))
		{
			giveISBride(client);
		}
		else if (StrEqual(menitem, "ceda"))
		{
			giveISCeda(client);
		}
		else if (StrEqual(menitem, "clown"))
		{
			giveISClown(client);
		}
		else if (StrEqual(menitem, "mud"))
		{
			giveISMud(client);
		}
		else if (StrEqual(menitem, "road"))
		{
			giveISRoad(client);
		}
		else if (StrEqual(menitem, "riot"))
		{
			giveISRiot(client);
		}
		else if (StrEqual(menitem, "jim"))
		{
			giveISJim(client);
		}
		else if (StrEqual(menitem, "fall"))
		{
			giveISFall(client);
		}
	}
	else if (action == MenuAction_Cancel)
	{
		if (item == MenuCancel_ExitBack)
		{
			buildInfectMenu(client);
			DisplayMenu(h_Infect, client, MENU_TIME_FOREVER);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}

//Timer Callbacks

public Action menuMessage(Handle timer, Handle hndl)
{
	CPrintToChatAll("[STORE] {red} You can use the following commands to open the buy menu {blue} !buy, !store, !buymenu, and !shop");
}

//Menu CMDS

public void giveHeal(int client)
{
	int cost = GetConVarInt(h_Healing_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			SetEntityHealth(client, 100);
		}
	}
}

public void giveResurr(int client)
{
	int cost = GetConVarInt(h_Ress_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		i_Ress[client]++;
	}
}

public void giveFirst(int client)
{
	int cost = GetConVarInt(h_FirstAid_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Aid, client);
		}
	}
}

public void RequestFrame_Aid(int client)
{
	CheatCommand(client, "give", "first_aid_kit");
}

public void giveDefib(int client)
{
	int cost = GetConVarInt(h_Defibrillator_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Defib, client);
		}
	}
}

public void RequestFrame_Defib(int client)
{
	CheatCommand(client, "give", "defibrillator");
}

public void givePill(int client)
{
	int cost = GetConVarInt(h_PainPill_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Pill, client);
		}
	}
}

public void RequestFrame_Pill(int client)
{
	CheatCommand(client, "give", "pain_pills");
}

public void giveAdren(int client)
{
	int cost = GetConVarInt(h_Adrena_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Adrena, client);
		}
	}
}

public void RequestFrame_Adrena(int client)
{
	CheatCommand(client, "give", "adrenaline");
}

public void giveAmmo(int client)
{
	int cost = GetConVarInt(h_Ammo_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Ammo, client);
		}
	}
}

public void RequestFrame_Ammo(int client)
{
	CheatCommand(client, "give", "ammo");
}

public void giveBile(int client)
{
	int cost = GetConVarInt(h_BileBomb_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Bile, client);
		}
	}
}

public void RequestFrame_Bile(int client)
{
	CheatCommand(client, "give", "vomitjar");
}


public void givePipe(int client)
{
	int cost = GetConVarInt(h_PipeBomb_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Pipe, client);
		}
	}
}

public void RequestFrame_Pipe(int client)
{
	CheatCommand(client, "give", "pipe_bomb");
}

public void giveMolly(int client)
{
	int cost = GetConVarInt(h_Molly_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Molly, client);
		}
	}
}

public void RequestFrame_Molly(int client)
{
	CheatCommand(client, "give", "molotov");
}

public void giveIncend(int client)
{
	int cost = GetConVarInt(h_Incendiary_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Incend, client);
		}
	}
}

public void RequestFrame_Incend(int client)
{
	CheatCommand(client, "upgrade_add", "incendiary_ammo");
}

public void giveExplos(int client)
{
	int cost = GetConVarInt(h_Explosive_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Explos, client);
		}
	}
}

public void RequestFrame_Explos(int client)
{
	CheatCommand(client, "upgrade_add", "explosive_ammo");
}

public void giveLaser(int client)
{
	int cost = GetConVarInt(h_Laser_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_Laser, client);
		}
	}
}

public void RequestFrame_Laser(int client)
{
	CheatCommand(client, "upgrade_add", "laser_sight");
}

public void givePistol(int client)
{
	int cost = GetConVarInt(h_Pistol_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Pistol, client);
		}
	}
}

public void RequestFrame_Pistol(int client)
{
	CheatCommand(client, "give", "pistol");
}

public void giveMagnum(int client)
{
	int cost = GetConVarInt(h_Magnum_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Magnum, client);
		}
	}
}

public void RequestFrame_Magnum(int client)
{
	CheatCommand(client, "give", "pistol_magnum");
}

public void giveChrome(int client)
{
	int cost = GetConVarInt(h_ChromeShot_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Chrome, client);
		}
	}
}

public void RequestFrame_Chrome(int client)
{
	CheatCommand(client, "give", "shotgun_chrome");
}

public void givePump(int client)
{
	int cost = GetConVarInt(h_PumpShot_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Pump, client);
		}
	}
}

public void RequestFrame_Pump(int client)
{
	CheatCommand(client, "give", "pumpshotgun");
}

public void giveSMG(int client)
{
	int cost = GetConVarInt(h_SMG_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_SMG, client);
		}
	}
}

public void RequestFrame_SMG(int client)
{
	CheatCommand(client, "give", "smg");
}

public void giveSMGSilent(int client)
{
	int cost = GetConVarInt(h_SMG_Silent_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_SMGSilent, client);
		}
	}
}

public void RequestFrame_SMGSilent(int client)
{
	CheatCommand(client, "give", "smg_silenced");
}

public void giveAuto(int client)
{
	int cost = GetConVarInt(h_AutoShot_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Auto, client);
		}
	}
}

public void RequestFrame_Auto(int client)
{
	CheatCommand(client, "give", "autoshotgun");
}

public void giveSpas(int client)
{
	int cost = GetConVarInt(h_Spas_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Spas, client);
		}
	}
}

public void RequestFrame_Spas(int client)
{
	CheatCommand(client, "give", "shotgun_spas");
}

public void giveCombat(int client)
{
	int cost = GetConVarInt(h_CombatRifle_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Combat, client);
		}
	}
}

public void RequestFrame_Combat(int client)
{
	CheatCommand(client, "give", "rifle");
}

public void giveAK(int client)
{
	int cost = GetConVarInt(h_AK_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_AK, client);
		}
	}
}

public void RequestFrame_AK(int client)
{
	CheatCommand(client, "give", "rifle_ak47");
}

public void giveDesert(int client)
{
	int cost = GetConVarInt(h_Desert_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Desert, client);
		}
	}
}

public void RequestFrame_Desert(int client)
{
	CheatCommand(client, "give", "rifle_desert");
}

public void giveHunt(int client)
{
	int cost = GetConVarInt(h_Hunt_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Hunt, client);
		}
	}
}

public void RequestFrame_Hunt(int client)
{
	CheatCommand(client, "give", "hunting_rifle");
}

public void giveSnipe(int client)
{
	int cost = GetConVarInt(h_Snipe_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Snipe, client);
		}
	}
}

public void RequestFrame_Snipe(int client)
{
	CheatCommand(client, "give", "sniper_military");
}

public void giveLaunch(int client)
{
	int cost = GetConVarInt(h_Grena_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Launch, client);
		}
	}
}

public void RequestFrame_Launch(int client)
{
	CheatCommand(client, "give", "grenade_launcher");
}

public void giveM60(int client)
{
	int cost = GetConVarInt(h_M60_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 0);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_M60, client);
		}
	}
}

public void RequestFrame_M60(int client)
{
	CheatCommand(client, "give", "rifle_m60");
}

public void giveCrow(int client)
{
	int cost = GetConVarInt(h_Crow_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Crow, client);
		}
	}
}

public void RequestFrame_Crow(int client)
{
	CheatCommand(client, "give", "crowbar");
}

public void giveBat(int client)
{
	int cost = GetConVarInt(h_BaseBall_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Bat, client);
		}
	}
}

public void RequestFrame_Bat(int client)
{
	CheatCommand(client, "give", "baseball_bat");
}

public void giveElec(int client)
{
	int cost = GetConVarInt(h_Guitar_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Guitar, client);
		}
	}
}

public void RequestFrame_Guitar(int client)
{
	CheatCommand(client, "give", "electric_guitar");
}

public void givePan(int client)
{
	int cost = GetConVarInt(h_Pan_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Pan, client);
		}
	}
}

public void RequestFrame_Pan(int client)
{
	CheatCommand(client, "give", "frying_pan");
}

public void giveGolf(int client)
{
	int cost = GetConVarInt(h_Golf_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Golf, client);
		}
	}
}

public void RequestFrame_Golf(int client)
{
	CheatCommand(client, "give", "golfclub");
}

public void giveAxe(int client)
{
	int cost = GetConVarInt(h_Axe_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Axe, client);
		}
	}
}

public void RequestFrame_Axe(int client)
{
	CheatCommand(client, "give", "fireaxe");
}

public void giveKat(int client)
{
	int cost = GetConVarInt(h_Katana_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Katana, client);
		}
	}
}

public void RequestFrame_Katana(int client)
{
	CheatCommand(client, "give", "katana");
}

public void giveMach(int client)
{
	int cost = GetConVarInt(h_Machete_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Mach, client);
		}
	}
}

public void RequestFrame_Mach(int client)
{
	CheatCommand(client, "give", "machete");
}

public void giveSaw(int client)
{
	int cost = GetConVarInt(h_ChainSaw_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			int entity = GetPlayerWeaponSlot(client, 1);
			if (entity != -1)
				AcceptEntityInput(entity, "Kill");
			
			RequestFrame(RequestFrame_Saw, client);
		}
	}
}

public void RequestFrame_Saw(int client)
{
	CheatCommand(client, "give", "chainsaw");
}

public void giveOxy(int client)
{
	int cost = GetConVarInt(h_OxyTank_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			CheatCommand(client, "give", "oxygentank");
		}
	}
}

public void giveProp(int client)
{
	int cost = GetConVarInt(h_ProTank_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			CheatCommand(client, "give", "propanetank");
		}
	}
}

public void giveFire(int client)
{
	int cost = GetConVarInt(h_FireCrate_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			CheatCommand(client, "give", "fireworkcrate");
		}
	}
}


public void giveIncendAm(int client)
{
	int cost = GetConVarInt(h_IncendAmmo_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			
			RequestFrame(RequestFrame_IncendAmmo, client);
		}
	}
}

public void RequestFrame_IncendAmmo(int client)
{
	CheatCommand(client, "give", "upgradepack_incendiary");
}

public void giveExplosAm(int client)
{
	int cost = GetConVarInt(h_ExplosAmmo_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			RequestFrame(RequestFrame_ExplosAmmo, client);
		}
	}
}

public void RequestFrame_ExplosAmmo(int client)
{
	CheatCommand(client, "give", "upgradepack_explosive");
}

public void giveAmPile(int client)
{
	int cost = GetConVarInt(h_AmmoPile_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			SpawnAmmoPile(client);
		}
	}
}

public void giveGHeal(int client)
{
	int cost = GetConVarInt(h_GHealing_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				SetEntityHealth(i, 100);
			}
		}
	}
}


public void giveGResurr(int client)
{
	int cost = GetConVarInt(h_GRess_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			i_Ress[client]++;
		}
	}
}

public void giveGFirst(int client)
{
	int cost = GetConVarInt(h_GFirstAid_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Aid, i);
			}
		}
	}
}

public void giveGDefib(int client)
{
	int cost = GetConVarInt(h_GDefibrillator_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Defib, i);
			}
		}
	}
}

public void giveGPill(int client)
{
	int cost = GetConVarInt(h_GPainPill_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Pill, i);
			}
		}
	}
}

public void giveGAdren(int client)
{
	int cost = GetConVarInt(h_GAdrena_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Adrena, i);
			}
		}
	}
}

public void giveGAmmo(int client)
{
	int cost = GetConVarInt(h_GAmmo_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				SpawnAmmoPile(i);
			}
		}
	}
}

public void giveGBile(int client)
{
	int cost = GetConVarInt(h_GBileBomb_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Bile, i);
			}
		}
	}
}

public void giveGPipe(int client)
{
	int cost = GetConVarInt(h_GPipeBomb_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Pipe, i);
			}
		}
	}
}

public void giveGMolly(int client)
{
	int cost = GetConVarInt(h_GMolly_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Molly, i);
			}
		}
	}
}

public void giveGIncend(int client)
{
	int cost = GetConVarInt(h_GIncendiary_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Incend, i);
			}
		}
	}
}

public void giveGExplos(int client)
{
	int cost = GetConVarInt(h_GExplosive_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Explos, i);
			}
		}
	}
}

public void giveGLaser(int client)
{
	int cost = GetConVarInt(h_GLaser_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				RequestFrame(RequestFrame_Laser, i);
			}
		}
	}
}

public void giveGPistol(int client)
{
	int cost = GetConVarInt(h_GPistol_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Pistol, i);
			}
		}
	}
}

public void giveGMagnum(int client)
{
	int cost = GetConVarInt(h_GMagnum_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Magnum, i);
			}
		}
	}
}

public void giveGChrome(int client)
{
	int cost = GetConVarInt(h_GChromeShot_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Chrome, i);
			}
		}
	}
}

public void giveGPump(int client)
{
	int cost = GetConVarInt(h_GPumpShot_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Pump, i);
			}
		}
	}
}

public void giveGSMG(int client)
{
	int cost = GetConVarInt(h_GSMG_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_SMG, i);
			}
		}
	}
}

public void giveGSMGSilent(int client)
{
	int cost = GetConVarInt(h_GSMG_Silent_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_SMGSilent, i);
			}
		}
	}
}

public void giveGAuto(int client)
{
	int cost = GetConVarInt(h_GAutoShot_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Auto, i);
			}
		}
	}
}

public void giveGSpas(int client)
{
	int cost = GetConVarInt(h_GSpas_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Spas, i);
			}
		}
	}
}

public void giveGCombat(int client)
{
	int cost = GetConVarInt(h_GCombatRifle_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Combat, i);
			}
		}
	}
}

public void giveGAK(int client)
{
	int cost = GetConVarInt(h_GAK_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_AK, i);
			}
		}
	}
}

public void giveGDesert(int client)
{
	int cost = GetConVarInt(h_GDesert_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Desert, i);
			}
		}
	}
}

public void giveGHunt(int client)
{
	int cost = GetConVarInt(h_GHunt_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Hunt, i);
			}
		}
	}
}

public void giveGSnipe(int client)
{
	int cost = GetConVarInt(h_GSnipe_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Snipe, i);
			}
		}
	}
}

public void giveGLaunch(int client)
{
	int cost = GetConVarInt(h_GGrena_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Launch, i);
			}
		}
	}
}

public void giveGM60(int client)
{
	int cost = GetConVarInt(h_GM60_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 0);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_M60, i);
			}
		}
	}
}

public void giveGCrow(int client)
{
	int cost = GetConVarInt(h_GCrow_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Crow, i);
			}
		}
	}
}

public void giveGBat(int client)
{
	int cost = GetConVarInt(h_GBaseBall_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Bat, i);
			}
		}
	}
}

public void giveGElec(int client)
{
	int cost = GetConVarInt(h_GGuitar_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Guitar, i);
			}
		}
	}
}

public void giveGPan(int client)
{
	int cost = GetConVarInt(h_GPan_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Pan, i);
			}
		}
	}
}

public void giveGGolf(int client)
{
	int cost = GetConVarInt(h_GGolf_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Golf, i);
			}
		}
	}
}

public void giveGAxe(int client)
{
	int cost = GetConVarInt(h_GAxe_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Axe, i);
			}
		}
	}
}

public void giveGKat(int client)
{
	int cost = GetConVarInt(h_GKatana_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Katana, i);
			}
		}
	}
}

public void giveGMach(int client)
{
	int cost = GetConVarInt(h_GMachete_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Mach, i);
			}
		}
	}
}

public void giveGSaw(int client)
{
	int cost = GetConVarInt(h_GChainSaw_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		for (int i = 1; i < MaxClients; i++)
		{
			if (IsPlayerAlive(i) && GetClientTeam(i) == 2)
			{
				int entity = GetPlayerWeaponSlot(i, 1);
				if (entity != -1)
					AcceptEntityInput(entity, "Kill");
				
				RequestFrame(RequestFrame_Saw, i);
			}
		}
	}
}

public void giveIHeal(int client)
{
	
	int cost = GetConVarInt(h_Healing_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			SetEntityHealth(client, 100);
		}
	}
}

public void giveISui(int client)
{
	
}

public void giveISmoke(int client)
{
	
}

public void giveIBoom(int client)
{
	
}

public void giveIHunt(int client)
{
	
}

public void giveISpit(int client)
{
	
}

public void giveIJock(int client)
{
	
}

public void giveIChar(int client)
{
	
}

public void giveITank(int client)
{
	
}

public void giveISSmoke(int client)
{
	int cost = GetConVarInt(h_Spawn_Smoker_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn smoker");
		}
	}
}

public void giveISBoom(int client)
{
	int cost = GetConVarInt(h_Spawn_Boomer_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn boomer");
		}
	}
}

public void giveISHunt(int client)
{
	int cost = GetConVarInt(h_Spawn_Hunter_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn hunter");
		}
	}
}

public void giveISSpit(int client)
{
	int cost = GetConVarInt(h_Spawn_Spitter_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn spitter");
		}
	}
}

public void giveISJock(int client)
{
	int cost = GetConVarInt(h_Spawn_Jockey_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn jockey");
		}
	}
}

public void giveISChar(int client)
{
	int cost = GetConVarInt(h_Spawn_Charger_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn charger");
		}
	}
}

public void giveISTank(int client)
{
	int cost = GetConVarInt(h_Spawn_Tank_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn tank");
		}
	}
}

public void giveISMob(int client)
{
	int cost = GetConVarInt(h_Spawn_Mob_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn mob");
		}
	}
}

public void giveISMegMob(int client)
{
	int cost = GetConVarInt(h_Spawn_MegaMob_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn megamob");
		}
	}
}

public void giveISWitch(int client)
{
	int cost = GetConVarInt(h_Spawn_Witch_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn witch");
		}
	}
}

public void giveISBride(int client)
{
	int cost = GetConVarInt(h_Spawn_WitchBride_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn bride");
		}
	}
}

public void giveISCeda(int client)
{
	int cost = GetConVarInt(h_Spawn_CedaHorde_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn mob");
		}
	}
}

public void giveISClown(int client)
{
	int cost = GetConVarInt(h_Spawn_ClownHorde_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn mob");
		}
	}
}

public void giveISMud(int client)
{
	int cost = GetConVarInt(h_Spawn_MudHorde_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn mob");
		}
	}
}

public void giveISRoad(int client)
{
	int cost = GetConVarInt(h_Spawn_RoadHorde_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn mob");
		}
	}
}

public void giveISRiot(int client)
{
	int cost = GetConVarInt(h_Spawn_RiotHorde_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn mob");
		}
	}
}

public void giveISJim(int client)
{
	int cost = GetConVarInt(h_Spawn_JimmyHorde_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn mob");
		}
	}
}

public void giveISFall(int client)
{
	int cost = GetConVarInt(h_Spawn_FallenHorde_Infect_Price);
	if (i_Money[client] > cost)
	{
		i_Money[client] -= cost;
		if (IsPlayerAlive(client))
		{
			ServerCommand("z_spawn mob");
		}
	}
}


//Event Hook Callbacks

public Action Event_SwitchTeam(Event event, const char[] name, bool dontBroadcast)
{
	int user = GetEventInt(event, "userid");
	int client = GetClientOfUserId(user);
	i_Money[client] = 0;
}

public Action Event_PlayerHurt(Event event, const char[] name, bool dontBroadcast)
{
	int attacker = GetEventInt(event, "attacker");
	int client = GetClientOfUserId(attacker);
	if (!IsFakeClient(client))
	{
		int dmg = GetEventInt(event, "dmg_health");
		i_Money[client] += (dmg * GetConVarFloat(h_MoneyfromDamage));
	}
}

public int GetZombieType(int client)
{
	return GetEntProp(client, Prop_Send, "m_zombieClass");
}

public Action Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	int attacker = GetEventInt(event, "attacker");
	int client = GetClientOfUserId(attacker);
	int user = GetEventInt(event, "userid");
	int deadclient = GetClientOfUserId(user);
	char victim[64];
	GetEventString(event, "victimname", victim, sizeof(victim));
	
	int class = GetZombieType(client);
	int money;
	if (!IsFakeClient(client))
	{
		if (GetClientTeam(deadclient) == 2)
			money = GetConVarInt(h_MoneyfromSurvivor);
		else if (class == ZOMBIECLASS_HUNTER)
			money = GetConVarInt(h_MoneyfromHunter);
		else if (class == ZOMBIECLASS_SMOKER)
			money = GetConVarInt(h_MoneyfromSmoker);
		else if (class == ZOMBIECLASS_BOOMER)
			money = GetConVarInt(h_MoneyfromBoomer);
		else if (class == ZOMBIECLASS_TANK)
			money = GetConVarInt(h_MoneyfromTank);
		else if (class == ZOMBIECLASS_WITCH)
			money = GetConVarInt(h_MoneyfromWitch);
		else if (class == ZOMBIECLASS_JOCKEY)
			money = GetConVarInt(h_MoneyfromJockey);
		else if (class == ZOMBIECLASS_CHARGER)
			money = GetConVarInt(h_MoneyfromCharger);
		else if (class == ZOMBIECLASS_SPITTER)
			money = GetConVarInt(h_MoneyfromSpitter);
		else if (class == ZOMBIECLASS_RARE)
			money = GetConVarInt(h_MoneyfromRare);
		i_Money[client] += money;
	}
	
	
	
}

public void RespawnClient(int client)
{
	SetEntityHealth(client, 100);
	char map[64];
	GetCurrentMap(map, sizeof(map));
	
	Handle file = OpenFile("saferooms.txt", "r", false);
	char line[128];
	char array[4][128];
	float x;
	float y;
	float z;
	while (!IsEndOfFile(file) && ReadFileLine(file, line, sizeof(line)))
	{
		if (StrContains(line, map) != -1)
		{
			ExplodeString(line, " ", array, sizeof(array), sizeof(array[]));
			x = StringToFloat(array[1]);
			y = StringToFloat(array[2]);
			z = StringToFloat(array[3]);
			break;
		}
	}
	
	float loc[3];
	loc[0] = x;
	loc[1] = y;
	loc[2] = z;
	
	
	if (x != 0 && y != 0 && z != 0)
		TeleportEntity(client, loc, NULL_VECTOR, NULL_VECTOR);
	
	else
		CPrintToChatAll("{green}saferooms.txt doesn't contain info for this map");
	
	int entity = GetPlayerWeaponSlot(client, 0);
	if (entity != -1)
		AcceptEntityInput(entity, "Kill");
	entity = GetPlayerWeaponSlot(client, 1);
	if (entity != -1)
		AcceptEntityInput(entity, "Kill");
	entity = GetPlayerWeaponSlot(client, 2);
	if (entity != -1)
		AcceptEntityInput(entity, "Kill");
	
	RequestFrame(RequestFrame_Pistol, client);
	RequestFrame(RequestFrame_Crow, client);
	
	
	
	CloseHandle(file);
}

public Action Event_PlayerDeath_Pre(Event event, const char[] name, bool dontBroadcast)
{
	int user = GetEventInt(event, "userid");
	int deadclient = GetClientOfUserId(user);
	
	if (GetClientTeam(deadclient) == 2 && i_Ress[deadclient] > 0)
	{
		i_Ress[deadclient]--;
		RespawnClient(deadclient);
	}
}

public bool SpawnObjectFilter(entity, contentsMask, any:client)
{
	if (entity == client)
		return false;
	
	if ((entity > 0) && (entity <= MaxClients))
		return false;
	
	return true;
}

// Extra Stuffz

public SpawnAmmoPile(client)
{
	decl Float:origin[3];
	decl Float:angles[3];
	decl Float:target[3];
	
	GetClientEyePosition(client, origin);
	GetClientEyeAngles(client, angles);
	
	new Handle:trace = TR_TraceRayFilterEx(origin, angles, MASK_SOLID_BRUSHONLY, RayType_Infinite, SpawnObjectFilter, client);
	
	if (TR_DidHit(trace))
	{
		TR_GetEndPosition(target, trace);
		
		new entity = CreateEntityByName("weapon_ammo_spawn");
		
		if (IsValidEdict(entity))
		{
			DispatchKeyValue(entity, "solid", "0");
			
			SetEntityModel(entity, "models/props/terror/ammo_stack.mdl");
			
			
		}
		
		CloseHandle(trace);
		
		angles[0] = 0.0;
		angles[1] = 0.0;
		
		DispatchSpawn(entity);
		
		TeleportEntity(entity, target, angles, NULL_VECTOR);
	}
}

stock CheatCommand(client, const String:command[], const String:arguments[])
{
	new adminFlags = GetUserFlagBits(client);
	new commandflags = GetCommandFlags(command);
	
	SetUserFlagBits(client, ADMFLAG_ROOT);
	SetCommandFlags(command, commandflags & ~FCVAR_CHEAT);
	
	FakeClientCommand(client, "%s %s", command, arguments);
	
	SetCommandFlags(command, commandflags);
	SetUserFlagBits(client, adminFlags);
}
