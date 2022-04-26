//button event handler for the GUI

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//development variables
#ifdef MEF_MAGIC_BOMB_USE_MISSION_SCRIPTS
_projectDataFolder = "P:\vbs2\customer\other\mef_magic_bomb_tool\data\";
#else
_projectDataFolder = "\vbs2\customer\other\mef_magic_bomb_tool\data\";
#endif

//get basic data

_ctrl = _this select 0;
_idc = ctrlIDC _ctrl;
_display = MEF_MAGIC_BOMB_TOOL;

//when a button is clicked, executed blocks of code
switch (_idc) do
{
	case IDC_MAIN_PREVIOUS_BUTTON:
	{
		[-1, 5000] diagMessage "Documentation will open in a new window";
		openURL (_projectDataFolder + "docs\ARMNIT Instructions.pdf");
	};
	case IDC_MAIN_NEXT_BUTTON:
	{

	};	
	case IDC_MAIN_NEW_BUTTON:
	{

	};
	case IDC_MAIN_DELETE_BUTTON:
	{

	};		
	case IDC_MAIN_TGT_LOC_BUTTON:
	{
		//main screen, (Method) and Tgt Loc
		private ["_moving_01_ctrl", "_savedTgts_01_ctrl", "_savedTarget_list", "_saved_tgt", "_savedTgt_list_array", "_marker_name", "_idx_saved_tgt"];
		
		//open page
		[["PG_01"],TRUE] call fn_magic_load_page;
		
		//list controls, init variables
		_moving_01_ctrl = _display displayCtrl IDC_PG_01_MOVING_BUTTON;
		_savedTgts_01_ctrl = _display displayCtrl IDC_PG_01_SAVED_COMBO;		
		_savedTarget_list = [];
		
		//check if previous target
		//_saved_tgt = missionNamespace getVariable ["MEF_MAGIC_SAVED_TGT", ""];	//saved marker name	
		_saved_tgt = missionNamespace getVariable ["MEF_MAGIC_SAVED_TGT", "(Optional)"];	//saved marker name

		//clear labels and reload saved target list
		lbClear _savedTgts_01_ctrl;
		
		//find any target markers and populate combo box
		_savedTgt_list_array = call fn_magic_find_target_markers;

		//get marker descriptions
		{
			_marker_name = markerText _x;
			_savedTarget_list = _savedTarget_list + [_marker_name];  
		} forEach _savedTgt_list_array;

		//add "optional" to saved target list 
		_savedTarget_list = _savedTarget_list + ["(Optional)"];
		
		//page 01 saved targets, sort array and populate combo box
		_savedTarget_list = _savedTarget_list call fn_vbs_sortStrings; 
		
		{_savedTgts_01_ctrl lbAdd _x} forEach _savedTarget_list;
		
		_idx_saved_tgt = _savedTarget_list find (markerText _saved_tgt);
		_savedTgts_01_ctrl lbSetCurSel _idx_saved_tgt;	

		//set focus
		ctrlSetFocus _moving_01_ctrl;
	};
	case IDC_MAIN_ENGAGEMENT_BUTTON:
	{	
		//Main page, Method of Engagement
		private ["_num_guns_ctrl", "_num_rds_ctrl", "_shell_type_ctrl", "_interval_ctrl", "_num_guns_idx", "_num_rds_idx", "_shell_type_idx","_interval_idx"];
		
		//open page
		[["PG_05"],TRUE] call fn_magic_load_page;
		
		//list controls, init variables
		_num_guns_ctrl = _display displayCtrl IDC_PG_05_GUNS_COMBO;
		_num_rds_ctrl = _display displayCtrl IDC_PG_05_ROUNDS_COMBO;
		_shell_type_ctrl = _display displayCtrl IDC_PG_05_SHELL_COMBO;		
		_interval_ctrl = _display displayCtrl IDC_PG_05_INTERVAL_COMBO;
		
		_num_guns_idx = missionNamespace getVariable ["MEF_MAGIC_NUM_GUNS", MEF_MAGIC_DEFAULT_GUNS];
		_num_rds_idx = missionNamespace getVariable ["MEF_MAGIC_NUM_RDS", MEF_MAGIC_DEFAULT_RDS]; //0-12 rounds
		_shell_type_idx = missionNamespace getVariable ["MEF_MAGIC_SHELL_TYPE", MEF_MAGIC_DEFAULT_SHELL];
		_interval_idx = missionNamespace getVariable ["MEF_MAGIC_INTERVAL", MEF_MAGIC_DEFAULT_INT];  //1 = "15" sec
		
		//number of guns
		_num_guns_ctrl lbSetCurSel _num_guns_idx;
		
		//number of rounds
		_num_rds_ctrl lbSetCurSel _num_rds_idx;
		
		//shell type
		_shell_type_ctrl lbSetCurSel _shell_type_idx;
		
		//time between rounds
		_interval_ctrl lbSetCurSel _interval_idx;	

		//set focus
		ctrlSetFocus _num_guns_ctrl;
	};	
	case IDC_MAIN_SHEAF_BUTTON:
	{
		//Main page, Sheaf
		private ["_sheaf_ctrl", "_sheaf_idx", "_sheaf_ctrl"];
		
		//open page
		[["PG_14","PG_06"], TRUE] call fn_magic_load_page;
		
		//list controls, init variables
		_sheaf_ctrl = _display displayCtrl IDC_PG_14_TYPE_COMBO;

		//type of sheaf
		_sheaf_idx = missionNamespace getVariable ["MEF_MAGIC_SHEAF", MEF_MAGIC_DEFAULT_SHEAF];
		_sheaf_ctrl lbSetCurSel _sheaf_idx;
	};
	case IDC_MAIN_METHOD_BUTTON:
	{
		//Main page, Method of Fire Control
		private ["_date_type", "_control_delay_ctrl", "_control_type_ctrl", "_control_type", "_control_delay", "_idx_control_type", "_idx_control_delay"];
		
		//open page
		[["PG_15","PG_10"], TRUE] call fn_magic_load_page;	
		
		_date_type = missionNamespace getVariable ["MEF_MAGIC_TOGGLE_DTG", 0];	//returns 0-2
		
		//list controls, init variables
		_control_delay_ctrl = _display displayCtrl IDC_PG_10_SEC_COMBO;
		_control_type_ctrl = _display displayCtrl IDC_PG_15_TYPE_COMBO;		
			
		if (_date_type < 2) then
		{
			_control_type = missionNamespace getVariable ["MEF_MAGIC_CONTROL_TYPE", "Delay"];
			_control_delay = missionNamespace getVariable ["MEF_MAGIC_CONTROL_DELAY", "5"];	//default "5" sec	
			
			//check if previous control type selected
			if (_control_type != "") then
			{
				_idx_control_type = MEF_MAGIC_CONTROL find _control_type;
				_control_type_ctrl lbSetCurSel _idx_control_type;		
			}
			else
			{
				_control_type_ctrl lbSetCurSel 0; //delay
			};
			
			//check if previous delay selected
			if (_control_delay != "") then
			{
				_idx_control_delay = MEF_MAGIC_CONTROL_DELAY find _control_delay;
				_control_delay_ctrl lbSetCurSel _idx_control_delay;	
			}
			else
			{
				_control_delay_ctrl lbSetCurSel 0;	//5 seconds
			};

			//set focus
			ctrlSetFocus _control_delay_ctrl;
		}
		else
		{
			//no watch and panel opened, show defaults
			_control_type_ctrl lbSetCurSel 0; //delay
			_control_delay_ctrl lbSetCurSel 0;	//5 seconds
		};
	};		
	case IDC_MAIN_OBS_DIR_BUTTON:
	{
		//Main page, Observer Direction
		private ["_tgt_dir_ctrl", "_tgt_dir"];
		
		//open page
		[["PG_12"], TRUE] call fn_magic_load_page;
		
		//list controls, init variables
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_12_DIR_EDIT;
		
		_tgt_dir = missionNamespace getVariable ["MEF_MAGIC_OT_DIR", "6400"];
		
		_tgt_dir_ctrl ctrlSetText _tgt_dir;	
		
		//load mils or degrees
		[IDC_PG_12_MILS_IMAGE, IDC_PG_12_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_PRE"] call fn_magic_change_dir;
		
		//set focus
		ctrlSetFocus _tgt_dir_ctrl;
	};
	case IDC_MAIN_ADJUST_BUTTON:
	{
		//Main page, Adjustments
		private ["_tgt_dir_ctrl", "_adj_left_ctrl", "_adj_right_ctrl", "_adj_add_ctrl", "_adj_drop_ctrl", "_tgt_dir"];
		
		//open page
		[["PG_13"], TRUE] call fn_magic_load_page;
	
		//list controls, init variables
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_13_DIR_EDIT;
		_adj_left_ctrl = _display displayCtrl IDC_PG_13_LEFT_EDIT;
		_adj_right_ctrl = _display displayCtrl IDC_PG_13_RIGHT_EDIT;
		_adj_add_ctrl = _display displayCtrl IDC_PG_13_ADD_EDIT;
		_adj_drop_ctrl = _display displayCtrl IDC_PG_13_DROP_EDIT;

		//reset each edit field
		_adj_left_ctrl ctrlSetText "";  	//adj_left
		_adj_right_ctrl ctrlSetText ""; 	//_adj_right	
		_adj_add_ctrl ctrlSetText ""; 	//_adj_add	
		_adj_drop_ctrl ctrlSetText "";	//_adj_drop
		
		//load previous direction
		_tgt_dir = missionNamespace getVariable ["MEF_MAGIC_OT_DIR", "6400"];
		_tgt_dir_ctrl ctrlSetText _tgt_dir;		
		
		//load mils or degrees	
		[IDC_PG_13_MILS_IMAGE, IDC_PG_13_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_PRE"] call fn_magic_change_dir;		
			
		//set focus
		ctrlSetFocus _tgt_dir_ctrl;
	};	
	case IDC_MAIN_CREATE_BUTTON:
	{
		//find all saved data to create mission

		nul = [] execVM (_projectDataFolder + "scripts\mef_magic_bomb_create_fire_msn.sqf");
	};
	case IDC_MAIN_EOM_BUTTON:
	{
		//end of mission, stop mission
		_msn_tgt_num = missionNamespace getVariable ["MEF_MAGIC_MSN_TGT_NUM", -1];
		call compile format ["missionNamespace setVariable ['MEF_MAGIC_ACTIVE_MSN_%1', FALSE]", _msn_tgt_num];

		//change ECR markers to black
		for "_i" from 1 to 8 do
		{
			call compile format ["ECR_%1 setmarkerColorLocal 'ColorBlack'",_i];
		};
	};
	case IDC_PG_01_MOVING_BUTTON:
	{
		//target location, moving marker
		[["PG_01"], TRUE] call fn_magic_hide_page;
		
		//new mission, set defaults
		[] call fn_magic_set_mission_defaults;
		
		//flag to enable moving marker for mouse pointer tgt location
		MEF_MAGIC_ENABLE_MOVING_TGT_LOC = TRUE;
	};		
	case IDC_PG_01_GRID_BUTTON:
	{
		//target location, grid method
		private ["_tgt_mgrs_ctrl", "_tgt_dir_ctrl", "_msn_type", "_tgt_dir", "_tgt_sqid_ctrl", "_tgt_zone", "_tgt_sqid","_tgt_north", "_tgt_east"];
		
		//open page
		[["PG_01"], FALSE] call fn_magic_hide_page;	
		[["PG_02"], TRUE] call fn_magic_load_page;
		
		//list controls, init variables
		_tgt_mgrs_ctrl = _display displayCtrl IDC_PG_02_MGRS_EDIT;		
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_02_DIR_EDIT;
		
		_msn_type = missionNamespace getVariable ["MEF_MAGIC_MSN_TYPE", ""];
		_tgt_dir = missionNamespace getVariable ["MEF_MAGIC_OT_DIR", "6400"];

		//display previous target location
		if (_msn_type != "") then
		{
			//list controls, init variables
			_tgt_sqid_ctrl = _display displayCtrl IDC_PG_02_SQID_EDIT;
	
			_tgt_zone = missionNamespace getVariable ["MEF_MAGIC_TGT_ZONE", "24S"];
			_tgt_sqid = missionNamespace getVariable ["MEF_MAGIC_TGT_SQID", "VJ"];
			_tgt_north = missionNamespace getVariable ["MEF_MAGIC_TGT_NORTH", "02500"];
			_tgt_east = missionNamespace getVariable ["MEF_MAGIC_TGT_EAST", "82600"];			
			
			_tgt_sqid_ctrl ctrlSetText format["%1%2", _tgt_zone, _tgt_sqid];
			_tgt_mgrs_ctrl ctrlSetText format ["%1 %2", _tgt_north, _tgt_east];
		};
		
		//load previous direction
		_tgt_dir_ctrl ctrlSetText _tgt_dir;		
		
		//load mils or degrees
		[IDC_PG_02_MILS_IMAGE, IDC_PG_02_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_PRE"] call fn_magic_change_dir;
		
		//set focus
		ctrlSetFocus _tgt_mgrs_ctrl;
	};
	case IDC_PG_01_POLAR_BUTTON:
	{
		//target location, polar method
		private ["_obs_sqid_ctrl", "_obs_mgrs_ctrl", "_tgt_dir_ctrl", "_tgt_dis_ctrl", "_obs_name", "_obs_zone", "_obs_sqid", "_obs_north","_obs_east", "_tgt_dir", "_tgt_dis"];
		
		//open page
		[["PG_01"], FALSE] call fn_magic_hide_page;	
		[["PG_03"], TRUE] call fn_magic_load_page;

		//list controls, init variables
		_obs_sqid_ctrl = _display displayCtrl IDC_PG_03_SQID_EDIT;
		_obs_mgrs_ctrl = _display displayCtrl IDC_PG_03_MGRS_EDIT;	
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_03_DIR_EDIT;
		_tgt_dis_ctrl = _display displayCtrl IDC_PG_03_DIS_EDIT;
		
		//get last dir and dis and display
		_tgt_dir = missionNamespace getVariable ["MEF_MAGIC_OT_DIR", "6400"];
		_tgt_dis = missionNamespace getVariable ["MEF_MAGIC_OT_DIS", ""];
		
		_tgt_dir_ctrl ctrlSetText _tgt_dir;		
		_tgt_dis_ctrl ctrlSetText _tgt_dis;
			
		//is there a saved observer marker
		_obs_name = missionNamespace getVariable ["MEF_MAGIC_OBSERVER", ""]; 
		
		if (_obs_name == "") then
		{
			//add something here to load saved OP location
			_obs_zone = missionNamespace getVariable ["MEF_MAGIC_OBS_ZONE", "24S"];
			_obs_sqid = missionNamespace getVariable ["MEF_MAGIC_OBS_SQID", "VJ"];
			_obs_north = missionNamespace getVariable ["MEF_MAGIC_OBS_NORTH", "02541"];
			_obs_east = missionNamespace getVariable ["MEF_MAGIC_OBS_EAST", "81981"];		

			_obs_sqid_ctrl ctrlSetText format["%1%2", _obs_zone, _obs_sqid];
			_obs_mgrs_ctrl ctrlSetText format ["%1 %2", _obs_north, _obs_east];
		}
		else
		{
			//marker selected, get observer game pos and convert to MGRS grid
			_obs_loc = getMarkerpos _obs_name;
			
			_fullmgrs = _obs_loc call fn_magic_posToCoord;  //returns [_zone_sqID, _mgrs]
			
			//convert full mgrs into an array
			_mgrs_array = _fullmgrs call fn_magic_check_mgrs_format;

			//output results
			_obs_zone = _mgrs_array select 0;
			_obs_sqid = _mgrs_array select 1;
			_obs_north = _mgrs_array select 2;
			_obs_east = _mgrs_array select 3;
			
			_obs_sqid_ctrl ctrlSetText format["%1%2", _obs_zone,  _obs_sqid];
			_obs_mgrs_ctrl ctrlSetText format ["%1 %2", _obs_north, _obs_east];
		};
		
		//load mils or degrees
		[IDC_PG_03_MILS_IMAGE, IDC_PG_03_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_PRE"] call fn_magic_change_dir;
		
		//set focus
		ctrlSetFocus _obs_mgrs_ctrl;
	};	
	
	case IDC_PG_01_SHIFT_BUTTON:
	{
		//target location, polar method
		private ["_savedTgts_04_ctrl", "_tgt_dir_ctrl", "_shift_left_ctrl", "_shift_right_ctrl", "_shift_add_ctrl", "_shift_drop_ctrl", "_saved_tgt","_tgt_dir", "_shift_left", "_shift_right", "_shift_add", "_shift_drop", "_savedTarget_list", "_savedTgt_list_array", "_marker_name"];
		
		//open page
		[["PG_01"], FALSE] call fn_magic_hide_page;	
		[["PG_04"], TRUE] call fn_magic_load_page;
		
		//list controls, init variables
		_savedTgts_04_ctrl = _display displayCtrl IDC_PG_04_SAVED_COMBO;	
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_04_DIR_EDIT;				
		_shift_left_ctrl = _display displayCtrl IDC_PG_04_LEFT_EDIT;
		_shift_right_ctrl = _display displayCtrl IDC_PG_04_RIGHT_EDIT;
		_shift_add_ctrl = _display displayCtrl IDC_PG_04_ADD_EDIT;
		_shift_drop_ctrl = _display displayCtrl IDC_PG_04_DROP_EDIT;

		_saved_tgt = missionNamespace getVariable ["MEF_MAGIC_SAVED_TGT", "(Optional)"];	//saved marker name
		_tgt_dir = missionNamespace getVariable ["MEF_MAGIC_OT_DIR", "6400"];
		_shift_left = missionNamespace getVariable ["MEF_MAGIC_SHIFT_LEFT", ""];
		_shift_right = missionNamespace getVariable ["MEF_MAGIC_SHIFT_RIGHT", ""];
		_shift_add = missionNamespace getVariable ["MEF_MAGIC_SHIFT_ADD", ""];
		_shift_drop = missionNamespace getVariable ["MEF_MAGIC_SHIFT_DROP", ""];
		
		_savedTarget_list = [];
		
		//clear saved tgts
		lbClear _savedTgts_04_ctrl;
		
		//load saved dir
		_tgt_dir_ctrl ctrlSetText _tgt_dir;	
		
		//find any target markers and populate combo box
		_savedTgt_list_array = call fn_magic_find_target_markers;

		//get marker descriptions
		{
			_marker_name = markerText _x;
			_savedTarget_list = _savedTarget_list + [_marker_name];  
		} forEach _savedTgt_list_array;

		//add "optional" to saved target list 
		_savedTarget_list = _savedTarget_list + ["(Optional)"];
		
		//sort marker descriptions and add to combo box
		_savedTarget_list = _savedTarget_list call fn_vbs_sortStrings;  //sort array
		{_savedTgts_04_ctrl lbAdd _x} forEach _savedTarget_list;
	
		//find saved target and select in combo box
		_idx_saved_tgt = _savedTarget_list find (markerText _saved_tgt);
		_savedTgts_04_ctrl lbSetCurSel _idx_saved_tgt;			
		
		//load mils or degrees	
		[IDC_PG_04_MILS_IMAGE, IDC_PG_04_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_PRE"] call fn_magic_change_dir;
		
		//load previous shift distances
		_shift_left_ctrl ctrlSetText _shift_left;
		_shift_right_ctrl ctrlSetText _shift_right;
		_shift_add_ctrl ctrlSetText _shift_add;
		_shift_drop_ctrl ctrlSetText _shift_drop;			
		
		//set focus
		ctrlSetFocus _savedTgts_04_ctrl;
	};
	case IDC_PG_01_CANCEL_BUTTON:
	{
		//page 1 target location cancel button
		[["PG_01"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_01_OK_BUTTON:
	{
		//page 1 target location OK button
		private ["_tgt_loc_ctrl", "_savedTgt_list_array", "_idx_saved_tgt", "_saved_tgt_tx", "_saved_marker_info", "_saved_tgt", "_marker_pos", "_aimPoint_array", "_fullmgrs", "_mgrs_array", "_tgt_zone", "_tgt_sqID", "_tgt_north", "_tgt_east", "_msn_type", "_adjustment_ctrl"];
		
		//list controls, init variables
		_tgt_loc_ctrl = _display displayCtrl IDC_MAIN_TGT_LOC_BUTTON; 
		
		//find idx of selected text
		_idx_saved_tgt = lbCurSel IDC_PG_01_SAVED_COMBO;
		_saved_tgt_tx = lbText [IDC_PG_01_SAVED_COMBO, _idx_saved_tgt];	
		
		if ("(Optional)" in _saved_tgt_tx) then
		{
			//no target selected
			missionNamespace setVariable ["MEF_MAGIC_TARGET_LIST", ""]; 
		}
		else
		{
			//find marker info
			_saved_marker_info = [_saved_tgt_tx, "MEF_MAGIC_TARGET_LIST"] call fn_magic_find_marker_info; //returns [_marker_name,_marker_pos]
			
			_saved_tgt = _saved_marker_info select 0;
			_marker_pos = _saved_marker_info select 1;
		
			//save target location
			missionNamespace setVariable ["MEF_MAGIC_IMPACT_POINT", _marker_pos];  //init impact point
			
			//calculate additional aimpoints
			_aimPoint_array = call fn_magic_find_aimPoints;
			
			missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array]; //aimpoints for each gun
			missionNamespace setVariable ["MEF_MAGIC_SAVED_TGT", _saved_tgt];  //this is the marker name
			missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
			
			//convert impact grid from game pos to mgrs array
			_fullmgrs = _marker_pos call fn_magic_posToCoord;
			_mgrs_array = _fullmgrs call fn_magic_check_mgrs_format;
			
			_tgt_zone = _mgrs_array select 0;
			_tgt_sqID = _mgrs_array select 1;
			_tgt_north = _mgrs_array select 2;
			_tgt_east = _mgrs_array select 3;

			//save full mgrs grid
			_msn_type = format ["(%1)", _saved_tgt_tx];
			missionNamespace setVariable ["MEF_MAGIC_MSN_TYPE", _msn_type];
			missionNamespace setVariable ["MEF_MAGIC_TGT_ZONE", _tgt_zone];
			missionNamespace setVariable ["MEF_MAGIC_TGT_SQID", _tgt_sqID];
			missionNamespace setVariable ["MEF_MAGIC_TGT_NORTH", _tgt_north];
			missionNamespace setVariable ["MEF_MAGIC_TGT_EAST", _tgt_east];

			//button on main page for target location
			_tgt_loc_ctrl ctrlSetText format ["%1 %2 %3 %4 %5", _msn_type, _tgt_zone, _tgt_sqID, _tgt_north, _tgt_east];
			
			//reset adjustments button, new tgt entered
			_adjustment_ctrl = _display displayCtrl IDC_MAIN_ADJUST_BUTTON; 
			_adjustment_ctrl ctrlSetText "Adjustments";
			
			//Do not draw new marker
			missionNamespace setVariable ["MEF_MAGIC_DRAW_TGT", FALSE];
		};
		
		//hide page
		[["PG_01"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_02_MILS_BUTTON:
	{
		//page 02 mils button

		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];
		[IDC_PG_02_MILS_IMAGE, IDC_PG_02_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};	
	case IDC_PG_02_DEGS_BUTTON:
	{
		//page 02 degrees button
		
		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 1];
		[IDC_PG_02_MILS_IMAGE, IDC_PG_02_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};
	case IDC_PG_02_CANCEL_BUTTON:
	{
		//page 02 cancel button
		
		[["PG_02"], FALSE] call fn_magic_hide_page;
		[["PG_01"], TRUE] call fn_magic_load_page;
	};		
	case IDC_PG_02_OK_BUTTON:
	{
		//page 2 grid method OK button
		private ["_tgt_sqid_ctrl", "_tgt_mgrs_ctrl", "_tgt_dir_ctrl", "_adjustment_ctrl", "_zone_sqID", "_mgrs", "_mgrs_array", "_coords", "_pg_data_ok", "_aimPoint_array", "_tgt_zone", "_tgt_sqID", "_tgt_north", "_tgt_east", "_tgt_loc_ctrl", "_tgt_dir_tx", "_dir_units"];
		
		//list controls, init variables
		_tgt_sqid_ctrl = _display displayCtrl IDC_PG_02_SQID_EDIT;
		_tgt_mgrs_ctrl = _display displayCtrl IDC_PG_02_MGRS_EDIT;
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_02_DIR_EDIT;
		_adjustment_ctrl = _display displayCtrl IDC_MAIN_ADJUST_BUTTON; 
		
		//check format of the mgrs grid
		_zone_sqID = ctrlText _tgt_sqid_ctrl;
		_mgrs = ctrlText _tgt_mgrs_ctrl;
		
		_mgrs_array = [_zone_sqID, _mgrs] call fn_magic_check_mgrs_format;
		
		//check if mgrs grid returns good map coordinates
		_coords = [_mgrs_array, _tgt_sqid_ctrl, _tgt_mgrs_ctrl, "PG_02"] call fn_magic_check_mgrs_coords;
		
		//check if dir is valid
		[_tgt_dir_ctrl, "PG_02", "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_check_dir;
	
		//check if coords and dir are good
		_pg_data_ok = missionNamespace getVariable ["MEF_PG_02_OK", TRUE];
		
		if (_pg_data_ok) then
		{
			//data ok, save tgt loc
			missionNamespace setVariable ["MEF_MAGIC_IMPACT_POINT", _coords];	//init tgt location
			
			//new mission, set defaults
			[] call fn_magic_set_mission_defaults;

			//calculate aimpoints
			_aimPoint_array = call fn_magic_find_aimPoints;
			missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array]; //aimpoints for each gun
			missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
			
			_tgt_zone = _mgrs_array select 0;
			_tgt_sqID = _mgrs_array select 1;
			_tgt_north = _mgrs_array select 2;
			_tgt_east = _mgrs_array select 3;
		
			//save full mgrs grid
			missionNamespace setVariable ["MEF_MAGIC_MSN_TYPE", "(Grid)"];
			missionNamespace setVariable ["MEF_MAGIC_TGT_ZONE", _tgt_zone];
			missionNamespace setVariable ["MEF_MAGIC_TGT_SQID", _tgt_sqID];
			missionNamespace setVariable ["MEF_MAGIC_TGT_NORTH", _tgt_north];
			missionNamespace setVariable ["MEF_MAGIC_TGT_EAST", _tgt_east];
		
			//button on main page for target location
			_tgt_loc_ctrl = _display displayCtrl IDC_MAIN_TGT_LOC_BUTTON; 
			_tgt_loc_ctrl ctrlSetText format ["(Grid) %1 %2 %3 %4", _tgt_zone, _tgt_sqID, _tgt_north, _tgt_east];
			
			//display OT direction
			_tgt_dir_tx = ctrlText _tgt_dir_ctrl;	
			_dir_units = missionNamespace getVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];  //0=mils 1=degrees	

			//load mils or degrees
			[_dir_units, _tgt_dir_tx] call fn_magic_display_OT_dir;
			
			missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_PRE", _dir_units];
			missionNamespace setVariable ["MEF_MAGIC_OT_DIR", _tgt_dir_tx];
			
			//reset adjustments button, new tgt entered
			_adjustment_ctrl ctrlSetText "Adjustments";
			
			//Draw marker when create button is pushed
			missionNamespace setVariable ["MEF_MAGIC_DRAW_TGT", TRUE];
			
			[["PG_02"],TRUE] call fn_magic_hide_page;
		}
		else
		{
			missionNamespace setVariable ["MEF_PG_02_OK", TRUE];
		};
	};	
	case IDC_PG_03_MILS_BUTTON:
	{
		//polar mils button
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];
		[IDC_PG_03_MILS_IMAGE, IDC_PG_03_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};	
	case IDC_PG_03_DEGS_BUTTON:
	{
		//polar degrees button
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 1];
		[IDC_PG_03_MILS_IMAGE, IDC_PG_03_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};
	case IDC_PG_03_CANCEL_BUTTON:
	{
		//polar cancel button
		[["PG_03"], FALSE] call fn_magic_hide_page;
		[["PG_01"], TRUE] call fn_magic_load_page;
	
		ctrlSetFocus (_display displayCtrl IDC_PG_01_MOVING_BUTTON);
	};		
	case IDC_PG_03_OK_BUTTON:
	{
		//page 3 polar OK button
		private ["_obs_sqid_ctrl", "_obs_mgrs_ctrl", "_tgt_dir_ctrl", "_adjustment_ctrl", "_zone_sqID", "_mgrs", "_mgrs_array", "_obs_loc", "_pg_data_ok", "_tgt_dis_ctrl", "_tgt_loc_ctrl", "_obs_zone", "_obs_sqID", "_obs_north", "_obs_east", "_tgt_dir_tx", "_tgt_dis_tx", "_dir_units", "_tgt_dir", "_tgt_dis", "_polar_tgt_loc", "_aimPoint_array", "_fullmgrs",  "_tgt_zone", "_tgt_sqID", "_tgt_north", "_tgt_east"];
		
		//list controls, init variables
		_obs_sqid_ctrl = _display displayCtrl IDC_PG_03_SQID_EDIT;
		_obs_mgrs_ctrl = _display displayCtrl IDC_PG_03_MGRS_EDIT;
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_03_DIR_EDIT;
		_adjustment_ctrl = _display displayCtrl IDC_MAIN_ADJUST_BUTTON; 		
		
		//check format of the mgrs grid
		_zone_sqID = ctrlText _obs_sqid_ctrl;
		_mgrs = ctrlText _obs_mgrs_ctrl;
		
		_mgrs_array = [_zone_sqID, _mgrs] call fn_magic_check_mgrs_format;
		
		//check if mgrs grid returns good map coordinates
		_obs_loc = [_mgrs_array, _obs_sqid_ctrl, _obs_mgrs_ctrl, "PG_03"] call fn_magic_check_mgrs_coords;
		
		[_tgt_dir_ctrl, "PG_03", "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_check_dir;

		//check if coords and dir are good
		_pg_data_ok = missionNamespace getVariable ["MEF_PG_03_OK", TRUE];
	
		if (_pg_data_ok) then
		{	
			//list controls, init variables
			_tgt_dir_ctrl = _display displayCtrl IDC_PG_03_DIR_EDIT;		
			_tgt_dis_ctrl = _display displayCtrl IDC_PG_03_DIS_EDIT;	
			_tgt_loc_ctrl = _display displayCtrl IDC_MAIN_TGT_LOC_BUTTON; 		
		
			//data good, save
			_obs_zone = _mgrs_array select 0;
			_obs_sqID = _mgrs_array select 1;
			_obs_north = _mgrs_array select 2;
			_obs_east = _mgrs_array select 3;

			//save obs mgrs grid
			missionNamespace setVariable ["MEF_MAGIC_OBS_ZONE", _obs_zone];
			missionNamespace setVariable ["MEF_MAGIC_OBS_SQID", _obs_sqID];
			missionNamespace setVariable ["MEF_MAGIC_OBS_NORTH", _obs_north];
			missionNamespace setVariable ["MEF_MAGIC_OBS_EAST", _obs_east];
		
			//save OT direction
			_tgt_dir_tx = ctrlText _tgt_dir_ctrl;	
			missionNamespace setVariable ["MEF_MAGIC_OT_DIR", _tgt_dir_tx];		

			//save dis
			_tgt_dis_tx = ctrlText _tgt_dis_ctrl;	
			missionNamespace setVariable ["MEF_MAGIC_OT_DIS", _tgt_dis_tx];
			
			//save dir units
			_dir_units = missionNamespace getVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];  //0=mils 1=degrees
			missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_PRE", _dir_units];
			
			//display OT dir on main page
			[_dir_units, _tgt_dir_tx] call fn_magic_display_OT_dir;
			
			//convert dir and dis from text to numbers
			_tgt_dir = parseNumber _tgt_dir_tx;  //could be mils grid or degs mag
			_tgt_dis = parseNumber _tgt_dis_tx;
			
			//dir is in mils, convert to degrees
			if (_dir_units == 0) then
			{
				_tgt_dir = (parseNumber _tgt_dir_tx) / DEG_TO_MILS;  //degrees grid
			};			

			//dir is in degrees mag, convert to degrees grid
			if (_dir_units == 1) then
			{
				_tgt_dir = (parseNumber _tgt_dir_tx) - getDeclination;	//degrees grid
			};		
			
			//calculate polar target location, direction has been converted to degrees grid
			_polar_tgt_loc = [_obs_loc, _tgt_dis, _tgt_dir] call fn_vbs_relPos;
			
			//save tgt loc as game coord
			missionNamespace setVariable ["MEF_MAGIC_IMPACT_POINT", _polar_tgt_loc];	//init tgt location
			
			//new mission, set defaults
			[] call fn_magic_set_mission_defaults;
	
			//aimpoints for each gun
			_aimPoint_array = call fn_magic_find_aimPoints;
			missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array]; 
			missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
			
			//"impact" setMarkerPos _polar_tgt_loc;
	
			//convert target location from game pos to mgrs array
			_fullmgrs = _polar_tgt_loc call fn_magic_posToCoord;
			_mgrs_array = _fullmgrs call fn_magic_check_mgrs_format;
	
			//save the target location mgrs elements
			_tgt_zone = _mgrs_array select 0;
			_tgt_sqID = _mgrs_array select 1;
			_tgt_north = _mgrs_array select 2;
			_tgt_east = _mgrs_array select 3;

			//save tgt mgrs grid
			missionNamespace setVariable ["MEF_MAGIC_MSN_TYPE", "(Polar)"];
			missionNamespace setVariable ["MEF_MAGIC_TGT_ZONE", _tgt_zone];
			missionNamespace setVariable ["MEF_MAGIC_TGT_SQID", _tgt_sqID];
			missionNamespace setVariable ["MEF_MAGIC_TGT_NORTH", _tgt_north];
			missionNamespace setVariable ["MEF_MAGIC_TGT_EAST", _tgt_east];
			
			//button on main page for target location
			_tgt_loc_ctrl ctrlSetText format ["(Polar) %1 %2 %3 %4", _tgt_zone, _tgt_sqID, _tgt_north, _tgt_east];

			//reset adjustments button, new tgt entered
			_adjustment_ctrl ctrlSetText "Adjustments";
			
			//Draw marker when create button is pushed
			missionNamespace setVariable ["MEF_MAGIC_DRAW_TGT", TRUE];
			
			[["PG_03"], TRUE] call fn_magic_hide_page;
		}
		else
		{
			//show error message
			[-1,5000] diagMessage "Bad observer location or direction";
			missionNamespace setVariable ["MEF_PG_03_OK", TRUE];
		};

	};		
	case IDC_PG_04_MILS_BUTTON:
	{
		//shift from known point, mils button
		
		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];
		[IDC_PG_04_MILS_IMAGE, IDC_PG_04_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};	
	case IDC_PG_04_DEGS_BUTTON:
	{
		//shift from known point, degrees button

		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 1];
		[IDC_PG_04_MILS_IMAGE, IDC_PG_04_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};
	case IDC_PG_04_CANCEL_BUTTON:
	{
		//shift from known point, cancel button
		[["PG_04"], FALSE] call fn_magic_hide_page;
		[["PG_01"], TRUE] call fn_magic_load_page;
		
		ctrlSetFocus (_display displayCtrl IDC_PG_01_MOVING_BUTTON);
	};		
	case IDC_PG_04_OK_BUTTON:
	{
		//shift from known point ok button
		private ["_tgt_dir_ctrl", "_pg_data_ok", "_shift_left_ctrl", "_shift_right_ctrl", "_shift_add_ctrl", "_shift_drop_ctrl", "_tgt_loc_ctrl", "_adjustment_ctrl", "_pt_impact", "_lateral_shift", "_range_shift", "_shift_dir", "_idx_saved_tgt", "_saved_tgt_tx", "_saved_marker_info", "_marker_name", "_marker_pos", "_tgt_dir_tx", "_dir_units", "_tgt_dir", "_shift_left", "_left", "_shift_right", "_right", "_aimPoint_array", "_shift_add", "_add", "_shift_drop", "_drop", "_fullmgrs", "_mgrs_array", "_tgt_zone", "_tgt_sqID", "_tgt_north", "_tgt_east", "_msnType"];
		
		//list controls, init variables
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_04_DIR_EDIT;
		
		//check if valid direction
		[_tgt_dir_ctrl, "PG_04", "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_check_dir;
		
		_pg_data_ok = missionNamespace getVariable ["MEF_PG_04_OK", TRUE];
	
		//page data ok,
		if (_pg_data_ok) then
		{	
			//list controls, init variables
			_shift_left_ctrl = _display displayCtrl IDC_PG_04_LEFT_EDIT;
			_shift_right_ctrl = _display displayCtrl IDC_PG_04_RIGHT_EDIT;
			_shift_add_ctrl = _display displayCtrl IDC_PG_04_ADD_EDIT;
			_shift_drop_ctrl = _display displayCtrl IDC_PG_04_DROP_EDIT;
			_tgt_loc_ctrl = _display displayCtrl IDC_MAIN_TGT_LOC_BUTTON; 
			_adjustment_ctrl = _display displayCtrl IDC_MAIN_ADJUST_BUTTON; 
						
			_pt_impact = [];
			_lateral_shift = 0;
			_range_shift = 0;
			_shift_dir = 360;

			//what target was selected
			_idx_saved_tgt = lbCurSel IDC_PG_04_SAVED_COMBO;
			_saved_tgt_tx = lbText [IDC_PG_04_SAVED_COMBO, _idx_saved_tgt];	//marker description

			if ("(Optional)" in _saved_tgt_tx) then
			{
				//no target selected
				missionNamespace setVariable ["MEF_MAGIC_TARGET_LIST", ""];
				
				//show error message
				[-1,5000] diagMessage "No Shift Target Selected";
			}
			else
			{
				_saved_marker_info = [_saved_tgt_tx, "MEF_MAGIC_TARGET_LIST"] call fn_magic_find_marker_info; //returns [_marker_name,_marker_pos]
				
				_marker_name = _saved_marker_info select 0;
				_marker_pos = _saved_marker_info select 1;
				
				missionNamespace setVariable ["MEF_MAGIC_SAVED_TGT", _marker_name];  //this is the marker name
				
				//find direction to saved target
				_tgt_dir_tx = ctrlText _tgt_dir_ctrl;	
				missionNamespace setVariable ["MEF_MAGIC_OT_DIR", _tgt_dir_tx];	  //save string

				_dir_units = missionNamespace getVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];  //0=mils 1=degrees
				missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_PRE", _dir_units];			

				//display OT dir on main page
				[_dir_units, _tgt_dir_tx] call fn_magic_display_OT_dir;
				
				//convert direction in degrees
				_tgt_dir = (parseNumber _tgt_dir_tx);
			
				//dir is in mils, convert to degrees
				if (_dir_units == 0) then //0=mils 1=degrees
				{
					_tgt_dir = (parseNumber _tgt_dir_tx) / DEG_TO_MILS;  //degrees grid
				};			

				//dir is in degrees mag, convert to degrees grid
				if (_dir_units == 1) then
				{
					_tgt_dir = (parseNumber _tgt_dir_tx) - getDeclination;	//degrees grid
				};	
		
				//determine if the user entered left or right
				_shift_left = ctrlText _shift_left_ctrl;
				missionNamespace setVariable ["MEF_MAGIC_SHIFT_LEFT", _shift_left];	//string
				_left = parseNumber _shift_left;
				
				_shift_right = ctrlText _shift_right_ctrl;
				missionNamespace setVariable ["MEF_MAGIC_SHIFT_RIGHT", _shift_right];	
				_right = parseNumber _shift_right;
				
				//something was entered
				if (_left != _right) then
				{
					if (_left > _right) then
					{
						//left
						_lateral_shift = _left;
						_shift_dir = _tgt_dir+270;
					}
					else
					{
						//right
						_lateral_shift = _right;
						_shift_dir = _tgt_dir+90;
					};
				};
				
				//calculate point of impact with left or right shift
				_pt_impact = [_marker_pos,_lateral_shift,_shift_dir] call fn_vbs_relPos; 
				
				//save this data in case no add or drop 
				missionNamespace setVariable ["MEF_MAGIC_IMPACT_POINT", _pt_impact];	//init tgt location
				
				//calculate aimpoints
				_aimPoint_array = call fn_magic_find_aimPoints;
				missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array]; //aimpoints for each gun
				missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
				
				//determine if the user entered add or drop
				_shift_add = ctrlText _shift_add_ctrl;	
				missionNamespace setVariable ["MEF_MAGIC_SHIFT_ADD", _shift_add];	
				_add = parseNumber _shift_add;
						
				_shift_drop = ctrlText _shift_drop_ctrl;	
				missionNamespace setVariable ["MEF_MAGIC_SHIFT_DROP", _shift_drop];	
				_drop = parseNumber _shift_drop;
					
				//something was entered
				if (_add != _drop) then
				{
					if (_add > _drop) then
					{
						//add
						_range_shift = _add;
						_shift_dir = _tgt_dir;
					}
					else
					{
						//drop
						_range_shift = _drop;
						_shift_dir = _tgt_dir+180;
					};
				};

				//calculate point of impact with left/right and add or drop
				_pt_impact = [_pt_impact,_range_shift,_shift_dir] call fn_vbs_relPos; 
				
				//save this data in case no left or right 
				missionNamespace setVariable ["MEF_MAGIC_IMPACT_POINT", _pt_impact];	//init tgt location
				
				//new mission, set defaults
				[] call fn_magic_set_mission_defaults;
				
				//calculate aimpoints
				_aimPoint_array = call fn_magic_find_aimPoints;
				missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array]; //aimpoints for each gun
				missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
			
				//convert impact grid from game pos to mgrs array
				_fullmgrs = _pt_impact call fn_magic_posToCoord;
				_mgrs_array = _fullmgrs call fn_magic_check_mgrs_format;

				//save the target location
				_tgt_zone = _mgrs_array select 0;
				_tgt_sqID = _mgrs_array select 1;
				_tgt_north = _mgrs_array select 2;
				_tgt_east = _mgrs_array select 3;

				_msnType = format ["(Shift %1)", _saved_tgt_tx];
				missionNamespace setVariable ["MEF_MAGIC_MSN_TYPE", _msnType];
				missionNamespace setVariable ["MEF_MAGIC_TGT_ZONE", _tgt_zone];
				missionNamespace setVariable ["MEF_MAGIC_TGT_SQID", _tgt_sqID];
				missionNamespace setVariable ["MEF_MAGIC_TGT_NORTH", _tgt_north];
				missionNamespace setVariable ["MEF_MAGIC_TGT_EAST", _tgt_east];
				
				//button on main page for target location
				_tgt_loc_ctrl ctrlSetText format ["%1 %2 %3 %4 %5", _msnType, _tgt_zone, _tgt_sqID, _tgt_north, _tgt_east];

				//reset adjustments button, new tgt entered
				_adjustment_ctrl ctrlSetText "Adjustments";
			};
			
			//Do not draw new marker
			missionNamespace setVariable ["MEF_MAGIC_DRAW_TGT", FALSE];
			
			[["PG_04"], TRUE] call fn_magic_hide_page;
		}
		else
		{
			//show error message
			[-1,5000] diagMessage "Bad target location or direction";
			missionNamespace setVariable ["MEF_PG_04_OK", TRUE];
		};
	};	
	case IDC_PG_05_CANCEL_BUTTON:
	{
		//Method of engagement cancel button
		[["PG_05"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_05_OK_BUTTON:
	{
		//Method of Engagement ok button
		private ["_idx_num_guns", "_num_guns", "_sheaf_ctrl", "_sheaf_tx", "_idx_num_rds", "_num_rds", "_idx_shell_type", "_shell_type", "_shell_data", "_idx_interval", "_interval", "_engagement_btn", "_aimPoint_array"];
		
		//get number of guns selected
		_idx_num_guns = lbCurSel IDC_PG_05_GUNS_COMBO;
		_num_guns = _idx_num_guns + 1;
		missionNamespace setVariable ["MEF_MAGIC_NUM_GUNS", _idx_num_guns];
		
		//force converged sheaf is 1 gun selected
		_sheaf_ctrl = _display displayCtrl IDC_MAIN_SHEAF_BUTTON;
		_sheaf_tx = ctrlText IDC_MAIN_SHEAF_BUTTON;
		
		if(_idx_num_guns == 0) then
		{
			if
			(
				!("(Optional)" in _sheaf_tx) &&
				!("Converged" in _sheaf_tx)
			)
			then
			{
				//force converged sheaf
				_sheaf_ctrl ctrlSetText "Converged Sheaf";
				missionNamespace setVariable ["MEF_MAGIC_SHEAF", 1];  //1=converged
			};
		};

		//get number of rounds
		_idx_num_rds = lbCurSel IDC_PG_05_ROUNDS_COMBO;
		//_num_rds =  _idx_num_rds + 1;
		_num_rds =  _idx_num_rds;
		missionNamespace setVariable ["MEF_MAGIC_NUM_RDS", _idx_num_rds]; //0-12 rounds
		
		//get shell selected
		_idx_shell_type = lbCurSel IDC_PG_05_SHELL_COMBO;
		_shell_type = MEF_MAGIC_SHELL select _idx_shell_type;
		missionNamespace setVariable ["MEF_MAGIC_SHELL_TYPE", _idx_shell_type];
		
		//find shell data (ECR in meters)
		_shell_data = _idx_shell_type call fn_magic_find_shell_data;
		missionNamespace setVariable ["MEF_MAGIC_SHELL_DATA", _shell_data];		
	
		//find interval inbetween rounds
		_idx_interval = lbCurSel IDC_PG_05_INTERVAL_COMBO;
		_interval = MEF_MAGIC_INTERVAL select _idx_interval;
		missionNamespace setVariable ["MEF_MAGIC_INTERVAL", _idx_interval];  //idx 1= "15" sec

		//update method of engagement button
		_engagement_btn = _display displayCtrl IDC_MAIN_ENGAGEMENT_BUTTON; 
		_engagement_btn ctrlSetText format ["%1 Guns, %2 Rds, Shell %3, Int %4 sec",_num_guns, _num_rds, _shell_type, _interval];

		//calculate aimpoints
		_aimPoint_array = call fn_magic_find_aimPoints;
		missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array];	
		missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
		
		[["PG_05"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_06_CANCEL_BUTTON:
	{
		//sheaf open, parallel, converged, cancel button
		[["PG_06","PG_14"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_06_OK_BUTTON:
	{
		//sheaf open, parallel, converged, ok button
		private["_idx_sheaf", "_sheaf", "_sheaf_btn", "_aimPoint_array"];
		
		//save selected sheaf
		_idx_sheaf = lbCurSel IDC_PG_14_TYPE_COMBO;  //idx of selection
		_sheaf = MEF_MAGIC_SHEAF select _idx_sheaf;	//text of selection
		missionNamespace setVariable ["MEF_MAGIC_SHEAF", _idx_sheaf];  //number
		
		//update sheaf button
		_sheaf_btn = _display displayCtrl IDC_MAIN_SHEAF_BUTTON; 
		_sheaf_btn ctrlSetText format ["%1 Sheaf",_sheaf];

		//calculate aimpoints
		_aimPoint_array = call fn_magic_find_aimPoints;
		missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array];		
		missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
	
		[["PG_06","PG_14"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_07_MILS_BUTTON:
	{
		//sheaf rectangle mils button

		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_RECT_ATT_UNITS_CUR", 0];
		[IDC_PG_07_MILS_IMAGE, IDC_PG_07_DEGS_IMAGE, "MEF_MAGIC_RECT_ATT_UNITS_CUR"] call fn_magic_change_dir;
	};	
	case IDC_PG_07_DEGS_BUTTON:
	{
		//sheaf rectangle degrees button

		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_RECT_ATT_UNITS_CUR", 1];
		[IDC_PG_07_MILS_IMAGE, IDC_PG_07_DEGS_IMAGE, "MEF_MAGIC_RECT_ATT_UNITS_CUR"] call fn_magic_change_dir;
	};
	case IDC_PG_07_CANCEL_BUTTON:
	{
		//sheaf rectangle cancel button
		
		[["PG_07","PG_14"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_07_OK_BUTTON:
	{
		//sheaf rectangle ok button
		private ["_rect_att_ctrl", "_pg_data_ok", "_tgt_loc", "_idx_sheaf", "_idx_rect_len", "_rect_len", "_idx_rect_wid", "_rect_wid", "_rect_att", "_dir_units", "_dir_units_tx", "_sheaf_btn", "_rect_len_tx", "_rect_wid_tx", "_rect_att_tx", "_aimPoint_array"];
	
		//check attitude
		_rect_att_ctrl = _display displayCtrl IDC_PG_07_ATTITIUDE_EDIT;
		[_rect_att_ctrl, "PG_07", "MEF_MAGIC_RECT_ATT_UNITS_CUR"] call fn_magic_check_dir;

		//check if dir is good
		_pg_data_ok = missionNamespace getVariable ["MEF_PG_07_OK", TRUE];

		//page data ok,
		if (_pg_data_ok) then
		{	
			//save selected sheaf
			_idx_sheaf = lbCurSel IDC_PG_14_TYPE_COMBO;
			missionNamespace setVariable ["MEF_MAGIC_SHEAF", _idx_sheaf];

			//rectangle length
			_idx_rect_len = lbCurSel IDC_PG_07_LENGTH_COMBO;
			_rect_len = MEF_MAGIC_RECT_LENGTH select _idx_rect_len;
			missionNamespace setVariable ["MEF_MAGIC_RECT_LEN", _rect_len];

			//rectangle width
			_idx_rect_wid = lbCurSel IDC_PG_07_WIDTH_COMBO;
			_rect_wid = MEF_MAGIC_WIDTH select _idx_rect_wid;
			missionNamespace setVariable ["MEF_MAGIC_RECT_WID", _rect_wid];
		
			//attitude of rectangle
			_rect_att = ctrlText _rect_att_ctrl;	
			missionNamespace setVariable ["MEF_MAGIC_RECT_ATT", _rect_att];  //string
		
			//units for direction
			_dir_units = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT_UNITS_CUR", 0];  //0=mils 1=degrees
			missionNamespace setVariable ["MEF_MAGIC_RECT_ATT_UNITS_PRE", _dir_units];	
			
			//get units
			_dir_units_tx = "mils grid";
			if (_dir_units == 1) then
			{
				_dir_units_tx = "degs mag";
			};
			
			//update sheaf button
			_sheaf_btn = _display displayCtrl IDC_MAIN_SHEAF_BUTTON; 
			_sheaf_btn ctrlSetText format ["Rectangular Sheaf, L %1m, W %2m, Att %3 %4 ", _rect_len, _rect_wid, _rect_att, _dir_units_tx];
			
			//save data
			_rect_len_tx = missionNamespace getVariable ["MEF_MAGIC_RECT_LEN", "300"];
			_rect_wid_tx = missionNamespace getVariable ["MEF_MAGIC_RECT_WID", "100"];
			_rect_att_tx = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT", "6400"];
			_dir_units = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT_UNITS_CUR", 0];  //0=mils 1=degrees
			
			_rect_att = parseNumber _rect_att_tx;
			_rect_len = parseNumber _rect_len_tx;
			_rect_wid = parseNumber _rect_wid_tx;
			
			//convert direction in degrees
			if (_dir_units == 0) then //0=mils 1=degrees
			{
				_rect_att = (parseNumber _rect_att_tx) / DEG_TO_MILS;
			};

			//calculate aimpoints
			_aimPoint_array = call fn_magic_find_aimPoints;
			missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array];	
			missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
			
			[["PG_07","PG_14"], TRUE] call fn_magic_hide_page;
		}
		else
		{
			missionNamespace setVariable ["MEF_PG_07_OK", TRUE];
		};

	};		
	case IDC_PG_08_MILS_BUTTON:
	{
		//linear sheaf mils button
		
		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_LINE_ATT_UNITS_CUR", 0];
		[IDC_PG_08_MILS_IMAGE, IDC_PG_08_DEGS_IMAGE, "MEF_MAGIC_LINE_ATT_UNITS_CUR"] call fn_magic_change_dir;
	};	
	case IDC_PG_08_DEGS_BUTTON:
	{
		//linear sheaf degrees button

		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_LINE_ATT_UNITS_CUR", 1];
		[IDC_PG_08_MILS_IMAGE, IDC_PG_08_DEGS_IMAGE, "MEF_MAGIC_LINE_ATT_UNITS_CUR"] call fn_magic_change_dir;
	};
	case IDC_PG_08_CANCEL_BUTTON:
	{
		//linear sheaf cancel button
		[["PG_08","PG_14"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_08_OK_BUTTON:
	{
		//linear sheaf ok button
		private ["_line_att_ctrl", "_pg_data_ok", "_idx_sheaf", "_idx_line_len", "_line_len", "_line_att", "_dir_units", "_dir_units_tx", "_sheaf_btn", "_aimPoint_array"];
		
		//check if good direction entered
		_line_att_ctrl = _display displayCtrl IDC_PG_08_ATTITIUDE_EDIT;
		[_line_att_ctrl, "PG_08", "MEF_MAGIC_LINE_ATT_UNITS_CUR"] call fn_magic_check_dir;

		_pg_data_ok = missionNamespace getVariable ["MEF_PG_08_OK", TRUE];
		
		//page data ok,
		if (_pg_data_ok) then
		{	
			//get saved data
			_idx_sheaf = lbCurSel IDC_PG_14_TYPE_COMBO;
			missionNamespace setVariable ["MEF_MAGIC_SHEAF", _idx_sheaf];

			_idx_line_len = lbCurSel IDC_PG_08_LENGTH_COMBO;
			_line_len = MEF_MAGIC_LINE_LENGTH select _idx_line_len;
			missionNamespace setVariable ["MEF_MAGIC_LINE_LEN", _line_len];	
		
			_line_att = ctrlText _line_att_ctrl;	
			missionNamespace setVariable ["MEF_MAGIC_LINE_ATT", _line_att];	

			_dir_units = missionNamespace getVariable ["MEF_MAGIC_LINE_ATT_UNITS_CUR", 0];  //0=mils 1=degrees
			missionNamespace setVariable ["MEF_MAGIC_LINE_ATT_UNITS_PRE", _dir_units];	
			
			//get units for direction
			_dir_units_tx = "mils grid";
			
			if (_dir_units == 1) then
			{
				_dir_units_tx = "degs mag";
			};
			
			//update sheaf button
			_sheaf_btn = _display displayCtrl IDC_MAIN_SHEAF_BUTTON; 
			_sheaf_btn ctrlSetText format ["Linear Sheaf, Length %1 meters, Attitude %2 %3 ", _line_len, _line_att, _dir_units_tx];
			
			_aimPoint_array = call fn_magic_find_aimPoints;
			missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array];	
			missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
			
			[["PG_08","PG_14"], TRUE] call fn_magic_hide_page;
		}
		else
		{
			missionNamespace setVariable ["MEF_PG_08_OK", TRUE];
		};
	};		
	case IDC_PG_09_CANCEL_BUTTON:
	{
		//sheaf circle cancel
		[["PG_09","PG_14"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_09_OK_BUTTON:
	{
		//sheaf circle ok
		private ["_idx_sheaf", "_sheaf", "_radius_ctrl", "_radius", "_sheaf_btn", "_aimPoint_array"];
		
		//get saved data
		_idx_sheaf = lbCurSel IDC_PG_14_TYPE_COMBO;
		_sheaf = MEF_MAGIC_SHEAF select _idx_sheaf;  //selected text
		missionNamespace setVariable ["MEF_MAGIC_SHEAF", _idx_sheaf];  //save selected idx
				
		_radius_ctrl = _display displayCtrl IDC_PG_09_RADIUS_EDIT;
		_radius = ctrlText _radius_ctrl;	
		missionNamespace setVariable ["MEF_MAGIC_RADIUS", _radius];	
		
		//update sheaf button
		_sheaf_btn = _display displayCtrl IDC_MAIN_SHEAF_BUTTON; 
		_sheaf_btn ctrlSetText format ["Circular Sheaf, Radius %1 meters", _radius];
		
		//calculate aimpoints
		_aimPoint_array = call fn_magic_find_aimPoints;
		missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array];	
		missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers
		
		[["PG_09","PG_14"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_10_CANCEL_BUTTON:
	{
		//method of fire control, delay cancel
		[["PG_10","PG_15"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_10_OK_BUTTON:
	{
		//method of fire control, delay ok
		private ["_idx_control_type", "_control_type", "_idx_control_time", "_control_time", "_method_btn"];
		
		//get saved data
		_idx_control_type = lbCurSel IDC_PG_15_TYPE_COMBO;
		_control_type = MEF_MAGIC_CONTROL select _idx_control_type;
		missionNamespace setVariable ["MEF_MAGIC_CONTROL_TYPE", _control_type];	//delay
	
		_idx_control_time = lbCurSel IDC_PG_10_SEC_COMBO;
		_control_time = MEF_MAGIC_CONTROL_DELAY select _idx_control_time;	//5,15,30,45,60
		missionNamespace setVariable ["MEF_MAGIC_CONTROL_DELAY", _control_time];

		//update method of Fire Control button
		_method_btn = _display displayCtrl IDC_MAIN_METHOD_BUTTON; 
		_method_btn ctrlSetText format ["%1 sec, %2",_control_time, _control_type];
		
		[["PG_10","PG_15"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_11_CANCEL_BUTTON:
	{
		//method of fire control time on target, cancel
		[["PG_11","PG_15"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_11_OK_BUTTON:
	{
		//method of fire control time on target, ok
		
		//get saved data
		_idx_control_type = lbCurSel IDC_PG_15_TYPE_COMBO;
		_control_type = MEF_MAGIC_CONTROL select _idx_control_type;
		missionNamespace setVariable ["MEF_MAGIC_CONTROL_TYPE", _control_type];	//time on tgt
		
		_control_hr_ctrl = _display displayCtrl IDC_PG_11_HR_EDIT;
		_control_hr = ctrlText _control_hr_ctrl;	
		missionNamespace setVariable ["MEF_MAGIC_CONTROL_HR", _control_hr];	//24 hour clock

		_control_min_ctrl = _display displayCtrl IDC_PG_11_MIN_EDIT;
		_control_min = ctrlText _control_min_ctrl;	
		missionNamespace setVariable ["MEF_MAGIC_CONTROL_MIN", _control_min];		//0-60 min

		_idx_control_sec = lbCurSel IDC_PG_11_SEC_COMBO;
		_control_sec = MEF_MAGIC_CONTROL_SEC select _idx_control_sec;
		missionNamespace setVariable ["MEF_MAGIC_CONTROL_SEC", _control_sec];		//0,15,30,45
		
		//update method of Fire Control button
		_method_btn = _display displayCtrl IDC_MAIN_METHOD_BUTTON; 
		_method_btn ctrlSetText format ["%1, %2:%3:%4", _control_type, _control_hr, _control_min, _control_sec];
		
		
		//check if tot is valid
		
		[["PG_11","PG_15"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_12_MILS_BUTTON:
	{
		//observer to target direction, mils
		
		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];
		[IDC_PG_12_MILS_IMAGE, IDC_PG_12_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};	
	case IDC_PG_12_DEGS_BUTTON:
	{
		//observer to target direction, degrees
		
		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 1];
		[IDC_PG_12_MILS_IMAGE, IDC_PG_12_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};
	case IDC_PG_12_CANCEL_BUTTON:
	{
		//observer to target direction, cancel
		[["PG_12"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_12_OK_BUTTON:
	{
		//observer to target direction, Ok
		private ["_tgt_dir_ctrl", "_pg_data_ok", "_tgt_dir_tx", "_dir_units", "_dir_tx", "_output", "_OT_dir_ctrl"];
		
		//check for good direction
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_12_DIR_EDIT;
		[_tgt_dir_ctrl, "PG_12", "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_check_dir;
		
		_pg_data_ok = missionNamespace getVariable ["MEF_PG_12_OK", TRUE];

		//page data ok,
		if (_pg_data_ok) then
		{	
			//get entered data
			_tgt_dir_tx = ctrlText _tgt_dir_ctrl;
			missionNamespace setVariable ["MEF_MAGIC_OT_DIR", _tgt_dir_tx];	
			
			_dir_units = missionNamespace getVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];  //0=mils 1=degrees
			missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_PRE", _dir_units];
			
			//determine if mils or degrees
			_dir_tx = "mils grid";
			
			if (_dir_units==1) then
			{
				_dir_tx = "degs mag";
			};
			
			//update OT button
			_output = format ["%1 %2", _tgt_dir_tx, _dir_tx];
			
			_OT_dir_ctrl = _display displayCtrl IDC_MAIN_OBS_DIR_BUTTON;		
			_OT_dir_ctrl ctrlSetText _output;
			
			[["PG_12"], TRUE] call fn_magic_hide_page;
		}
		else
		{
			missionNamespace setVariable ["MEF_PG_12_OK", TRUE];
		};
	};		
	case IDC_PG_13_MILS_BUTTON:
	{
		//adjustment mils button
		
		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];
		[IDC_PG_13_MILS_IMAGE, IDC_PG_13_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};	
	case IDC_PG_13_DEGS_BUTTON:
	{
		//adjustment degrees button
		
		//set units to 0=mils, 1=degs
		missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", 1];
		[IDC_PG_13_MILS_IMAGE, IDC_PG_13_DEGS_IMAGE, "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_change_dir;
	};
	case IDC_PG_13_CANCEL_BUTTON:
	{
		//adjustment cancel button
		[["PG_13"], TRUE] call fn_magic_hide_page;
	};		
	case IDC_PG_13_OK_BUTTON:
	{
		//adjustment ok button
		private ["_tgt_dir_ctrl", "_pt_impact", "_pg_data_ok", "_lateral_shift", "_range_shift", "_shift_dir", "_adjustment_tx", "_tgt_dir_tx", "_dir_units", "_adj_left_ctrl", "_adj_left", "_adj_right_ctrl", "_adj_right",  "_adj_add_ctrl", "_adj_add", "_adj_drop_ctrl", "_adj_drop", "_tgt_dir", "_left", "_right", "_add", "_drop", "_aimPoint_array", "_fullmgrs", "_mgrs_array", "_tgt_zone", "_tgt_sqID", "_tgt_north", "_tgt_east", "_tgt_loc_ctrl", "_adjustment_ctrl"];
		
		//check for good direction
		_tgt_dir_ctrl = _display displayCtrl IDC_PG_13_DIR_EDIT;
		[_tgt_dir_ctrl, "PG_13", "MEF_MAGIC_OT_UNITS_CUR"] call fn_magic_check_dir;
		
		//check for current target location
		_pt_impact = missionNamespace getVariable ["MEF_MAGIC_IMPACT_POINT", []];
		
		if (count _pt_impact == 0) then
		{
			missionNamespace setVariable ["MEF_PG_13_OK", FALSE];
		};

		//check direction
		_pg_data_ok = missionNamespace getVariable ["MEF_PG_13_OK", TRUE];
		
		if (_pg_data_ok) then
		{	
			//init variables
			_lateral_shift = 0;
			_range_shift = 0;
			_shift_dir = 360;
			_adjustment_tx = "";
			
			//save entered data
			_tgt_dir_tx = ctrlText _tgt_dir_ctrl;		
			missionNamespace setVariable ["MEF_MAGIC_OT_DIR", _tgt_dir_tx];
			_tgt_dir = (parseNumber _tgt_dir_tx);			

			_dir_units = missionNamespace getVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];  //0=mils 1=degrees
			missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_PRE", _dir_units];	
			
			_adj_left_ctrl = _display displayCtrl IDC_PG_13_LEFT_EDIT;
			_adj_left = ctrlText _adj_left_ctrl;	
			missionNamespace setVariable ["MEF_MAGIC_ADJ_LEFT", _adj_left];	

			_adj_right_ctrl = _display displayCtrl IDC_PG_13_RIGHT_EDIT;
			_adj_right = ctrlText _adj_right_ctrl;	
			missionNamespace setVariable ["MEF_MAGIC_ADJ_RIGHT", _adj_right];	
			
			_adj_add_ctrl = _display displayCtrl IDC_PG_13_ADD_EDIT;
			_adj_add = ctrlText _adj_add_ctrl;	
			missionNamespace setVariable ["MEF_MAGIC_ADJ_ADD", _adj_add];	
			
			_adj_drop_ctrl = _display displayCtrl IDC_PG_13_DROP_EDIT;
			_adj_drop = ctrlText _adj_drop_ctrl;	
			missionNamespace setVariable ["MEF_MAGIC_ADJ_DROP", _adj_drop];	

			//dir is in mils, convert to degrees
			if (_dir_units == 0) then //0=mils 1=degrees
			{
				_tgt_dir = (parseNumber _tgt_dir_tx) / DEG_TO_MILS;  //degrees grid
			};			

			//dir is in degrees mag, convert to degrees grid
			if (_dir_units == 1) then
			{
				_tgt_dir = (parseNumber _tgt_dir_tx) - getDeclination;	//degrees grid
			};	
			
			//determine if the user entered left or right
			_left = parseNumber _adj_left;	
			_right = parseNumber _adj_right;
			
			//something was entered
			if (_left != _right) then
			{
				if (_left > _right) then
				{
					//left
					_lateral_shift = _left;
					_shift_dir = _tgt_dir+270;
					_adjustment_tx = format ["Left %1m ", _left];
				}
				else
				{
					//right
					_lateral_shift = _right;
					_shift_dir = _tgt_dir+90;
					_adjustment_tx = format ["Right %1m ", _right];
				};
			};
			
			//calculate point of impact with left or right shift
			_pt_impact = [_pt_impact,_lateral_shift,_shift_dir] call fn_vbs_relPos; 
			
			//determine if the user entered add or drop	
			_add = parseNumber _adj_add;
			_drop = parseNumber _adj_drop;
			
			//something was entered
			if (_add != _drop) then
			{
				if (_add > _drop) then
				{
					//add
					_range_shift = _add;
					_shift_dir = _tgt_dir;
					_adjustment_tx = format ["%1Add %2m", _adjustment_tx, _add];
				}
				else
				{
					//drop
					_range_shift = _drop;
					_shift_dir = _tgt_dir+180;
					_adjustment_tx = format ["%1Drop %2m", _adjustment_tx, _drop];
				};
			};
			
			//calculate point of impact with left/right and add or drop
			_pt_impact = [_pt_impact,_range_shift,_shift_dir] call fn_vbs_relPos; 
			missionNamespace setVariable ["MEF_MAGIC_IMPACT_POINT", _pt_impact];
			
			//calculate aimpoints
			_aimPoint_array = call fn_magic_find_aimPoints;
			missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array]; //aimpoints for each gun
			missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE];  //flag to stop coloring ECR markers

			//convert impact grid from game pos to mgrs array
			_fullmgrs = _pt_impact call fn_magic_posToCoord;

			//_mgrs_array = [_zone_sqID, _mgrs] call fn_magic_check_mgrs_format;
			_mgrs_array = _fullmgrs call fn_magic_check_mgrs_format;

			//save the target location
			_tgt_zone = _mgrs_array select 0;
			_tgt_sqID = _mgrs_array select 1;
			_tgt_north = _mgrs_array select 2;
			_tgt_east = _mgrs_array select 3;
			
			missionNamespace setVariable ["MEF_MAGIC_MSN_TYPE", "(Replot)"];
			missionNamespace setVariable ["MEF_MAGIC_TGT_ZONE", _tgt_zone];
			missionNamespace setVariable ["MEF_MAGIC_TGT_SQID", _tgt_sqID];
			missionNamespace setVariable ["MEF_MAGIC_TGT_NORTH", _tgt_north];
			missionNamespace setVariable ["MEF_MAGIC_TGT_EAST", _tgt_east];
			
			//button on main page for target location
			_tgt_loc_ctrl = _display displayCtrl IDC_MAIN_TGT_LOC_BUTTON; 
			_tgt_loc_ctrl ctrlSetText format ["(Replot) %1 %2 %3 %4", _tgt_zone, _tgt_sqID, _tgt_north, _tgt_east];
			
			//display OT direction
			[_dir_units, _tgt_dir_tx] call fn_magic_display_OT_dir;
			
			//update adjustments button
			_adjustment_ctrl = _display displayCtrl IDC_MAIN_ADJUST_BUTTON; 
			
			if (_adjustment_tx != "")then
			{
				_adjustment_ctrl ctrlSetText _adjustment_tx;
			};

			[["PG_13"], TRUE] call fn_magic_hide_page;
			
			//Do not draw new marker
			missionNamespace setVariable ["MEF_MAGIC_DRAW_TGT", FALSE];
		}
		else
		{
			//show error message
			[-1,5000] diagMessage "Bad initial target location or direction";
			missionNamespace setVariable ["MEF_PG_13_OK", TRUE];
		};		
	};		

	default
	{

	};
};








