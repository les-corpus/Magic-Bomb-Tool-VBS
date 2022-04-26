//for future user 

//when user LMB Double click on map.  Also tracks condition of Shift, Ctrl, and Alt keys

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

_map = _this select 0;
_map_x = _this select 2;
_map_y = _this select 3;

_shift_key_pressed = _this select 4;
_ctrl_key_pressed = _this select 5;
_alt_key_pressed = _this select 6;

_display = MEF_MAGIC_BOMB_TOOL;

