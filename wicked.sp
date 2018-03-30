#include <sourcemod>
#include <sdktools>

int tTagCollected;
 

  public Plugin myinfo = 
  {
   name = "MenuForPlayer",
   author = "Wicked",
   description = "menu that shows player id,name,team on sm_who",
   version = "1",
   url = ""
  }
 
  public void OnPluginStart()
  {
  	HookEvent("player_death", createTag);
  }
  
  public Action createTag(Event event, const char[] name, bool dontBroadcast)
 {
	CreateEntityByName("dogTag", edit);
	}
