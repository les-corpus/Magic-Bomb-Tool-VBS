
//Call this file using the following script in the player's initialization statement

//[this] call fn_magicBombTool;

//vbs include
#include "\vbs2\headers\dikCodes.hpp"

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//development variables
#ifdef MEF_MAGIC_BOMB_USE_MISSION_SCRIPTS
_projectDataFolder = "P:\vbs2\customer\other\mef_magic_bomb_tool\data\";
#else
_projectDataFolder = "\vbs2\customer\other\mef_magic_bomb_tool\data\";
#endif

//add action to unit calling the script
_unit = _this select 0;

_aspectRatioX = aspectRatio select 0;

if (_aspectRatioX < 1.3 || _aspectRatioX > 1.4) then
{
	warningMessage "For Best Results, Use an Aspect Ratio of 16:9 - Wide";
};

//wait for mission to start
waitUntil {applicationState select 0 && (applicationState select 1) != "OME"};

//prevent adding multiple times
if(local _unit) then
{
	_unit addAction ["Open ARMNIT", (_projectDataFolder + "scripts\mef_magic_bomb_loadGUI.sqf")];

	//open the GUI when player joins
	waitUntil {isPlayer _unit};
	
	nul = [] execVM (_projectDataFolder + "scripts\mef_magic_bomb_loadGUI.sqf");
};



