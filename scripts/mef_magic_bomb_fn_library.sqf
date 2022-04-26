//function library for script

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//function library
fn_magic_load_page = 
{
	//page to open
	private ["_pages", "_disableGUI", "_display", "_count", "_page", "_condition", "_configs", "_idc"];
	
	//passed array:  [[pages],boolean];
	_pages = _this select 0;
	_disableGUI = _this select 1;
	
	_display = MEF_MAGIC_BOMB_TOOL;
	
	_count = count _pages;
	
	//search controls and show
	for "_i" from 0 to (_count -1) do
	{
		_page = _pages select _i;
	
		//find configs to show
		_condition = format ["%1 in configName _x", str _page];
		_configs = _condition configClasses (configFile >> "MEF_MAGIC_BOMB_TOOL" >> "Controls");
		
		//loop to load page
		{
			_idc = getNumber (configFile>>"MEF_MAGIC_BOMB_TOOL">>"controls">>configName _x>>"idc");
			(_display displayCtrl _idc) ctrlShow TRUE;
		}forEach _configs;
	};
	
	//disable the main GUI
	if (_disableGUI) then
	{
		(_display displayCtrl IDC_MAIN_DISABLE_GUI_BUTTON) ctrlShow TRUE;		
	};
};


fn_magic_hide_page = 
{
	//what page(s) to hide
	private ["_pages", "_enableGUI", "_display", "_count", "_page", "_condition", "_configs", "_idc"];
	
	//passed array:  [[pages], boolean]
	
	_pages = _this select 0;
	_enableGUI = _this select 1;
	
	_display = MEF_MAGIC_BOMB_TOOL;
	
	_count = count _pages;
	
	for "_i" from 0 to (_count -1) do
	{
		_page = _pages select _i;
		
		//find configs to hide
		_condition = format ["%1 in configName _x", str _page];
		_configs = _condition configClasses (configFile >> "MEF_MAGIC_BOMB_TOOL" >> "Controls");
		
		//loop to hide page
		{
			_idc = getNumber (configFile>>"MEF_MAGIC_BOMB_TOOL">>"controls">>configName _x>>"idc");
			(_display displayCtrl _idc) ctrlShow FALSE;
		}forEach _configs;
		
		//destroy page variable
		call compile format ["MEF_%1 = nil", _page]
	};
	
	//enable the main GUI
	if (_enableGUI) then
	{
		(_display displayCtrl IDC_MAIN_DISABLE_GUI_BUTTON) ctrlShow FALSE;		
	};
};


fn_magic_posToCoord = 
{
	//convert a game grid into zone + square ID and MGRS north + east
	private ["_mapCenter", "_output", "_tgt_mgrs", "_strlen_tgt_mgrs", "_zone_sqID", "_mgrs", "_fullmgrs"];
	
	//passed array: [x,y,z] game position
	_mapCenter = _this;
	
	//convert to 10 digit mgrs grid
	_output = posToCoord [_mapCenter, "MGRS",10];
	_tgt_mgrs = _output select 0; 
	_strlen_tgt_mgrs = strLen _tgt_mgrs;

	//return main parts
	_zone_sqID = trim[_tgt_mgrs,0,10];
	_mgrs = trim[_tgt_mgrs, _strlen_tgt_mgrs-10, 0];
	
	_fullmgrs = [_zone_sqID, _mgrs];

	_fullmgrs
};

fn_magic_change_dir =
{
	//highlight the correct control when user clicks mils grid or deg mag button
	//does not save value!
	private["_idcMils", "_idcDegs", "_globalVar", "_display", "_dir_units_cur"];
		
	//get passed data: [idc #, idc #, "MEF_MAGIC_OT_UNITS_PRE"]
	_idcMils = _this select 0;
	_idcDegs = _this select 1;
	_globalVar = _this select 2;
	
	_display = MEF_MAGIC_BOMB_TOOL;

	//what direction was saved
	_dir_units_cur = missionNamespace getVariable [_globalVar, 0];

	//color the correct bubble
	switch (_dir_units_cur) do
	{
		case 0:	//mils
		{
			(_display displayCtrl _idcMils) ctrlSetTextColor [0,128/255,255/255,1];  //light blue
			(_display displayCtrl _idcDegs) ctrlSetTextColor [1,1,1,1];	//white
		};
		case 1:	//deg
		{
			(_display displayCtrl _idcDegs) ctrlSetTextColor [0,128/255,255/255,1];  //light blue
			(_display displayCtrl _idcMils) ctrlSetTextColor [1,1,1,1];	//white
		};
	};
};


fn_magic_check_numbers =
{
	//passed array:  [_ctrl, _char_id, _idc]
	_display = MEF_MAGIC_BOMB_TOOL;
	
	_ctrl= _this select 0;
	_char_id = _this select 1;
	_idc = _this select 2;
	
	//only allow _char_codes between 48 and 57 
	_char_codes = [48,49,50,51,52,53,54,55,56,57];

	if (!(_char_id in _char_codes)) then
	{
		_text = ctrlText _idc;
		_text = trim [_text, 0, 1];
		_ctrl ctrlSetText  _text;	
	};
};


fn_magic_check_dir =
{
	//passed array [_rect_att_ctrl, "PG_07", "MEF_MAGIC_RECT_ATT_UNITS_CUR"]
	_ctrl= _this select 0;
	_page = _this select 1;
	_units = _this select 2;
	
	_test = parseNumber (ctrlText _ctrl);
	_dir_units = missionNamespace getVariable [_units, 0];

	_ctrl ctrlSetTextColor [1,1,1,1];	 //white

	switch (_dir_units) do
	{
		case 0:	//mils
		{
			if(_test > 6400 || _test < 0) then
			{
				_ctrl ctrlSetTextColor [1,0,0,1];	 //red
				call compile format ["missionNamespace setVariable ['MEF_%1_OK', FALSE]",_page];
			};
		};
		case 1:	//degrees
		{
			if(_test > 360 || _test < 0) then
			{
				_ctrl ctrlSetTextColor [1,0,0,1];	 //red
				call compile format ["missionNamespace setVariable ['MEF_%1_OK', FALSE]",_page];
			};	
		};
	};
};


fn_magic_display_OT_dir =
{
	//show observer to target direction on main screen
	private ["_dir_units", "_tgt_dir", "_dir_tx", "_output", "_OT_dir_ctrl"];
	
	//passed array [_dir_units, _tgt_dir]
	_dir_units = _this select 0;
	_tgt_dir = _this select 1;
	
	//set units for direction (mils grid or degs mag)
	_dir_tx = "mils grid";
	
	if (_dir_units==1) then
	{
		_dir_tx = "degs mag";
	};

	//output data
	_output = format ["%1 %2", _tgt_dir, _dir_tx];
	
	_OT_dir_ctrl = _display displayCtrl IDC_MAIN_OBS_DIR_BUTTON;		
	_OT_dir_ctrl ctrlSetText _output;
};


fn_magic_find_obs_markers =
{
	//find list of observers based on search parameters
	private ["_observer_list", "_allMarkers", "_marker"];
	
	//init variables
	_observer_list = [];

	//find markers
	_allMarkers = markers;

	//check for observers markers, any description (F6 Marker > "ObservationOutpost")
	{
		_marker = _x;
		
		if ((getMarkerType _marker) == "ObservationOutpost") then
		{
			//OP marker found, add to the list
			_observer_list = _observer_list + [_x];
			
			missionNamespace setVariable ["MEF_MAGIC_OBS_LIST", _observer_list];
			
			//remove from list to avoid doubles
			_allMarkers = _allMarkers-[_x];
		};
	} forEach _allMarkers;

	//check for marker description for:  OP, JTAC, FO, JFO
	{
		_marker = _x;
		if
		(
			"op" in markerText _marker ||
			"jtac" in markerText _marker ||
			"jfo" in markerText _marker ||
			"fo" in markerText _marker ||
			"OP" in markerText _marker ||	
			"JTAC" in markerText _marker ||
			"JFO" in markerText _marker ||
			"FO" in markerText _marker		
		)
		then
		{
			//marker found, add to list
			_observer_list = _observer_list + [_x];
			missionNamespace setVariable ["MEF_MAGIC_OBS_LIST", _observer_list];
		};
	} forEach _allMarkers;
	
	_observer_list
};


fn_magic_find_fire_unit_markers =
{
	//find list of firing units based on search parameters
	private ["_firingUnit_list", "_allMarkers", "_marker"];
	
	//init variables
	_firingUnit_list = [];
	
	//find markers
	_allMarkers = markers;
	
	//acceptable marker descriptions:  btry, mtr, 81s, 60s, ddg, cg
	{
		_marker = _x;
		if
		(
			"btry" in markerText _marker ||
			"mtr" in markerText _marker ||
			"81" in markerText _marker ||
			"60" in markerText _marker ||	
			"BTRY" in markerText _marker ||
			"MTR" in markerText _marker ||
			"ddg" in markerText _marker ||
			"DDG" in markerText _marker ||
			"cg" in markerText _marker ||
			"CG" in markerText _marker
		)
		then
		{
			//_firingUnit_list = _firingUnit_list + [markerText _x];
			_firingUnit_list = _firingUnit_list + [_x];
			missionNamespace setVariable ["MEF_MAGIC_FIRE_LIST", _firingUnit_list];
		};
	} forEach _allMarkers;
	
	_firingUnit_list
};

fn_magic_find_target_markers =
{
	//find list of preplanned targets based on search parameters
	private ["_savedTgt_list", "_allMarkers", "_marker"];
	
	//init variables
	_savedTgt_list = [];
	
	//find markers
	_allMarkers = markers;
	
	{
		_marker = _x;
		
		if ((getMarkerType _marker) == "TargetSingle") then
		{
			//target marker found, add to the list and remove from all markers to prevent duplicates
			_savedTgt_list = _savedTgt_list + [_x];
			missionNamespace setVariable ["MEF_MAGIC_TARGET_LIST", _savedTgt_list];  //unsorted tgt list
			_allMarkers = _allMarkers-[_x];
		};
	} forEach _allMarkers;

	//acceptable marker descriptions: knpt, tgt
	{
		_marker = _x;
		if
		(
			"knpt" in markerText _marker ||
			"tgt" in markerText _marker ||
			"KNPT" in markerText _marker ||
			"TGT" in markerText _marker	
		)
		then
		{
			_savedTgt_list = _savedTgt_list + [_x];
			missionNamespace setVariable ["MEF_MAGIC_TARGET_LIST", _savedTgt_list];  //unsorted tgt list
		};
	} forEach _allMarkers;

	_savedTgt_list
};


fn_magic_check_mgrs_format = 
{
	//convert an zone + square ID and mgrs north + east into individual parts
	private ["_zone_sqID", "_mgrs", "_zone", "_sqID", "_north", "_east", "_mgrs_array", "_strLn_zone_sqID", "_strLn_mgrs"];
	
	//passed array: [_zone_sqID, _mgrs]
	_zone_sqID = _this select 0;
	_mgrs = _this select 1;

	//init variables to create mgrs array
	_zone = "";
	_sqID = "";
	_north = "";
	_east = "";
	_mgrs_array = [];
	
	//calculate string length of each element
	_strLn_zone_sqID = strLen _zone_sqID;
	_strLn_mgrs = strLen _mgrs;
	
	//check if grid zone and square ID are 4 digits i.e. 9SMS
	if ((_strLn_zone_sqID%2)== 0) then
	{
		_zone = trim [_zone_sqID, 0, _strLn_zone_sqID/2];
		_sqID = trim [_zone_sqID, _strLn_zone_sqID/2, 0];
	}
	else
	{
		//grid zone and square ID are 5 digits i.e. 11SMS
		_zone = trim [_zone_sqID, 0, floor(_strLn_zone_sqID/2)];
		_sqID = trim [_zone_sqID, ceil(_strLn_zone_sqID/2), 0];
	};
	
	//check if mgrs is even (6,8,10 digit grid)
	if ((_strLn_mgrs%2)== 0) then
	{
		_north = trim [_mgrs, 0, _strLn_mgrs/2];
		_east = trim [_mgrs, _strLn_mgrs/2, 0];
	}
	else
	{
		//mgrs is odd due to space in middle i.e. 12345 67890
		_north = trim [_mgrs, 0, ceil (_strLn_mgrs/2)];
		_east = trim [_mgrs, ceil (_strLn_mgrs/2), 0];
	};

	_mgrs_array = [_zone, _sqID, _north, _east];
	
	_mgrs_array
};


fn_magic_check_mgrs_coords =
{
	//check if mgrs coordinate are valid (plots on current map)
	private ["_mgrs_array", "_tgt_sqid_ctrl", "_tgt_mgrs_ctrl", "_page", "_zone", "_sqID", "_north", "_east", "_game_coord", "_fullMgrs", "_coord", "_test_x", "_test_y", "_mapSize"];
	
	//passed array: [_mgrs_array, _tgt_sqid_ctrl, _tgt_mgrs_ctrl, "PG_02"]
	
	_mgrs_array = _this select 0;
	_tgt_sqid_ctrl = _this select 1;
	_tgt_mgrs_ctrl = _this select 2;
	_page = _this select 3;
	
	_zone = _mgrs_array select 0;
	_sqID = _mgrs_array select 1; 
	_north = _mgrs_array select 2; 
	_east = _mgrs_array select 3; 

	//init variables
	_game_coord = [];
	
	//calculate coordinate
	_fullMgrs = format ["%1%2%3%4",_zone, _sqID, _north, _east];
	_coord = coordToPos [[_fullMgrs,""],"MGRS"]; //returns <null> if bad grid
	
	//check if coordinates are good
	if (!isNil "_coord") then 
	{
		//check if coords are positive	
		_test_x = _coord select 0;
		_test_y = _coord select 1;
	
		//check if coords are within map bounds
		_mapSize = (mapProperties select 3)*(mapProperties select 5);
		if
		(
			(_test_x < _mapSize && _test_x > 0) &&
			(_test_y < _mapSize && _test_y > 0) 
		)
		then
		{
			//coord is positive and within map bound
			_tgt_sqid_ctrl ctrlSetTextColor [1,1,1,1]; //white
			_tgt_mgrs_ctrl ctrlSetTextColor [1,1,1,1]; //white

			_game_coord = _coord;
		}
		else
		{
			_tgt_sqid_ctrl ctrlSetTextColor [1,0,0,1]; //red
			_tgt_mgrs_ctrl ctrlSetTextColor [1,0,0,1]; //red

			call compile format ["missionNamespace setVariable ['MEF_%1_OK', FALSE]",_page];
		};
	}
	else
	{
		//bad grid coordinate
		_tgt_sqid_ctrl ctrlSetTextColor [1,0,0,1]; //red
		_tgt_mgrs_ctrl ctrlSetTextColor [1,0,0,1]; //red

		call compile format ["missionNamespace setVariable ['MEF_%1_OK', FALSE]",_page];
	};	
	
	_game_coord
};


fn_magic_find_shell_data = 
{
	//find shell data from drop down menu
	private ["_idx_shell_type", "_shell_ECR", "_fuseType", "_fuseParam", "_shell_class", "_shell_type", "_shell_data"];
	
	//passed array: _idx_shell_type
	_idx_shell_type = _this;

	//default gun data
	_shell_ECR = 50;
	_fuseType = "quick";  //"proximity", "nearsurface", "timed", "quick"??
	_fuseParam = 3;		//default height of burst in m, does not make a difference.
	_shell_class = "vbs2_ammo_sh_155_he";
	_shell_type = "arty_155";
	
	//return gun data
	switch(_idx_shell_type) do
	{
		case 0:
		{
			//60mm
			_shell_ECR = MEF_MAGIC_60MM_HE_ECR;
			_shell_class = "vbs2_ammo_sh_60m_he";
			_shell_type = "mortar_60";			
		};
		case 1:
		{
			//81mm 
			_shell_ECR = MEF_MAGIC_81MM_HE_ECR;
			_shell_class = "vbs2_ammo_sh_80m_he";
			_shell_type = "mortar_81";			
		};
		case 2:
		{
			//105mm
			_shell_ECR = MEF_MAGIC_105MM_HE_ECR;
			//_shell_class = "arty_105_he";
			_shell_class = "vbs2_ammo_sh_105_he";
			_shell_type = "arty_105";
		};
		case 3:
		{
			//120mm
			_shell_ECR = MEF_MAGIC_120MM_HE_ECR;
			_shell_class = "vbs2_ammo_sh_120m_he";
			_shell_type = "mortar_120";
		};
		case 4:
		{
			//5 inch 54, NGF
			_shell_ECR = MEF_MAGIC_5INCH54_HE_ECR;
			_shell_class = "vbs2_ammo_sh_120m_he";
			_shell_type = "mortar_120";
		};
		case 5:  
		{	
			//155mm he
			_shell_ECR = MEF_MAGIC_155MM_HE_ECR;
			_shell_class = "vbs2_ammo_sh_155_he";
			_shell_type = "arty_155";			
		};
		case 6:
		{
			//155mm dpicm
			_shell_ECR = MEF_MAGIC_155MM_DPICM_ECR;
			_shell_class = "arty_105_dpicm";
			_shell_type = "arty_105_dpicm";		
		};
		case 7:
		{
			//illum on deck
			_shell_ECR = MEF_MAGIC_155MM_HE_ECR;
			_shell_class = "vbs2_ammo_sh_155m_illum";
			_shell_type = "arty_155";	
			_fuseType = "proximity";
			_fuseParam = 42.651;  //not sure if this property makes a difference			
		};
		case 8:
		{
			//illum
			_shell_ECR = MEF_MAGIC_155MM_HE_ECR;
			_shell_class = "vbs2_ammo_sh_155m_illum";
			_shell_type = "arty_155";	
			_fuseType = "highaltburst";
			_fuseParam = 42.651;		//not sure if this property makes a difference		
		};
		case 9:
		{
			//smoke
			_shell_ECR = MEF_MAGIC_155MM_HE_ECR;
			_shell_class = "vbs2_ammo_sh_155m_smoke";
			_shell_type = "arty_155";	
		};
		case 10:
		{
			//WP airburst
			_shell_ECR = MEF_MAGIC_155MM_HE_ECR;
			_shell_class = "vbs2_ammo_sh_155m_wp_Air";
			_shell_type = "arty_155";	
			_fuseType = "proximity";
			_fuseParam = 42.651;		//600m, not sure if this property makes a difference	
		};
	};	
	
	_shell_data = [_shell_class, _shell_ECR, _shell_type, _fuseType, _fuseParam];
	
	_shell_data
};


fn_magic_find_marker_info =
{
	//find the marker name and description
	private ["_marker_lbText", "_name_array_str", "_desc_array", "_name_array", "_marker_desc", "_idx_array", "_marker_name", "_marker_pos", "_marker_info"];
	
	//passed array [_saved_tx, "MEF_MAGIC_TARGET_LIST"]
	 _marker_lbText = _this select 0;
	 _name_array_str = _this select 1;
	 
	 //init variables
	 _desc_array = [];	 
	 _name_array = missionNamespace getVariable [_name_array_str,[]];  //array of marker names

	//convert the array into marker descriptions	
	{
		_marker_desc = markerText _x;
		_desc_array = _desc_array + [_marker_desc];
	} forEach _name_array;	

	//find the marker name
	_idx_array = _desc_array find _marker_lbText;
	_marker_name = _name_array select _idx_array;	

	//this is the start location for the shift mission
	_marker_pos = getMarkerPos _marker_name;
	_marker_info = [_marker_name,_marker_pos];
	
	_marker_info
};

fn_magic_find_circular_aimpoints =
{
	//calculate circular aimpoints
	private ["_tgt_loc", "_guns", "_radius", "_shell_ecr", "_aimPoint_array", "_rnd_spacing", "_error", "_aimPoint"];
	
	//passed array: [_tgt_loc, _radius, _guns]
	
	_tgt_loc = _this select 0;
	_guns = _this select 1;
	_radius = _this select 2;
	_shell_ecr = _this select 3;

	//init variables
	_aimPoint_array = [];
	
	//calculate number of degrees between impacts
	_rnd_spacing = 360/(_guns);
	
	for "_i" from 1 to _guns do
	{
		//_error = 5 - random 10;  //-5 to 5 meter error
		_error = 0;
	
		//calculate positions
		_aimPoint = [_tgt_loc, (_radius + _error), _rnd_spacing*_i] call fn_vbs_relPos;
		_aimPoint_array = _aimPoint_array + [_aimPoint];
		
		//adjust size and position of each aimpoint
		call compile format["ECR_%1 setMarkerPosLocal %2", _i, _aimPoint];
		call compile format["ECR_%1 setMarkerSizeLocal [%2,%2]", _i, _shell_ecr];
	};
	
	_aimPoint_array
};

fn_magic_find_rectangular_aimpoints =
{
	//calculate rectangular aimpoints
	private ["_tgt_loc", "_guns", "_rect_len", "_rect_wid", "_rect_att", "_shell_ecr", "_start_pos",  "_aimPoint", "_aimPoint_array", "_x_dis", "_y_dis", "_h_dis", "_theta_0", "_start_pos", "_theta_2"];
	
	//passed array: [_tgt_loc, _guns, _rect_len, _rect_wid, _rect_att]
	_tgt_loc = _this select 0;	//game coord
	_guns = _this select 1;  //number from 1 to 8
	_rect_len = _this select 2;		//number in meters
	_rect_wid = _this select 3;		//number in meters
	_rect_att = _this select 4;		//direction in degrees grid
	_shell_ecr = _this select 5;	
	
	//init variables
	_start_pos = [];
	_aimPoint = [];
	_aimPoint_array = [];
	
	//calculate aimpoints
	for "_i" from 1 to _guns do
	{
		//calculate start position
		if (_i == 1) then
		{
			_x_dis = (_rect_len/2) - (_rect_len/(_guns+1));
			_y_dis = _rect_wid/4;
			_h_dis = (_x_dis^2+_y_dis^2)^(1/2);
			_theta_0 = asin (_y_dis/_h_dis);
			_start_pos = [_tgt_loc, _h_dis, (_rect_att+180+_theta_0)] call fn_vbs_relPos;
			_aimPoint_array = _aimPoint_array + [_start_pos];

			//set marker pos to the start point
			call compile format["ECR_%1 setMarkerPosLocal %2", _i, _start_pos];
		};
	
		//if _i > 0 and even
		if 	((_i > 1) && ((_i%2) == 0)) then
		{
			_x_dis = _rect_len/(_guns+1)*(_i-1);
			_y_dis = _rect_wid/2;
			_h_dis = (_x_dis^2+_y_dis^2)^(1/2);
			_theta_2 = asin (_x_dis/_h_dis);
			_aimPoint = [_start_pos, _h_dis, (_rect_att + 90 - _theta_2)] call fn_vbs_relPos;
			_aimPoint_array = _aimPoint_array + [_aimPoint];

			//set marker pos from start point
			call compile format["ECR_%1 setMarkerPosLocal %2", _i, _aimPoint];
		};
		
		//if _i > 0 and odd
		if 	((_i > 1) && ((_i%2) != 0)) then
		{
			_x_dis = _rect_len/(_guns+1)*(_i-1);
			_aimPoint = [_start_pos, _x_dis, _rect_att] call fn_vbs_relPos;
			_aimPoint_array = _aimPoint_array + [_aimPoint];

			//set marker pos from start point
			call compile format["ECR_%1 setMarkerPosLocal %2", _i, _aimPoint];
		};
		
		//adjust size of each ECR
		call compile format["ECR_%1 setMarkerSizeLocal [%2,%2]", _i, _shell_ecr];
	};
	
	_aimPoint_array
};


fn_magic_find_aimPoints =
{
	//main function that determines sheaf then calculates aimpoint
	private = ["_tgt_loc", "_aimPoint_array", "_guns", "_shell_data", "_sheaf"];
	
	//init variables
	_tgt_loc = missionNamespace getVariable ["MEF_MAGIC_IMPACT_POINT", []];
	_aimPoint_array = [];

	//continue if impact point saved ([x,y] or [x,y,z])
	if (count _tgt_loc >= 2) then	
	{
		//find number of guns, shell and selected sheaf
		_guns = (missionNamespace getVariable ["MEF_MAGIC_NUM_GUNS", MEF_MAGIC_DEFAULT_GUNS]) + 1; //convert to 1-6 guns
		_shell_data = missionNamespace getVariable ["MEF_MAGIC_SHELL_DATA", ["arty_155_he", 50]];  // returns [_shell, _shell_ECR]
		_sheaf = missionNamespace getVariable ["MEF_MAGIC_SHEAF", MEF_MAGIC_DEFAULT_SHEAF];  //returns a number

		//create markers to show aimpoints on 2D map
		_guns call fn_magic_create_ecr;
		
		if (_guns == 1) then
		{
			//only 1 gun found, force converged sheaf
			_sheaf = 1;
		};
		
		switch(_sheaf) do
		{
			case 0:  
			{
				//circle
				private ["_radius_str", "_radius", "_shell_ecr"];
				
				_radius_str = missionNamespace getVariable ["MEF_MAGIC_RADIUS", "100"];	
				_radius = parseNumber _radius_str;
				_shell_ecr = _shell_data select 1;
				
				_aimPoint_array = [_tgt_loc, _guns, _radius, _shell_ecr] call fn_magic_find_circular_aimpoints;
			};
			case 1:  
			{
				//converged 
				private ["_radius", "_shell_ecr"];
				_radius = 0;

				_shell_ecr = _shell_data select 1;
				
				if (_guns > 2) then
				{
					_radius = 5;  //increase impact radius		
				};
						
				_aimPoint_array = [_tgt_loc, _guns, _radius, _shell_ecr] call fn_magic_find_circular_aimpoints;
			};
			case 2:  
			{
				//line
				private ["_rect_len_tx", "_rect_att_tx", "_dir_units", "_rect_att", "_shell_ecr", "_rect_len", "_rect_wid"];
				
				_rect_len_tx = missionNamespace getVariable ["MEF_MAGIC_LINE_LEN", "300"];
				_rect_att_tx = missionNamespace getVariable ["MEF_MAGIC_LINE_ATT", "6400"];
				_dir_units = missionNamespace getVariable ["MEF_MAGIC_LINE_ATT_UNITS_CUR", 0];  //0=mils 1=degrees
				
				_rect_att = parseNumber _rect_att_tx;
				_shell_ecr = _shell_data select 1;
					
				//dir is in mils, convert to degrees
				if (_dir_units == 0) then //0=mils 1=degrees
				{
					_rect_att = (parseNumber _rect_att_tx) / DEG_TO_MILS;  //degrees grid
				};			

				//dir is in degrees mag, convert to degrees grid
				if (_dir_units == 1) then
				{
					_rect_att = (parseNumber _rect_att_tx) - getDeclination;	//degrees grid
				};		
				
				_rect_len = parseNumber _rect_len_tx;
				_rect_wid = 0;
				
				_aimPoint_array = [_tgt_loc, _guns, _rect_len, _rect_wid, _rect_att, _shell_ecr] call fn_magic_find_rectangular_aimpoints;
			};
			case 3:  
			{
				//open
				private ["_shell_ecr", "_rect_len", "_rect_wid", "_obs_name", "_obs_loc", "_tgt_loc", "_rect_att"];
				
				_shell_ecr = _shell_data select 1;  //shell type ecr in meters
				
				_rect_len = (_shell_data select 1) * _guns;
				_rect_wid = 0;
				
				_obs_name = missionNamespace getVariable ["MEF_MAGIC_OBSERVER", ""];

				//_fire_loc = getMarkerpos _fire_unit_name;
				_obs_loc = getMarkerpos _obs_name;
				_tgt_loc = missionNamespace getVariable ["MEF_MAGIC_IMPACT_POINT", ZERO_POS_ARRAY];  //init impact point
	
				_rect_att = 45;	//default GTL
				
				//calculate observer target line data if locations are good
				if
				(
					str _obs_loc != str ZERO_POS_ARRAY &&
					str _tgt_loc != str ZERO_POS_ARRAY
				)
				then
				{
					//calculate dir
					_rect_att = [_obs_loc, _tgt_loc] call fn_vbs_dirTo; //deg grid
					_rect_att = _rect_att + 90;
					missionNamespace setVariable ["MEF_MAGIC_GEO_OTL", _rect_att];  //GTL in deg grid for geometry only
				};

				_aimPoint_array = [_tgt_loc, _guns, _rect_len, _rect_wid, _rect_att, _shell_ecr] call fn_magic_find_rectangular_aimpoints;
			};
			case 4:  
			{
				//parallel
				private ["_shell_ecr", "_rect_att", "_rect_len", "_rect_wid","_fire_unit_name", "_fire_loc"];
				
				_shell_ecr = _shell_data select 1;
				_rect_att = 45;	//default GTL
				
				//calculate length and width
				_rect_len = _shell_ecr * _guns;
				_rect_wid = _shell_ecr;
				
				//calculate attitude based on gun target line, default 45 degrees grid
				//get names of selected markers
				_fire_unit_name = missionNamespace getVariable ["MEF_MAGIC_FIRING_UNIT", ""];
				_fire_loc = getMarkerpos _fire_unit_name;

				_tgt_loc = missionNamespace getVariable ["MEF_MAGIC_IMPACT_POINT", ZERO_POS_ARRAY];  //init impact point

				//calculate gun target line data if locations are good
				if
				(
					str _fire_loc != str ZERO_POS_ARRAY &&
					str _tgt_loc != str ZERO_POS_ARRAY
				)
				then
				{
					//calculate dir
					_rect_att = [_fire_loc, _tgt_loc] call fn_vbs_dirTo; //deg grid
					_rect_att = _rect_att + 90;
					missionNamespace setVariable ["MEF_MAGIC_GEO_GTL", _rect_att];  //GTL in deg grid for geometry only
				};
				
				_aimPoint_array = [_tgt_loc, _guns, _rect_len, _rect_wid, _rect_att, _shell_ecr] call fn_magic_find_rectangular_aimpoints;
			};					
			case 5:  
			{
				//rectangle
				private ["_rect_len_tx", "_rect_wid_tx", "_rect_att_tx", "_dir_units","_shell_ecr", "_rect_att", "_rect_len", "_rect_wid"];
								
				_rect_len_tx = missionNamespace getVariable ["MEF_MAGIC_RECT_LEN", "300"];
				_rect_wid_tx = missionNamespace getVariable ["MEF_MAGIC_RECT_WID", "100"];
				_rect_att_tx = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT", "6400"];
				_dir_units = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT_UNITS_CUR", 0];  //0=mils 1=degrees
				_shell_ecr = _shell_data select 1;
				
				_rect_att = parseNumber _rect_att_tx;
				
				//dir is in mils, convert to degrees
				if (_dir_units == 0) then //0=mils 1=degrees
				{
					_rect_att = (parseNumber _rect_att_tx) / DEG_TO_MILS;  //degrees grid
				};			

				//dir is in degrees mag, convert to degrees grid
				if (_dir_units == 1) then
				{
					_rect_att = (parseNumber _rect_att_tx) - getDeclination;	//degrees grid
				};		

				_rect_len = parseNumber _rect_len_tx;
				_rect_wid = parseNumber _rect_wid_tx;
				
				_aimPoint_array = [_tgt_loc, _guns, _rect_len, _rect_wid, _rect_att, _shell_ecr] call fn_magic_find_rectangular_aimpoints;
			};		
		};
	};
	
	_aimPoint_array
};

fn_magic_create_ecr =
{
	//create a circular marker based on number of guns
	private ["_guns", "_markerName", "_markerPos"];
	
	//passed data _guns
	_guns = _this;
	
	//create ECR aimpoints
	for "_i" from 1 to 8 do
	{
		_markerName = format["ECR_%1", _i];
		_markerPos = getMarkerPos _markerName;
		
		//create ECR marker if it does not exist
		if (str _markerPos == str ZERO_POS_ARRAY) then
		{
			call compile format
			["
				ECR_%1 = createMarkerLocal['ECR_%1', getpos player];
				ECR_%1 setMarkerShapeLocal 'ELLIPSE';

				ECR_%1 setMarkerAlpha 0.8; 
				ECR_%1 setMarkerSizeLocal [5,5]; 
			", _i];
		};

		//change marker color to black		
		if (_i <= _guns) then
		{
			call compile format ["ECR_%1 setmarkerColorLocal 'ColorBlack'",_i];
		};
		
		//delete extra ECR markers
		if (_i > _guns) then
		{
			call compile format ["deleteMarkerLocal ECR_%1", _i];
		};
	};
};

fn_magic_color_ECR =
{
	//change color of ECR based on when round will impact
	private ["_guns_idx", "_startTime", "_delay"];
	
	//passed array [_guns_idx, _startTime, _delay] 
	_guns_idx = _this select 0;	//number of guns 0-7
	_startTime = _this select 1;	//time in seconds when script was executed
	_delay = _this select 2;		//time in seconds when bomb will impact
	
	//set default color
	_color = "ColorBlack";
	
	if (time > (_startTime+_delay)) then //past impact time
	{
		_color = "ColorBlack"; 
	}
	elseif (time > (_startTime+_delay-4)) then // 5 seconds prior, color ECR red
	{
		_color = "ColorRedAlpha";
	}
	elseif (time > (_startTime+_delay-9)) then  // 10 seconds prior, color ECR yellow
	{
		_color = "ColorYellow";
	}
	else
	{
		_color = "ColorGreenAlpha"; //> 10 seconds, color ECR green
	};
	
	//change color for all markers
	for "_i" from 1 to (_guns_idx+1) do
	{
		call compile format ["ECR_%1 setmarkerColorLocal '%2'",_i, _color];
	};
};


fn_magic_create_single_target = 
{
	//when a new mission is created, add a single target marker
	private ["_tgt_number", "_tgt_loc", "_tgt_number_str", "_output"];

	//passed array: [_next_tgt_num, _tgt_loc]
	
	_tgt_number = _this select 0;
	_tgt_loc = _this select 1;
	
	_tgt_number_str = [_tgt_number] call fn_magic_generate_tgt_num;
	
	_output = format ["TGT_%1", _tgt_number_str];
	
	call compile format
	["
		TGT_%1 = createMarkerLocal['TGT_%1', _tgt_loc];
		TGT_%1 setMarkerShapeLocal 'ICON';
		TGT_%1 setMarkerTypeLocal 'TargetSingle'; 
		TGT_%1 setMarkerTextLocal %2;
		TGT_%1 setMarkerAutoSizeLocal TRUE;
	", _tgt_number_str, _output];
};

fn_magic_generate_tgt_num =
{
	//passed array [_tgt_number];
	private ["_tgt_number", "_tgt_number_str", "_i", "_strLn"];
		
	_tgt_number = _this select 0;  //number between 1 and 9999
	_tgt_number_str = str _tgt_number;
	
	//convert to 4 digit string
	for "_i" from 0 to 3 do
	{
		_strLn = strLen _tgt_number_str;
		if (_strLn == 4) exitWith {};
		
		_tgt_number_str = format ["0%1", _tgt_number_str];
	};
	
	_tgt_number_str
};

fn_magic_update_map = 
{
	//updates unit icons and graphics drawn on map
	private ["_map", "_display", "_allUnits", "_color", "_icon", "_pos", "_dir", "_side"];
	
	//init variables
	_map = _this;
	
	_display = MEF_MAGIC_BOMB_TOOL;
	
	//find all units, vehicles, and static building icons
	_buildings = allStaticVehicles "_x isKindOf 'vbs2_house'";
	_allUnits = allUnits + allVehicles + _buildings;
	_color = MEF_MAGIC_LIGHT_BLUE;
	
	{
		//unit variables
		_icon = getText(configFile >> "cfgVehicles" >> (typeof vehicle _x) >> "icon");
		_pos = getPos vehicle _x;
		_dir = getDir vehicle _x;	
		_side = getNumber(configFile >> "CfgVehicles" >> (typeof vehicle _x) >> "side");

		if (!alive _x) then
		{
			//change color to gray for dead units
			_side = 8;
		};
		
		_sizeX = 20;
		_sizeY = 20;
		
		//set icon color
		switch (_side) do
		{
			case 0:	//EAST
			{
				_color = MEF_MAGIC_LIGHT_RED; 
			};
			case 1:	//WEST
			{
				_color = MEF_MAGIC_LIGHT_BLUE;
			};
			case 2:	//RESISTANCE
			{
				_color = MEF_MAGIC_LIGHT_YELLOW;
			};
			case 3:	//CIV
			{
				//adjust color for civilian units and buildings
				
				if (_x isKindOf "vbs2_house") then
				{
					_color = MEF_MAGIC_LIGHT_GREY; //light grey
				} 
				else
				{
					_color = MEF_MAGIC_LIGHT_GREEN; //light green
				};
			};	
			case 7:  //game logic
			{
				_color = MEF_MAGIC_LIGHT_GREEN; 
				//_color = [0.60000002,1,0.60000002,1]; //light green
				_sizeX = 10;
				_sizeY = 10;
			};
			case 8:  //unit dead
			{
				//_color = [0.60000002,0.60000002,0.60000002,1]; //light grey
				_color = MEF_MAGIC_LIGHT_GREY;
			};
		};

		//draw icons
		_map drawIcon [_icon,_color,_pos,_sizeX,_sizeY,_dir,""];
		
	} forEach _allUnits;
	
	//show GTL or OTL data
	//using global variables from mef_magic_bomb_update_map_data.sqf
	if (MEF_MAGIC_DRAW_GTL) then
	{
		_map drawLine [MEF_MAGIC_FIRE_LOC, MEF_MAGIC_TGT_LOC, [1,0,0,1]];
	};
	
	if (MEF_MAGIC_DRAW_OTL) then
	{
		_map drawLine [MEF_MAGIC_OBS_LOC, MEF_MAGIC_TGT_LOC, [0,0,1,1]];
	};

};

fn_magic_check_TOT =
{
	//TOT
	private ["_hr_tx", "_min_tx","_sec_tx", "_hr", "_min", "_sec", "_timeArray", "_kindOfTime", "_HH", "_MM", "_SS", "_hr_cur", "_min_cur", "_sec_cur", "_tot_in_seconds", "_tot_array"];
	
	//find saved values for time on target,
	_hr_tx = missionNamespace getVariable ["MEF_MAGIC_CONTROL_HR", "-1"];	//24 hour clock
	_min_tx = missionNamespace getVariable ["MEF_MAGIC_CONTROL_MIN", "-1"];		//0-60 min
	_sec_tx = missionNamespace getVariable ["MEF_MAGIC_CONTROL_SEC", "00"];		//0,15,30,45
	
	_hr = parseNumber _hr_tx;
	_min = parseNumber _min_tx;
	_sec = parseNumber _sec_tx;

	_timeArray = [];
	
	_kindOfTime = missionNamespace getVariable ["MEF_MAGIC_TOGGLE_DTG", 0];  //0=daytime 1=systemTime 2=watchOFF
	
	switch(_kindOfTime)do
	{
		case 0:		//daytime
		{
			_timeArray = [daytime, "ARRAY"] call fn_vbs_timeToString;  //returns ["HH","MM","SS","MS"]
		};
		case 1:		//systemTime
		{
			_HH = ["h", systemTime] call fn_vbs_dateToString;
			_MM = ["i", systemTime] call fn_vbs_dateToString;
			_SS = ["s", systemTime] call fn_vbs_dateToString;
			_timeArray = [_HH, _MM, _SS];
		};
		case 2:
		{
			//watch is off
			_timeArray = ["-1","-1","-1","-1"];
		};
	};
	
	_hr_cur = parseNumber (_timeArray select 0);
	_min_cur = parseNumber (_timeArray select 1);
	_sec_cur = parseNumber (_timeArray select 2);

	//calculate time difference in seconds
	_tot_in_seconds = [[2018,01,01,_hr_cur,_min_cur,_sec_cur], [2018,01,01,_hr, _min, _sec],5] call fn_vbs_timeDifference;
	
	_tot_array = [_tot_in_seconds, _hr_tx, _min_tx, _sec_tx];
	
	_tot_array
};

fn_magic_position_watch = 
{
	//passed array [_display]
	private["_display"];
	
	_display = _this select 0;
	
	//define controls	
	_ctrl_day_month_date = _display displayCtrl IDC_MAIN_WATCH_DY_MM_DD;
	_ctrl_hr_min_sec = _display displayCtrl IDC_MAIN_WATCH_HR_MIN_SEC;
	_ctrl_body = _display displayCtrl IDC_MAIN_WATCH_BODY;

	_imageW = getResolution select 0;		//screen width in pixels
	_imageH = getResolution select 1;		//screen height in pixels
	_squareW = _imageW/100;					//grid square pixel width
	_squareH = _imageH/100;					//grid square pixel height

	//this is uiPixelWidth and uiPixelHeight
	_scaleX = safeZoneW/_imageW;	 		//screen width % / image width px
	_scaleY = safeZoneH/_imageH; 			//screen height % / image height px

	//position watch body
	_ctrl_body_X = safeZoneX+4*_squareW*_scaleX; 
	_ctrl_body_y = 7*_squareH*_scaleY; 
	_ctrl_body_W = 13*_squareW*_scaleX; 
	_ctrl_body_H = 25*_squareH*_scaleY; 

	//position weekday, day, month
	_ctrl_ddmmdd_X = safeZoneX+8.0*_squareW*_scaleX;
	_ctrl_ddmmdd_Y = 15.5*_squareH*_scaleY;
	_ctrl_ddmmdd_W = 5.5*_squareW*_scaleX;
	_ctrl_ddmmdd_H = 2.25*_squareH*_scaleY;

	//position hr, min, sec
	_ctrl_hhmmss_X = safeZoneX+6.75*_squareW*_scaleX;
	_ctrl_hhmmss_Y = 18*_squareH*_scaleY;
	_ctrl_hhmmss_W = 10*_squareW*_scaleX;
	_ctrl_hhmmss_H = 4*_squareH*_scaleY;

	//font sizes
	_smallFont = 2.5*_squareH*_scaleY;
	_largeFont = 99*_squareH*_scaleY;

	//position and commit controls
	_ctrl_body ctrlSetPosition [_ctrl_body_X, _ctrl_body_Y, _ctrl_body_W, _ctrl_body_H];

	_ctrl_day_month_date ctrlSetPosition [_ctrl_ddmmdd_X, _ctrl_ddmmdd_Y, _ctrl_ddmmdd_W, _ctrl_ddmmdd_H];
	_ctrl_day_month_date ctrlSetFontHeight _smallFont; 

	_ctrl_hr_min_sec ctrlSetPosition [_ctrl_hhmmss_X, _ctrl_hhmmss_Y, _ctrl_hhmmss_W, _ctrl_hhmmss_H];
	//_ctrl_hr_min_sec ctrlSetFontHeight _largeFont;

	{_x ctrlCommit 0} forEach [_ctrl_body, _ctrl_day_month_date, _ctrl_hr_min_sec];
};

fn_magic_update_watch = 
{
	//passed array [_date_type, _ctrl_day_month_date, _ctrl_hr_min_sec, _ctrl_body]
	
	private ["_date_type", "_ctrl_day_month_date", "_ctrl_hr_min_sec", "_date", "_dayOfWeek", "_MM_DD","_HH_MM","_SS", "_kindOfTime", "_scenarioTime", "_strLen"];
	
	_date_type = _this select 0;
	_ctrl_day_month_date = _this select 1;
	_ctrl_hr_min_sec = _this select 2;
	_ctrl_body = _this select 3;
	
	if (_date_type < 2) then
	{
		//init some variables
		_date = 1;
		_dayOfWeek = "";
		_MM_DD = ""; 
		_HH_MM = "";
		_SS = "";
		
		_kindOfTime = date; //default to scenario time	
		
		switch(_date_type)do
		{
			case 0:   //scenario time
			{
				//scenario time uses commands date for day and daytime for HH MM SS
				
				_scenarioTime = [daytime , "HH:MM:SS"] call fn_vbs_timeToString;
				_strLen = strLen _scenarioTime;  //should return 8 digits

				_date = ["N", _kindOfTime] call fn_vbs_dateToString;
				
				//trim string for hours:minutes and seconds
				_HH_MM = trim [_scenarioTime, 0, (_strLen - 5)];
				_SS = trim [_scenarioTime, (_strLen - 2), 0];
				
				//show watch again
				{_x ctrlShow TRUE} forEach [_ctrl_day_month_date, _ctrl_hr_min_sec, _ctrl_body];
			};
			case 1: 	//computer time
			{
				//for computer time we can use sexy command systemTime
				_kindOfTime = systemTime;
				
				//numeric representation of the day of the week: 1 (for Monday) through 7 (for Sunday)
				_date = ["N", _kindOfTime] call fn_vbs_dateToString;
		
				_HH_MM = ["h:i", _kindOfTime] call fn_vbs_dateToString;
				_SS = ["s", _kindOfTime] call fn_vbs_dateToString;
			};
		};
	
		//update rest of watch
		//convert to a 2 letter uppercase string
		switch (_date) do
		{
			case "1": {_dayOfWeek = "MO"};
			case "2": {_dayOfWeek = "TU"};
			case "3": {_dayOfWeek = "WE"};
			case "4": {_dayOfWeek = "TH"};
			case "5": {_dayOfWeek = "FR"};
			case "6": {_dayOfWeek = "SA"};
			case "7": {_dayOfWeek = "SU"};
		};
		
		//month, without leading zeros: 1 through 12
		//Day of the month without leading zeros: 1 to 31
		_MM_DD = ["n-j", _kindOfTime] call fn_vbs_dateToString;

		//_ctrl_day_month_date ctrlSetText format["%1 %2-%3",_dayOfWeek, _month, _dayOfMonth];
		_ctrl_day_month_date ctrlSetText format["%1 %2",_dayOfWeek, _MM_DD];

		//font size is hard coded.  not sure if it will adjust with screen resoultions
		_ctrl_hr_min_sec ctrlSetStructuredText parseText format ["<t size='.39' >%1</t><t size='.25' valign='middle'>%2</t>",_HH_MM, _SS];
	
	}
	else
	{
		//hide ctrls
		{_x ctrlShow FALSE} forEach [_ctrl_day_month_date, _ctrl_hr_min_sec, _ctrl_body];
	};
};

fn_magic_set_mission_defaults = 
{
	_engagement_ctrl = _display displayCtrl IDC_MAIN_ENGAGEMENT_BUTTON; 
	_sheaf_btn = _display displayCtrl IDC_MAIN_SHEAF_BUTTON; 
	_method_btn = _display displayCtrl IDC_MAIN_METHOD_BUTTON;

	//reset method of engagement
	missionNamespace setVariable ["MEF_MAGIC_NUM_GUNS", MEF_MAGIC_DEFAULT_GUNS];	//0 = 1 gun
	missionNamespace setVariable ["MEF_MAGIC_NUM_RDS", MEF_MAGIC_DEFAULT_RDS];	//0=1 rd
	missionNamespace setVariable ["MEF_MAGIC_SHELL_TYPE", MEF_MAGIC_DEFAULT_SHELL];  //5 = 155 HE
	missionNamespace setVariable ["MEF_MAGIC_INTERVAL", MEF_MAGIC_DEFAULT_INT];  //1 = "15" sec
	_engagement_ctrl ctrlSetText "Method of Engagement (Optional)";	
	
	//reset sheaf
	missionNamespace setVariable ["MEF_MAGIC_SHEAF", MEF_MAGIC_DEFAULT_SHEAF];  //1=converged
	_sheaf_btn ctrlSetText "Sheaf (Optional)";
	 
	//reset method of control
	missionNamespace setVariable ["MEF_MAGIC_CONTROL_TYPE", "Delay"];	//delay
	missionNamespace setVariable ["MEF_MAGIC_CONTROL_DELAY", "5"]; //default "5" sec
	_method_btn ctrlSetText "Method of Fire Control (Optional)";
};
