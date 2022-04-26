
//mef_magic_bomb_map_ButtonDown.sqf

//future use

//flag to update main page target location
_mouse_button = _this select 1;  //0=left, 1=right

//execute if left mouse button clicked
if (_mouse_button == 0 && MEF_MAGIC_ENABLE_MOVING_TGT_LOC) then
{
	MEF_MAGIC_MAP_BUTTON_DOWN = TRUE;
};
