//loop to update map icons and draw on the 2D map

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//development variables
#ifdef MEF_MAGIC_BOMB_USE_MISSION_SCRIPTS
_projectDataFolder = "P:\vbs2\customer\other\mef_magic_bomb_tool\data\";
#else
_projectDataFolder = "\vbs2\customer\other\mef_magic_bomb_tool\data\";
#endif

//display
_display = MEF_MAGIC_BOMB_TOOL;
_map = _display displayCtrl IDC_MAIN_2D_MAP;

//OLT and GTL data
_otl_data_ctrl = _display displayCtrl IDC_MAIN_OTL_DATA;
_gtl_data_ctrl = _display displayCtrl IDC_MAIN_GTL_DATA;

//watch
_ctrl_day_month_date = _display displayCtrl IDC_MAIN_WATCH_DY_MM_DD;
_ctrl_hr_min_sec = _display displayCtrl IDC_MAIN_WATCH_HR_MIN_SEC;
_ctrl_body = _display displayCtrl IDC_MAIN_WATCH_BODY;

//tgt loc button
_ctrl_tgt_loc = _display displayCtrl IDC_MAIN_TGT_LOC_BUTTON;

while {!isNull (findDisplay IDD_MAGIC_BOMB_TOOL)} do
{
	//get names of firing unit and observer markers from drop down menu
	_fire_unit_name = missionNamespace getVariable ["MEF_MAGIC_FIRING_UNIT", ""];
	_obs_name = missionNamespace getVariable ["MEF_MAGIC_OBSERVER", ""];

	//get locations
	_fire_loc = getMarkerpos _fire_unit_name;
	_obs_loc = getMarkerpos _obs_name;

	//get saved impact point
	_tgt_loc = missionNamespace getVariable ["MEF_MAGIC_IMPACT_POINT", ZERO_POS_ARRAY];
	
	//calculate tgt location on 2D map
	_screenCoord = _map ctrlMapWorldToScreen _tgt_loc; 
	_x = _screenCoord select 0;
	
	//if tgt and firing unit exist, calculate gun target line data
	if
	(
		str _fire_loc != str ZERO_POS_ARRAY &&
		str _tgt_loc != str ZERO_POS_ARRAY
	)
	then
	{
		//define ctrl
		_tgt_data_ctrl = _display displayCtrl IDC_MAIN_GTL_DATA;
			
		//global variables to draw GTL
		MEF_MAGIC_DRAW_GTL = TRUE;
		MEF_MAGIC_TGT_LOC = _tgt_loc;	//used by draw cmd
		MEF_MAGIC_FIRE_LOC = _fire_loc;  //used by draw cmd
		
		//determine y pos
		_y = (_screenCoord select 1) + .05;
		
		//calculate distance
		_gtl_dis_m = floor (round (_fire_loc distance _tgt_loc));
		_gtl_dis_nm = _gtl_dis_m * M_TO_NM;
		_gtl_dis_nm = [_gtl_dis_nm, 1] call fn_vbs_cutDecimals;
		
		//calculate dir, check for wrap angles
		_gtl_dir_deg_grid = [_fire_loc, _tgt_loc] call fn_vbs_dirTo; //deg grid
		_gtl_dir_deg_mag = floor (round (_gtl_dir_deg_grid + getDeclination));
		
		_gtl_dir_deg = [_gtl_dir_deg_mag] call fn_vbs_wrapAngle ;  //deg mag
		_gtl_dir_mils = floor (round (_gtl_dir_deg_grid * DEG_TO_MILS));
		
		missionNamespace setVariable ["MEF_MAGIC_GEO_GTL", _gtl_dir_deg_grid];  //GTL in deg grid for geometry only
		
		//output text	
		_text1 = format ["GTL: %1 mils grid, %2 m",_gtl_dir_mils, _gtl_dis_m];
		_text2 = format ["     %1 deg mag, %2 NM",_gtl_dir_deg, _gtl_dis_nm];
		_tgt_data_ctrl ctrlSetStructuredText parseText format["<t shadowColor='#ff0000'>%1</t><br /><t shadowColor='#ff0000' >%2</t>",_text1, _text2];
		
		// limit x on left side
		if (_x < safeZoneX) then
		{
			_x = safeZoneX;
		};
		
		//limit x on right side
		if (_x > (.817-.01+safeZoneX-.28)) then  //this is the size of the map - the size of the gtl text ctrl
		{
			_x = .817-.01+safeZoneX-.28;
		};

		// limit y on top side
		if (_y < (0+.05)) then  //this is the height of the map - height of the ctrl
		{
			_y = (0+.05);
		};

		//limit y on bottom side
		if (_y > (1-0.035*2)) then  //this is the size of the map - height of the gtl text ctrl
		{
			_y = (1-0.035*2);
		};		

		//position text around tgt
		_tgt_data_ctrl ctrlSetPosition [_x,_y,0.27,0.035*2];
		_tgt_data_ctrl ctrlCommit 0;
	}
	else
	{
		//no Btry or Tgt, hide data
		MEF_MAGIC_DRAW_GTL = FALSE;
	};
	
	//if tgt and observer exist, calulate observer target line
	if
	(
		str _obs_loc != str ZERO_POS_ARRAY &&
		str _tgt_loc != str ZERO_POS_ARRAY
	)
	then
	{
		//define ctrl
		_otl_data_ctrl = _display displayCtrl IDC_MAIN_OTL_DATA;
			
		//global variables to draw OTL
		MEF_MAGIC_DRAW_OTL = TRUE;
		MEF_MAGIC_TGT_LOC = _tgt_loc;	//used by draw cmd
		MEF_MAGIC_OBS_LOC = _obs_loc;
	
		//determine y pos
		_y = (_screenCoord select 1) - 0.035*2 - .04;
		
		//calculate distance
		_otl_dis_m = floor (round (_obs_loc distance _tgt_loc));
		_otl_dis_nm = _otl_dis_m * M_TO_NM;
		_otl_dis_nm = [_otl_dis_nm, 1] call fn_vbs_cutDecimals;
		
		//calculate direction
		_otl_dir_deg_grid = [_obs_loc, _tgt_loc] call fn_vbs_dirTo; //deg grid
		_otl_dir_deg_mag = floor (round (_otl_dir_deg_grid + getDeclination));
		
		//check for wrap angles
		_otl_dir_deg = [_otl_dir_deg_mag] call fn_vbs_wrapAngle ;  //deg mag
		_otl_dir_mils = floor (round (_otl_dir_deg_grid * DEG_TO_MILS));
		
		missionNamespace setVariable ["MEF_MAGIC_GEO_OTL", _otl_dir_deg_grid];  //OTL in deg grid for geometry only
		
		//output text.  examples of working structured text
		//_otl_data_ctrl ctrlSetStructuredText parseText "line 1<br />line 2";
		//_otl_data_ctrl ctrlSetStructuredText parseText "<t shadow='true' shadowColor='#0000ff'>Blue Shadow</t>";
		//_otl_data_ctrl ctrlSetStructuredText parseText "<t color='#ff7f00'>orange</t>";
		//_otl_data_ctrl ctrlSetStructuredText parseText "<t color='#ff7f00' shadowColor='#0000ff'>orange</t>";
		//_otl_data_ctrl ctrlSetStructuredText parseText format["<t shadowColor='#0000ff'>OTL: %1 mils grid, %2 m</t>",_dir_mils, _dis_m];
		
		_text1 = format ["OTL: %1 mils grid, %2 m",_otl_dir_mils, _otl_dis_m];
		_text2 = format ["     %1 deg mag, %2 NM",_otl_dir_deg, _otl_dis_nm];
		_otl_data_ctrl ctrlSetStructuredText parseText format["<t shadowColor='#0000ff'>%1</t><br /><t shadowColor='#0000ff' >%2</t>",_text1, _text2];

		// limit x on left side
		if (_x < safeZoneX) then
		{
			_x = safeZoneX;
		};
		
		//limit x on right side
		if (_x > (.817-.01+safeZoneX-.28)) then  //this is the size of the map - the size of the gtl text ctrl
		{
			_x = .817-.01+safeZoneX-.28;
		};

		// limit y on top side
		if (_y < 0) then  //this is the height of the map - height of the ctrl
		{
			_y = 0;
		};
		
		//limit y on bottom side
		if (_y > (1-.05-0.035*2)) then  //this is the size of the map - height of the gtl text ctrl
		{
			_y = (1-.05-0.035*2);
		};
		
		//position text around tgt
		_otl_data_ctrl ctrlSetPosition [_x,_y,0.27,0.035*2];
		_otl_data_ctrl ctrlCommit 0;
	}
	else
	{
		//no Obs or Tgt, hide data
		MEF_MAGIC_DRAW_OTL = FALSE
	};
	
	//show or hide ctrls
	_otl_data_ctrl ctrlShow MEF_MAGIC_DRAW_OTL;
	_gtl_data_ctrl ctrlShow MEF_MAGIC_DRAW_GTL;
	
	//*********************************************************
	//update watch
	//HH:MM:SS in 24 hr clock time
	
	_date_type = missionNamespace getVariable ["MEF_MAGIC_TOGGLE_DTG", 0];	
	
	[_date_type, _ctrl_day_month_date, _ctrl_hr_min_sec, _ctrl_body] call fn_magic_update_watch;
	
	// update main page moving marker target location
	if (MEF_MAGIC_MAP_BUTTON_DOWN && MEF_MAGIC_ENABLE_MOVING_TGT_LOC) then
	{
		//convert mouse pointer to game coords [x,y,z]
		_game_coords = _map ctrlMapScreenToWorld [MEF_MAGIC_MAP_POS_X, MEF_MAGIC_MAP_POS_Y];
		_game_coords set [2,0];
		
		//calculate full mgrs, save to global variable
		_fullmgrs = _game_coords call fn_magic_posToCoord;
		MEF_MAGIC_MAP_TO_GAME_COORDS = _game_coords;
		
		//convert full mgrs into an array
		_mgrs_array = _fullmgrs call fn_magic_check_mgrs_format;

		//output results and assign to a global variable
		MEF_MAGIC_TGT_ZONE = _mgrs_array select 0;
		MEF_MAGIC_TGT_SQID = _mgrs_array select 1;
		MEF_MAGIC_TGT_NORTH = _mgrs_array select 2;
		MEF_MAGIC_TGT_EAST = _mgrs_array select 3;
		
		_ctrl_tgt_loc ctrlSetText format ["(Moving Marker) %1 %2 %3 %4", MEF_MAGIC_TGT_ZONE, MEF_MAGIC_TGT_SQID, MEF_MAGIC_TGT_NORTH, MEF_MAGIC_TGT_EAST];

	};

	sleep .01;
};
















