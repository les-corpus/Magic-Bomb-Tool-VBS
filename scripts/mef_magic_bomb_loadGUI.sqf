

//opens the GUI

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

MEF_MAGIC_BINDKEYS = [];

//fade in and open the GUI
titleText ["Loading ARMNIT", "BLACK FADED"];
sleep .5;
titleText ["Loading ARMNIT", "BLACK IN"];

nul = createDialog "MEF_MAGIC_BOMB_TOOL";

MAGIC_KEYID_T = DIK_T bindKey format ["nul = ['DIK_T'] execVM '%1scripts\mef_magic_bomb_bindKey_actions.sqf'; TRUE", _projectDataFolder];
MAGIC_KEYID_RETURN = DIK_RETURN  bindKey format ["nul = ['DIK_RETURN'] execVM '%1scripts\mef_magic_bomb_bindKey_actions.sqf'; TRUE", _projectDataFolder];
MAGIC_KEYID_NUMPADENTER = DIK_NUMPADENTER bindKey format ["nul = ['DIK_NUMPADENTER'] execVM '%1scripts\mef_magic_bomb_bindKey_actions.sqf'; TRUE", _projectDataFolder];

//global variable when GUI is closed
MEF_MAGIC_BINDKEYS = MEF_MAGIC_BINDKEYS + [MAGIC_KEYID_T, MAGIC_KEYID_RETURN, MAGIC_KEYID_NUMPADENTER];