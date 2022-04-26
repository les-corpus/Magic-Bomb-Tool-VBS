//initialize GUI and drop down menus

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//development variables
#ifdef MEF_MAGIC_BOMB_USE_MISSION_SCRIPTS
_projectDataFolder = "P:\vbs2\customer\other\mef_magic_bomb_tool\data\";
#else
_projectDataFolder = "\vbs2\customer\other\mef_magic_bomb_tool\data\";
#endif

//load function library
if (isNil "LOAD_FN_LIBRARY") then
{
	_library = [] execVM (_projectDataFolder + "scripts\mef_magic_bomb_fn_library.sqf");
	
	waitUntil {scriptDone _library};
	
	LOAD_FN_LIBRARY = FALSE;
};

//get display name for other scripts
MEF_MAGIC_BOMB_TOOL = _this select 0;
_display = MEF_MAGIC_BOMB_TOOL;

//list controls
//main GUI
_disable_gui_ctrl = _display displayCtrl IDC_MAIN_DISABLE_GUI_BUTTON;
_observer_ctrl = _display displayCtrl IDC_MAIN_OBSERVER_COMBO;
_firingUnit_ctrl = _display displayCtrl IDC_MAIN_FIRE_COMBO;
_tgt_loc_ctrl = _display displayCtrl IDC_MAIN_TGT_LOC_BUTTON; 
_engagement_ctrl = _display displayCtrl IDC_MAIN_ENGAGEMENT_BUTTON; 
_sheaf_btn = _display displayCtrl IDC_MAIN_SHEAF_BUTTON; 
_adjustment_ctrl = _display displayCtrl IDC_MAIN_ADJUST_BUTTON; 
_adj_tree_ctrl = _display displayCtrl IDC_MAIN_ADJUSTMENTS_TREE;

_obs_data_ctrl = _display displayCtrl IDC_MAIN_OTL_DATA;
_gtl_data_ctrl = _display displayCtrl IDC_MAIN_GTL_DATA;

//page 05, guns, rounds, shell, and interval
_guns_ctrl = _display displayCtrl IDC_PG_05_GUNS_COMBO;
_rounds_ctrl = _display displayCtrl IDC_PG_05_ROUNDS_COMBO;
_shell_ctrl = _display displayCtrl IDC_PG_05_SHELL_COMBO;
_interval_ctrl = _display displayCtrl IDC_PG_05_INTERVAL_COMBO;

//page 07, sheaf, rectangle
_length_07_ctrl = _display displayCtrl IDC_PG_07_LENGTH_COMBO;
_width_07_ctrl = _display displayCtrl IDC_PG_07_WIDTH_COMBO;

//page 08, sheaf, linear
_length_08_ctrl = _display displayCtrl IDC_PG_08_LENGTH_COMBO;

//page 10 type of fire control
_fire_15_ctrl = _display displayCtrl IDC_PG_15_TYPE_COMBO;
_sec_10_ctrl = _display displayCtrl IDC_PG_10_SEC_COMBO;

//page 11 method, seconds
_sec_11_ctrl = _display displayCtrl IDC_PG_11_SEC_COMBO;

//page 14 sheaf
_sheaf_ctrl = _display displayCtrl IDC_PG_14_TYPE_COMBO;

//observer direction
_OT_dir_ctrl = _display displayCtrl IDC_MAIN_OBS_DIR_BUTTON;	

//2D map
_map = _display displayCtrl IDC_MAIN_2D_MAP;

//hide all the controls except main GUI
_configs = "!('MAIN' in configName _x)" configClasses (configFile >> "MEF_MAGIC_BOMB_TOOL" >> "Controls");
{
	_idc = getNumber (configFile >> "MEF_MAGIC_BOMB_TOOL" >> "controls">> configName _x >> "idc");
	(_display displayCtrl _idc) ctrlShow FALSE;
}forEach _configs;

//flags to draw OTL and GTL on 2D map
MEF_MAGIC_DRAW_GTL = FALSE;
MEF_MAGIC_DRAW_OTL = FALSE;

//flags to update moving marker target location
MEF_MAGIC_MAP_BUTTON_DOWN = FALSE;
MEF_MAGIC_ENABLE_MOVING_TGT_LOC = FALSE;


//hide OTL and GTL data on 2D map
{_x ctrlShow FALSE} forEach [_obs_data_ctrl, _gtl_data_ctrl];

//get basic saved variables
//mission type
_msn_type = missionNamespace getVariable ["MEF_MAGIC_MSN_TYPE", ""];

//method of engagement
_idx_num_guns = missionNamespace getVariable ["MEF_MAGIC_NUM_GUNS", MEF_MAGIC_DEFAULT_GUNS];	
_idx_num_rds = missionNamespace getVariable ["MEF_MAGIC_NUM_RDS", MEF_MAGIC_DEFAULT_RDS]; //0-12 rounds
_idx_shell_type = missionNamespace getVariable ["MEF_MAGIC_SHELL_TYPE", MEF_MAGIC_DEFAULT_SHELL];
_idx_interval = missionNamespace getVariable ["MEF_MAGIC_INTERVAL", MEF_MAGIC_DEFAULT_INT];  //1="15" sec
_idx_sheaf = missionNamespace getVariable ["MEF_MAGIC_SHEAF", MEF_MAGIC_DEFAULT_SHEAF];  //number


//observer direction
_dir_units = missionNamespace getVariable ["MEF_MAGIC_OT_UNITS_CUR", 0];  //0=mils 1=degrees
_tgt_dir_tx = missionNamespace getVariable ["MEF_MAGIC_OT_DIR", "6400"];

//determine if mils or degrees
_dir_tx = "mils grid";

if (_dir_units==1) then
{
	_dir_tx = "degs mag";
};

//update OT button
_output = format ["%1 %2", _tgt_dir_tx, _dir_tx];
_OT_dir_ctrl ctrlSetText _output;


//enable the main GUI
_disable_gui_ctrl ctrlShow FALSE;


//set probable error in range
//can be changed with script:
//missionNamespace setVariable ["ARMNIT_PROBABLE_ERROR", (15*3.3)]; 
//(15*3.3) = distance in feet

_impact_PE = missionNamespace getVariable ["ARMNIT_PROBABLE_ERROR", nil];

if (isNil "_impact_PE") then
{
	missionNamespace setVariable ["ARMNIT_PROBABLE_ERROR", (10*3.3)];  //10m
};


//populate all the combo boxes
//main page
_observer_list3 = [];
_firingUnit_list2 = [];


//find any observer markers and populate combo box
_observer_list_array = call fn_magic_find_obs_markers;

//get marker descriptions
{
	_marker_name = markerText _x;
	_observer_list3 = _observer_list3 + [_marker_name];  
} forEach _observer_list_array;

_observer_list3 = _observer_list3  call fn_vbs_sortStrings;

{_observer_ctrl lbAdd _x; }forEach ["Obs (Optional)"]+_observer_list3;
_observer_ctrl lbSetCurSel 0;


//find any firing unit markers and populate combo box
_firingUnit_list_array = call fn_magic_find_fire_unit_markers;

//get marker descriptions
{
	_marker_name = markerText _x;
	_firingUnit_list2 = _firingUnit_list2 + [_marker_name];  
} forEach _firingUnit_list_array;

_firingUnit_list2 = _firingUnit_list2 call fn_vbs_sortStrings;

{_firingUnit_ctrl lbAdd _x;} forEach ["Unit (Optional)"] + _firingUnit_list2;
_firingUnit_ctrl lbSetCurSel 0;


//add number of guns and rounds
for "_i" from 1 to 8 do
{
	_guns_ctrl lbAdd str _i;
};

for "_i" from 0 to 12 do
{
	_rounds_ctrl lbAdd str _i;
};


//add shells and intervals
{_shell_ctrl lbAdd _x} forEach MEF_MAGIC_SHELL;
{_interval_ctrl lbAdd _x} forEach MEF_MAGIC_INTERVAL;


//page 07, sheaf, rectangle
{_length_07_ctrl lbAdd _x} forEach MEF_MAGIC_RECT_LENGTH;
{_width_07_ctrl lbAdd _x} forEach MEF_MAGIC_WIDTH;


//page 08, sheaf, linear
{_length_08_ctrl lbAdd _x} forEach MEF_MAGIC_LINE_LENGTH;


//page 10 type of fire control
{_fire_15_ctrl lbAdd _x} forEach MEF_MAGIC_CONTROL;
{_sec_10_ctrl lbAdd _x} forEach MEF_MAGIC_CONTROL_DELAY;


//page 11 control, sec
{_sec_11_ctrl lbAdd _x} forEach MEF_MAGIC_CONTROL_SEC;


//page 14 sheaf
{_sheaf_ctrl lbAdd _x} forEach MEF_MAGIC_SHEAF;


//initialize target location
if (_msn_type != "") then
{
	//saved msn data
	_tgt_zone = missionNamespace getVariable ["MEF_MAGIC_TGT_ZONE", "24S"];
	_tgt_sqid = missionNamespace getVariable ["MEF_MAGIC_TGT_SQID", "VJ"];
	_tgt_north = missionNamespace getVariable ["MEF_MAGIC_TGT_NORTH", "02500"];
	_tgt_east = missionNamespace getVariable ["MEF_MAGIC_TGT_EAST", "82600"];
	
	//display saved data
	_tgt_loc_ctrl ctrlSetText format ["%1 %2 %3 %4 %5", _msn_type, _tgt_zone, _tgt_sqid, _tgt_north, _tgt_east];
}
else
{
	//nothing saved, calculate center of map
	_mapSize = (mapProperties select 3)*(mapProperties select 5);
	_mapCenter = [_mapSize/2, _mapSize/2];
	
	//calculate full mgrs
	_fullmgrs = _mapCenter call fn_magic_posToCoord;

	//convert full mgrs into an array
	_mgrs_array = _fullmgrs call fn_magic_check_mgrs_format;

	//output results
	_tgt_zone = _mgrs_array select 0;
	_tgt_sqid = _mgrs_array select 1;
	_tgt_north = _mgrs_array select 2;
	_tgt_east = _mgrs_array select 3;
	
	_tgt_loc_ctrl ctrlSetText format ["(Grid) %1 %2 %3 %4", _tgt_zone, _tgt_sqid, _tgt_north, _tgt_east];	
};


//check if engagement data was saved
_engagement_ctrl ctrlSetText "Method of Engagement (Optional)";

//check if player selected something different for method of engagement
if 
(
	_idx_num_guns != 0 ||
	_idx_num_rds != 1 ||
	_idx_shell_type != 5 ||
	_idx_interval != MEF_MAGIC_DEFAULT_INT  //1 = "15" sec
)
then
{
	//not default setting, display update
	_num_guns = _idx_num_guns+1;
	_num_rds = 	_idx_num_rds;
	_shell_type = MEF_MAGIC_SHELL select _idx_shell_type;
	_interval = MEF_MAGIC_INTERVAL select _idx_interval;  //string 1 = "15" sec
	
	_engagement_ctrl ctrlSetText format ["%1 Guns, %2 Rds, Shell %3, Int %4 sec",_num_guns, _num_rds, _shell_type, _interval];
};


//initialize sheaf
_sheaf_btn ctrlSetText "Sheaf (Optional)";

if (_idx_sheaf != 1) then
{	
	switch (_idx_sheaf) do
	{
		case 0:
		{
			//circle 
			_radius_str = missionNamespace getVariable ["MEF_MAGIC_RADIUS", "100"];	
			_sheaf_btn ctrlSetText format ["Circular Sheaf, Radius %1 meters", _radius_str];
		};
		case 2:
		{
			//linear 
			_line_len = missionNamespace getVariable ["MEF_MAGIC_LINE_LEN", "300"];	
			_line_att = missionNamespace getVariable ["MEF_MAGIC_LINE_ATT", "6400"];
			_dir_units = missionNamespace getVariable ["MEF_MAGIC_LINE_ATT_UNITS_PRE", 0];  //0=mils 1=degrees
			_dir_units_tx = "mils grid";
		
			if (_dir_units == 1) then
			{
				_dir_units_tx = "degs mag";
			};
		
			_sheaf_btn ctrlSetText format ["Linear Sheaf, Length %1 meters, Attitude %2 %3", _line_len, _line_att, _dir_units_tx];
		};
		case 3:
		{
			//open 
			_sheaf_btn ctrlSetText "Open Sheaf";
		};
		case 4:
		{
			//Parallel 
			_sheaf_btn ctrlSetText "Parallel Sheaf";
		};
		case 5:
		{
			//rectangle 

			_rect_len = missionNamespace getVariable ["MEF_MAGIC_RECT_LEN", "300"];
			_rect_wid = missionNamespace getVariable ["MEF_MAGIC_RECT_WID", "100"];
			_rect_att = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT", "6400"];  //string	
			_dir_units = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT_UNITS_PRE", 0];	
			_dir_units_tx = "mils grid";
			
			if (_dir_units == 1) then
			{
				_dir_units_tx = "degs mag";
			};
			
			_sheaf_btn ctrlSetText format ["Rectangular Sheaf, L %1m, W %2m, Att %3 %4 ", _rect_len, _rect_wid, _rect_att, _dir_units_tx];
		};
	};
};


//run script to draw on 2D map
_map ctrlSetEventHandler ["draw","(_this select 0) call fn_magic_update_map"];

//place watch based on screen resolution
[_display] call fn_magic_position_watch;


//check for prior fire missions
_msn_array_master = missionNamespace getVariable ["MEF_MAGIC_MSN_ARRAY_MASTER", []]; 
_count = count _msn_array_master;

if (_count > 0) then
{
	for "_i" from 0 to _count-1 do
	{
		_msn_array = _msn_array_master select _i;
		
		//arrays within msn array
		_tgt_number = _msn_array select 0;
		_tree_array = _msn_array select 1; //[group, element]
		_mgrs_array = _msn_array select 2;
		
		_tgt_number_str = [_tgt_number] call fn_magic_generate_tgt_num;
		
		//adv tree info
		_group = _tree_array select 0;
		_element = _tree_array select 1;

		//mgrs tgt location
		_msn = _mgrs_array select 0;
		_zone = _mgrs_array select 1; 
		_sqID = _mgrs_array select 2; 
		_north = _mgrs_array select 3; 
		_east = _mgrs_array select 4; 

		//add new groups
		if (_element == 0) then		
		{
			_treeOutput = format ["TGT_%1: %2 %3 %4 %5 %6", _tgt_number_str, _msn, _zone, _sqID, _north, _east];
		
			_group = _adj_tree_ctrl advTreeAdd [0,[_treeOutput]];  //returns row number??
	
			_adj_tree_ctrl advTreeSetValue [_group, _tgt_number];
		};
		
		//add elements under group
		if (_element == -1) then	//-1 = element, 0 = group
		{
			_treeOutput = format ["%1 %2 %3 %4", _zone, _sqID, _north, _east];
			
			_trunk = _adj_tree_ctrl advTreeAdd [_group,[_treeOutput]];
			
			_adj_tree_ctrl advTreeSetValue [_trunk, _tgt_number];
			
			_adj_tree_ctrl advTreeExpand _group;
		};		
	};
}
else
{
	//no missions saved, disable adjustments button
	_adjustment_ctrl ctrlEnable false;
};

//onload, set selected row
missionNamespace setVariable ["MEF_MAGIC_TREE_ROW_SEL", 1];

//run script to update data for map
MEF_MAGIC_UPDATE_MAP = [] execVM (_projectDataFolder + "scripts\mef_magic_bomb_update_map_data.sqf");







