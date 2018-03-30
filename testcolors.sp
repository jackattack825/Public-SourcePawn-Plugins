
#include <sourcemod>
#include <sdktools>
#include <colors_codes>


public Plugin myinfo = 
{
	name = "Test Colors",
	author = "African",
	description = "to test colors",
	version = "0.1",
	url = "prgaming.net"
};

public void OnPluginStart()
{
	RegAdminCmd("sm_testregular", CMD_Regular, ADMFLAG_GENERIC);
	RegAdminCmd("sm_testinclude", CMD_Include, ADMFLAG_GENERIC);
}

public Action CMD_Regular(int client, int args)
{
	PrintToChatAll("Colour Test: \x01 Test1 \x02 Test2 \x03 Test3 \x04 Test4 \x05 Test5 \x06 Test6 \x07 Test7 \x08 Test8 \x09 Test9\n");
}

public Action CMD_Include(int client, int args)
{
	CPrintToChatAll("Colour Test: {default} default {darkred} darkred {pink} pink {green} green {grey} grey {olive} olive {a} a {darkorange} darkorange {orange} orange");
}