//mef_magic_create_fire_msn.sqf

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//development variables
#ifdef MEF_MAGIC_BOMB_USE_MISSION_SCRIPTS
_projectDataFolder = "P:\vbs2\customer\other\mef_magic_bomb_tool\data\";
#else
_projectDataFolder = "\vbs2\customer\other\mef_magic_bomb_tool\data\";
#endif

//display name
_display = MEF_MAGIC_BOMB_TOOL;

//check if msn data is good to create the mission
_tgt_loc = missionNamespace getVariable ["MEF_MAGIC_IMPACT_POINT", []];	//target location identified
_aimPoint_array = missionNamespace getVariable ["MEF_MAGIC_AIMPOINT_ARRAY", []];	 //aimpoints have been generated
_control_type = missionNamespace getVariable ["MEF_MAGIC_CONTROL_TYPE", "Delay"];	//time on tgt

_date_type = missionNamespace getVariable  ["MEF_MAGIC_TOGGLE_DTG",0]; //watch is displayed for TOT

//if user waited, check if TOT is good
_tot_array = [];
_tot_check = 0;

if (_control_type == "Time on Tgt") then
{
	//for TOT missions calculate time to impact
	_tot_array = call fn_magic_check_TOT; //returns [_tot_in_seconds, _hr, _min, _sec]
	_tot_check = _tot_array select 0;
};

//continue if critical data is good
_dataCheck = TRUE;

if (count _tgt_loc != 3) then
{
	//no target location
	_dataCheck = FALSE;
	[-1, 5000] diagMessage "No Initial Target Location Defined.";
};

if (count _aimPoint_array == 0) then
{
	//aimpoint array contains 0 elements
	_dataCheck = FALSE;
	[-1, 5000] diagMessage "Could Not Calculate Aimpoints. No Target Location.";
};

if(_tot_check < 0 || _date_type == 2) then
{
	//delay for time on target is less than zero
	_dataCheck = FALSE;
	
	[-1, 5000] diagMessage "Established Time On Target Has Passed or Watch Not Displayed";
};

if (_dataCheck) then
{
	//init variables
	_adj_tree_ctrl = _display displayCtrl IDC_MAIN_ADJUSTMENTS_TREE;
	_adjustment_ctrl = _display displayCtrl IDC_MAIN_ADJUST_BUTTON; 
	_map = _display displayCtrl IDC_MAIN_2D_MAP;

	_tree_array = [-1,-1];		//[group, element]
	
	//msn type and mgrs grid
	_msn = missionNamespace getVariable ["MEF_MAGIC_MSN_TYPE", "(Grid)"]; //(grid), (polar), (shift ab####), (ab####)
	_zone = missionNamespace getVariable ["MEF_MAGIC_TGT_ZONE", ""];	//"11S"
	_sqID = missionNamespace getVariable ["MEF_MAGIC_TGT_SQID", ""];	//"MS"
	_north = missionNamespace getVariable ["MEF_MAGIC_TGT_NORTH", ""];	//"12345"
	_east = missionNamespace getVariable ["MEF_MAGIC_TGT_EAST", ""];	//"67890"

	//get saved target
	_saved_tgt = missionNamespace getVariable ["MEF_MAGIC_SAVED_TGT", "(Optional)"];
	
	//OT directions
	_dir = missionNamespace getVariable ["MEF_MAGIC_OT_DIR", "6400"]; 	//"6400"
	_dir_idx = missionNamespace getVariable ["MEF_MAGIC_OT_UNITS_PRE", 0]; //0=mils 1=degrees

	//guns, rds, and shell
	_guns_idx = missionNamespace getVariable ["MEF_MAGIC_NUM_GUNS", MEF_MAGIC_DEFAULT_GUNS];	//0 = 1 gun
	_rds_idx = missionNamespace getVariable ["MEF_MAGIC_NUM_RDS", MEF_MAGIC_DEFAULT_RDS];	//0-12 rounds
	_shell_idx = missionNamespace getVariable ["MEF_MAGIC_SHELL_TYPE", MEF_MAGIC_DEFAULT_SHELL];  //5 = 155 HE
	_interval_idx = missionNamespace getVariable ["MEF_MAGIC_INTERVAL", MEF_MAGIC_DEFAULT_INT];  //1="15"sec
	
	//sheaf
	_sheaf_idx = missionNamespace getVariable ["MEF_MAGIC_SHEAF", MEF_MAGIC_DEFAULT_SHEAF];  //1 = converged	
	
	//method of fire control
	_control_type = missionNamespace getVariable ["MEF_MAGIC_CONTROL_TYPE", "Delay"];	//Delay or Time on Tgt

	//generate mission number and save
	//_next_tgt_num = missionNamespace getVariable ["MEF_MAGIC_NEXT_TGT_NUM", -1];  //0 to infinity
	_next_tgt_num = missionNamespace getVariable ["MEF_MAGIC_NEXT_TGT_NUM", 0];  //1 to infinity
	_next_tgt_num = _next_tgt_num + 1;
	missionNamespace setVariable ["MEF_MAGIC_NEXT_TGT_NUM", _next_tgt_num];

	//set current tgt number
	missionNamespace setVariable ["MEF_MAGIC_MSN_TGT_NUM", _next_tgt_num];

	//this contains all the data the user entered
	_msn_array_new = [_next_tgt_num, _tree_array, [_msn, _zone, _sqID, _north, _east], _tgt_loc, [_dir, _dir_idx], [_guns_idx, _rds_idx, _shell_idx, _interval_idx], [_sheaf_idx], [_control_type], _saved_tgt];

	
//initialize sheaf
	
	//update the sheaf array with current sheaf data (6th element in msn array)
	if (_sheaf_idx != 1) then
	{	
		switch (_sheaf_idx) do
		{
			case 0:
			{
				//circle 
				private ["_radius"];
				
				_radius = missionNamespace getVariable ["MEF_MAGIC_RADIUS", "100"];	
				
				_msn_array_new set [6, [_sheaf_idx,_radius]];
			};
			case 2:
			{
				//linear 
				private ["_line_len", "_line_att", "_line_att_idx"];
				
				_line_len = missionNamespace getVariable ["MEF_MAGIC_LINE_LEN", "300"];	
				_line_att = missionNamespace getVariable ["MEF_MAGIC_LINE_ATT", "6400"];
				_line_att_idx = missionNamespace getVariable ["MEF_MAGIC_LINE_ATT_UNITS_PRE", 0];  //0=mils 1=degrees
				
				_msn_array_new set [6, [_sheaf_idx,_line_len, _line_att, _line_att_idx]];

			};
			case 3:
			{
				//open 
			};
			case 4:
			{
				//Parallel 
			};
			case 5:
			{
				//rectangle 
				private ["_rect_len", "_rect_wid", "_rect_att", "_rect_att_idx"];
				
				_rect_len = missionNamespace getVariable ["MEF_MAGIC_RECT_LEN", "300"];
				_rect_wid = missionNamespace getVariable ["MEF_MAGIC_RECT_WID", "100"];
				_rect_att = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT", "6400"];  //string	
				_rect_att_idx = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT_UNITS_PRE", 0];	
				
				_msn_array_new set [6, [_sheaf_idx,_rect_len, _rect_wid, _rect_att, _rect_att_idx]];
			};
		};
	};	

	if ("Replot" in _msn) then
	{
		//replot / adjustment mission
		
		//get array of missions
		_msn_array_master = missionNamespace getVariable ["MEF_MAGIC_MSN_ARRAY_MASTER", []]; 
		
		//get last row selected
		_row_old = missionNamespace getVariable ["MEF_MAGIC_TREE_ROW_SEL", 1];

		//what is the tgt number of selected row
		_msn_tgt_num_old = (_adj_tree_ctrl advTreeValue _row_old) select 0;			
		
		//find mission data of selected row
		_msn_array_old = [];
		_count = count _msn_array_master;
		
		if (_count > 0) then
		{
			//search array of missions for selected tgt number
			for "_i" from 0 to _count -1 do
			{
				_check_msn_array = _msn_array_master select _i;
				_check_tgt_number = _check_msn_array select 0;
				
				//tgt number found, stop searching
				if (_check_tgt_number == _msn_tgt_num_old) then
				{
					_msn_array_old = _check_msn_array;
					_i = 9999;
				};
			};
		};
		
		//get group of the selected row
		_tree_array = _msn_array_old select 1;
		_group = _tree_array select 0;	//[group, element]
		_adj_tree_ctrl advTreeExpand _group;
		
		//add new element to group
		_treeOutput = format ["%1 %2 %3 %4", _zone, _sqID, _north, _east];
		
		_element = _adj_tree_ctrl advTreeAdd [_group,[_treeOutput]];  //returns row number
		
		_adj_tree_ctrl advTreeSetValue [_element, _next_tgt_num];	//add target number to new row
		
		//update mission data to place this msn in the correct group
		_msn_array_new set [1, [_group,-1]];  //[group, element] when element= -1, add to group

		//flag that mission is active
		call compile format ["missionNamespace setVariable ['MEF_MAGIC_ACTIVE_MSN_%1', TRUE]", _next_tgt_num];
		
		//update the current row selected
		missionNamespace setVariable ["MEF_MAGIC_TREE_ROW_SEL", _element];
	
	}
	else
	{
		//new missions
		//generate group and save value to row

		_tgt_number_str = [_next_tgt_num] call fn_magic_generate_tgt_num;
		
		_treeOutput = format ["TGT_%1: %2 %3 %4 %5 %6", _tgt_number_str, _msn, _zone, _sqID, _north, _east];
		
		_group = _adj_tree_ctrl advTreeAdd [0,[_treeOutput]];  //returns row number

		_adj_tree_ctrl advTreeSetValue [_group, _next_tgt_num];  //add target number to new row
		
		//update mission data to place this msn correct in the adv tree
		_msn_array_new set [1, [_group,0]];  //[group, element] when element= 0, new group
		
		//flag that mission is active
		call compile format ["missionNamespace setVariable ['MEF_MAGIC_ACTIVE_MSN_%1', TRUE]", _next_tgt_num];

		//update the current row selected
		missionNamespace setVariable ["MEF_MAGIC_TREE_ROW_SEL", _group];
		
		//create single target markers
		_createMarker = missionNamespace getVariable ["MEF_MAGIC_DRAW_TGT", TRUE];
		if (_createMarker) then
		{
			[_next_tgt_num, _tgt_loc] call fn_magic_create_single_target;

			//center on map 
			//_map ctrlMapAnimAdd [.5, .25, _tgt_loc];
			//ctrlMapAnimCommit _map;
		};
	};
	
	//find string for shell type
	_shell_data = _shell_idx call fn_magic_find_shell_data;  //returns [_shell_class, _shell_ECR, _shell_type, _fuseType, _fuseParam]
	_shell_class = _shell_data select 0;
	_shell_type = _shell_data select 2;
	_fuseType =  _shell_data select 3;
	_fuseParam = _shell_data select 4;
	
	//calculate the delay for fire mission
	//_interval = parseNumber _interval_idx;	//time between vollies

	_interval_tx = MEF_MAGIC_INTERVAL select _interval_idx;  //returns string
	_interval = parseNumber _interval_tx;
	
	//control type was define at top of script
	switch (_control_type) do
	{
		case "Delay":
		{
			//delay
			private ["_delay_tx", "_row_new", "_delay", "_fire_order"];
			
			//update msn array (element 7)
			_delay_tx = missionNamespace getVariable ["MEF_MAGIC_CONTROL_DELAY", "5"];  //5, 15,30,45,60
			_delay = (parseNumber _delay_tx)-2.5;  //account for spawn and impact of munition

			_msn_array_new set [7,[_control_type,_delay_tx]];
			
			//find the current row selected
			_row_new = missionNamespace getVariable ["MEF_MAGIC_TREE_ROW_SEL", -1];

			//send msn data to create magic bomb

			_fire_order = [_row_new, _next_tgt_num,_aimPoint_array, _guns_idx, _rds_idx, _interval, _shell_class, _delay, _shell_type, _fuseType, _fuseParam] execVM (_projectDataFolder + "scripts\mef_magic_bomb_delay_msn.sqf");
		};
		case "Time on Tgt":
		{
			//TOT
			private ["_tot_in_seconds","_hr_tx", "_min_tx", "_sec_tx",  "_row_new", "_fire_order"];
			
			_tot_in_seconds = (_tot_array select 0)-2.5; //account for spawn and impact of munition
			_hr_tx = _tot_array select 1;
			_min_tx = _tot_array select 2;
			_sec_tx = _tot_array select 3;
					
			_msn_array_new set [7,[_control_type, _hr_tx, _min_tx, _sec_tx]];
		
			//find current row selected
			_row_new = missionNamespace getVariable ["MEF_MAGIC_TREE_ROW_SEL", -1];
			
			//send msn data to create magic bomb

			_fire_order = [_row_new, _next_tgt_num,_aimPoint_array, _guns_idx, _rds_idx, _interval, _shell_class, _tot_in_seconds, _shell_type, _fuseType, _fuseParam] execVM (_projectDataFolder + "scripts\mef_magic_bomb_delay_msn.sqf");
		};
	};
	
	//enable adjustments button
	if (!ctrlEnabled _adjustment_ctrl) then
	{
		_adjustment_ctrl ctrlEnable TRUE;
	};
	
	//reset adjustments button, and reset adjustment edit boxes
	_adjustment_ctrl ctrlSetText "Adjustments";

	missionNamespace setVariable ["MEF_MAGIC_ADJ_LEFT", ""];	
	missionNamespace setVariable ["MEF_MAGIC_ADJ_RIGHT", ""];	
	missionNamespace setVariable ["MEF_MAGIC_ADJ_ADD", ""];		
	missionNamespace setVariable ["MEF_MAGIC_ADJ_DROP", ""];
	
	//turn on flags to color ECR markers
	MEF_MAGIC_MSN_IS_ACTIVE = TRUE;
	missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", TRUE]; 
	
	_control_array = _msn_array_new select 7;

	//save new mission to master msn array
	_msn_array_master = missionNamespace getVariable ["MEF_MAGIC_MSN_ARRAY_MASTER", []]; 
	_msn_array_master = _msn_array_master + [_msn_array_new];
	missionNamespace setVariable ["MEF_MAGIC_MSN_ARRAY_MASTER", _msn_array_master]; 	

};







