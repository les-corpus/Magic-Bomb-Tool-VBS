//mef_magic_bomb_map_ButtonUp.sqf

//future use

//flags to stop updating moving map target location
_mouse_button = _this select 1;  //0=left, 1=right

//execute if left mouse button clicked
if (_mouse_button == 0 && MEF_MAGIC_ENABLE_MOVING_TGT_LOC) then
{
	MEF_MAGIC_MAP_BUTTON_DOWN = FALSE;
	MEF_MAGIC_ENABLE_MOVING_TGT_LOC = FALSE;

	//save target location as game coords
	missionNamespace setVariable ["MEF_MAGIC_IMPACT_POINT", MEF_MAGIC_MAP_TO_GAME_COORDS];  //init impact point

	//calculate additional aimpoints
	_aimPoint_array = call fn_magic_find_aimPoints;
	
	missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array]; //aimpoints for each gun
	missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
	
	//save target location as MGRS parts
	missionNamespace setVariable ["MEF_MAGIC_MSN_TYPE", "(Moving Marker)"];
	missionNamespace setVariable ["MEF_MAGIC_TGT_ZONE", MEF_MAGIC_TGT_ZONE];
	missionNamespace setVariable ["MEF_MAGIC_TGT_SQID", MEF_MAGIC_TGT_SQID];
	missionNamespace setVariable ["MEF_MAGIC_TGT_NORTH", MEF_MAGIC_TGT_NORTH];
	missionNamespace setVariable ["MEF_MAGIC_TGT_EAST", MEF_MAGIC_TGT_EAST];

};

