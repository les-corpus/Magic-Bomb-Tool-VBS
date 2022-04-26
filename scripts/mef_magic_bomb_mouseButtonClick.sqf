

//single click on adv tree
//updates ctrls to display selected msn data from adv tree

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//passed data: [ctrl, row, column]

_row = _this select 1;

//init variables
_display = MEF_MAGIC_BOMB_TOOL;

_tgt_loc_ctrl = _display displayCtrl IDC_MAIN_TGT_LOC_BUTTON; 
_engagement_ctrl = _display displayCtrl IDC_MAIN_ENGAGEMENT_BUTTON; 
_sheaf_btn = _display displayCtrl IDC_MAIN_SHEAF_BUTTON; 
_method_btn = _display displayCtrl IDC_MAIN_METHOD_BUTTON; 
_adj_tree_ctrl = _display displayCtrl IDC_MAIN_ADJUSTMENTS_TREE;

//get selected row target number
_msn_tgt_num = (_adj_tree_ctrl advTreeValue _row) select 0;

//save data
missionNamespace setVariable ["MEF_MAGIC_MSN_TGT_NUM", _msn_tgt_num];
missionNamespace setVariable ["MEF_MAGIC_TREE_ROW_SEL", _row];

//get saved values
_msn_active = call compile format ["missionNamespace getVariable ['MEF_MAGIC_ACTIVE_MSN_%1', FALSE]", _msn_tgt_num];
_msn_array_master = missionNamespace getVariable ["MEF_MAGIC_MSN_ARRAY_MASTER", []]; 

//find the target number and msn data in the array of saved missions 
_count = count _msn_array_master;
_msn_array = [];

if (_count > 0) then
{
	//search array of missions for selected tgt number
	for "_i" from 0 to _count -1 do
	{
		_check_msn_array = _msn_array_master select _i;
		_check_tgt_number = _check_msn_array select 0;
		
		//tgt number found, stop searching
		if (_check_tgt_number == _msn_tgt_num) then
		{
			_msn_array = _check_msn_array;
			_i = 9999;
		};
	};
};

//saved msn data
_tree_array = _msn_array select 1;	//[group, element]
_mgrs_array = _msn_array select 2;	//[_msn, _zone, _sqID, _north, _east]
_tgt_loc  = _msn_array select 3;	//[game X, game Y]
_dir_array = _msn_array select 4;	//[_dir, _dir_idx]
_engage_array = _msn_array select 5;	//[_guns_idx, _rds_idx, _shell_idx, _interval_idx]
_sheaf_array = _msn_array select 6; 	//[_sheaf_idx, sheaf parameters]
_control_array = _msn_array select 7;	//[_control_type,_delay_tx]
_saved_tgt = _msn_array select 8;	//saved target, marker description

_group = _tree_array select 0;

_msn = _mgrs_array select 0;
_zone = _mgrs_array select 1; 
_sqID = _mgrs_array select 2; 
_north = _mgrs_array select 3; 
_east = _mgrs_array select 4; 

_dir = _dir_array select 0;
_dir_idx = _dir_array select 1;

_guns_idx = _engage_array select 0;
_rds_idx = _engage_array select 1;
_shell_idx = _engage_array select 2;
_interval_idx = _engage_array select 3;

_sheaf_idx = _sheaf_array select 0;

_control_type = _control_array select 0;
_control_time = _control_array select 1;

//display saved data on main page
//target location button
_tgt_loc_ctrl ctrlSetText format ["%1 %2 %3 %4 %5", _msn, _zone, _sqID, _north, _east];

//method of engagement: guns, rds, shell
_engagement_ctrl ctrlSetText "Method of Engagement (Optional)";	

if 
(
	_guns_idx != 0 ||
	_rds_idx != 1 ||
	_shell_idx != 5 ||
	_interval_idx != MEF_MAGIC_DEFAULT_INT
)
then
{
	//not default setting, display update
	_num_guns = _guns_idx+1;
	_num_rds = _rds_idx;
	_shell_type = MEF_MAGIC_SHELL select _shell_idx;
	_interval = MEF_MAGIC_INTERVAL select _interval_idx;  //string 1 = "15" sec
	_engagement_ctrl ctrlSetText format ["%1 Guns, %2 Rds, Shell %3, Int %4 sec",_num_guns, _num_rds, _shell_type, _interval];
};

//initialize sheaf
_sheaf_btn ctrlSetText "Sheaf (Optional)";
if (_sheaf_idx != 1) then
{	
	switch (_sheaf_idx) do
	{
		case 0:
		{
			_radius_str = _sheaf_array select 1;			
			_sheaf_btn ctrlSetText format ["Circular Sheaf, Radius %1 meters", _radius_str];
		};
		case 1:
		{
			//converged 
		};
		case 2:
		{
			//linear 
			//[_sheaf_idx,_line_len, _line_att, _line_att_idx]
			
			_line_len = _sheaf_array select 1;
			_line_att = _sheaf_array select 2;
			_dir_units = _sheaf_array select 3;  //0=mils 1=degrees
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
			//[_sheaf_idx,_rect_len, _rect_wid, _rect_att, _rect_att_idx]
			_rect_len = _sheaf_array select 1;
			_rect_wid = _sheaf_array select 2;
			_rect_att = _sheaf_array select 3;	
			_dir_units = _sheaf_array select 4;	//0=mils 1=degrees
			_dir_units_tx = "mils grid";
			
			if (_dir_units == 1) then
			{
				_dir_units_tx = "degs mag";
			};
			
			_sheaf_btn ctrlSetText format ["Rectangular Sheaf, L %1m, W %2m, Att %3 %4 ", _rect_len, _rect_wid, _rect_att, _dir_units_tx];
		};
	};
};

//update method of fire control
if 
(
	_control_type != "Delay" ||
	_control_time != "5" 
)
then
{
	switch (_control_type) do
	{
		case "Delay":
		{
			//initialize delay time
			missionNamespace setVariable ["MEF_MAGIC_CONTROL_TYPE", _control_type];	//delay
			missionNamespace setVariable ["MEF_MAGIC_CONTROL_DELAY", _control_time];
		
			//update method of Fire Control button
			_method_btn ctrlSetText format ["%1 sec, Delay",_control_time];
		};
		case "Time on Tgt":
		{
			//initialize time on target
			_control_hr = _control_array select 1;
			_control_min = _control_array select 2;
			_control_sec = _control_array select 3;
			
			missionNamespace setVariable ["MEF_MAGIC_CONTROL_TYPE", _control_type];	//time on tgt
			missionNamespace setVariable ["MEF_MAGIC_CONTROL_HR", _control_hr];	//24 hour clock
			missionNamespace setVariable ["MEF_MAGIC_CONTROL_MIN", _control_min];		//0-60 min
			missionNamespace setVariable ["MEF_MAGIC_CONTROL_SEC", _control_sec];		//0,15,30,45
			
			//update method of Fire Control button
			_method_btn ctrlSetText format ["Time on Tgt, %1:%2:%3", _control_hr, _control_min, _control_sec];
		};
	};
}
else
{
	//reset variables
	missionNamespace setVariable ["MEF_MAGIC_CONTROL_TYPE", "Delay"];	//delay
	missionNamespace setVariable ["MEF_MAGIC_CONTROL_DELAY", "5"]; //default "5" sec
	_method_btn ctrlSetText "Method of Fire Control (Optional)";
};


//observer direction button
[_dir_idx, _dir] call fn_magic_display_OT_dir;

//save data to named variables
//msn type and mgrs grid
missionNamespace setVariable ["MEF_MAGIC_MSN_TYPE", _msn]; //(grid), (polar), (shift ab####), (ab####)
missionNamespace setVariable ["MEF_MAGIC_TGT_ZONE", _zone];	//"11S"
missionNamespace setVariable ["MEF_MAGIC_TGT_SQID", _sqID];	//"MS"
missionNamespace setVariable ["MEF_MAGIC_TGT_NORTH", _north];	//"12345"
missionNamespace setVariable ["MEF_MAGIC_TGT_EAST", _east];	//"67890"

missionNamespace setVariable ["MEF_MAGIC_IMPACT_POINT", _tgt_loc];  //init impact point

//saved target
missionNamespace setVariable ["MEF_MAGIC_SAVED_TGT", _saved_tgt];  //this is the marker name

//OT directions, save to both current and previous 
missionNamespace setVariable ["MEF_MAGIC_OT_DIR", _dir]; 	//string dir "6400"
missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_CUR", _dir_idx]; //0=mils 1=degrees
missionNamespace setVariable ["MEF_MAGIC_OT_UNITS_PRE", _dir_idx]; //0=mils 1=degrees

//guns, rds, and shell
missionNamespace setVariable ["MEF_MAGIC_NUM_GUNS", _guns_idx];	//0 = 1 gun
missionNamespace setVariable ["MEF_MAGIC_NUM_RDS", _rds_idx];	//0=1 rd
missionNamespace setVariable ["MEF_MAGIC_SHELL_TYPE", _shell_idx];  //5 = 155 HE
missionNamespace setVariable ["MEF_MAGIC_INTERVAL", _interval_idx];  //1 = "15" sec

//shell data
_shell_data = _shell_idx call fn_magic_find_shell_data;
missionNamespace setVariable ["MEF_MAGIC_SHELL_DATA", _shell_data];	

//sheaf type
missionNamespace setVariable ["MEF_MAGIC_SHEAF", _sheaf_idx];  //idx number		

//sheaf specific data
switch(_sheaf_idx) do
{
	case 0:  
	{
		//circle
		_radius = _sheaf_array select 1;
		missionNamespace setVariable ["MEF_MAGIC_RADIUS", _radius];	
	};
	case 1:  
	{
		//converged 
		_radius = "0";
		missionNamespace setVariable ["MEF_MAGIC_RADIUS", _radius];	
	};
	case 2:  
	{
		//line
		_len = _sheaf_array select 1;
		_att = _sheaf_array select 2;
		_att_units = _sheaf_array select 3;
		missionNamespace setVariable ["MEF_MAGIC_LINE_LEN", _len];
		missionNamespace setVariable ["MEF_MAGIC_LINE_ATT", _att];
		missionNamespace setVariable ["MEF_MAGIC_LINE_ATT_UNITS_CUR", _att_units];  //0=mils 1=degrees
	};
	case 3:  
	{
		//open

	};
	case 4:  
	{
		//parallel

	};					
	case 5:  
	{
		//rectangle
		_rect_len = _sheaf_array select 1;
		_rect_wid = _sheaf_array select 2;
		_rect_att = _sheaf_array select 3;
		_dir_units =  _sheaf_array select 4;
		
		missionNamespace getVariable ["MEF_MAGIC_RECT_LEN", _rect_len];
		missionNamespace getVariable ["MEF_MAGIC_RECT_WID", _rect_wid];
		missionNamespace getVariable ["MEF_MAGIC_RECT_ATT", _rect_att];
		missionNamespace getVariable ["MEF_MAGIC_RECT_ATT_UNITS_CUR", _dir_units];  //0=mils 1=degrees

	};
};

//calculate aimpoints
_aimPoint_array = call fn_magic_find_aimPoints;	//this calculates aimpoints and creates the ECR markers
missionNamespace setVariable ["MEF_MAGIC_AIMPOINT_ARRAY", _aimPoint_array]; //aimpoints for each gun

//reset adjustments button, tgt entered
_adjustment_ctrl = _display displayCtrl IDC_MAIN_ADJUST_BUTTON; 
_adjustment_ctrl ctrlSetText "Adjustments";

//if selected msn is active, color ECR markers
if (_msn_active) then
{
	//color ECR markers
	missionNamespace setVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", TRUE]; 
}
else
{
	//mission inactive, color aimPoint markers black
	for "_i" from 1 to (_guns_idx+1) do
	{
		call compile format ["ECR_%1 setmarkerColorLocal 'ColorBlack'",_i];
	};
};












