
#include <sdkhooks>
#include <sdktools>


public Plugin myinfo = 
{
	name = "PistolFix",
	author = "African",
	description = "Allow players to spawn with pistols",
	version = "0.5",
	url = ""
};

public void OnPluginStart()
{
	
}

public OnEntityCreated(entity, const char[] classname)
{
    if(StrEqual(classname, "game_player_equip"))
    {
        AcceptEntityInput(entity, "Kill");
    }
}  