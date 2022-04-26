
//find all saved data and generate artillery strike
//this script runs until all rounds are fired or msn is stopped
//marker colors are executed here

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//passed array  [_row_new, _next_tgt_num,_aimPoint_array, _guns_idx, _rds_idx, _interval, _shell_class, _delay, _shell_type]

_row = _this select 0;
_msn_tgt_num = _this select 1;
_aimPoint_array = _this select 2;
_guns_idx = _this select 3;
_rds_idx = _this select 4;
_interval = _this select 5;
_shell_name = _this select 6; 
_delay = _this select 7;
_shell_type = _this select 8;
_fuseType = _this select 9;
_fuseParam =  _this select 10;

//impact radius
_impact_PE = missionNamespace getVariable ["ARMNIT_PROBABLE_ERROR", 1];

_script_dStart = random 1; //script delay before start

_waitTime = 0;

if (_rds_idx != 0) then
{
	//loop for each volley
	for "_i" from 1 to _rds_idx do
	{
		_startTime = time;

		//select the correct wait time 
		if (_i == 1) then
		{
			//initial round, this is the delay before start
			_waitTime = _delay;
		}
		else
		{
			//subsequent rounds, use interval
			_waitTime = _interval;
		};
		
		//first volley
		waitUntil
		{
			//flags to control marker colors must meet the following:
			//msn is active
			//passed row and selected advTree row number match
			//color markers = TRUE
			
			_row_sel = missionNamespace getVariable ["MEF_MAGIC_TREE_ROW_SEL", -1];	//row from adv tree
			_msn_tgt_num_sel = missionNamespace getVariable ["MEF_MAGIC_MSN_TGT_NUM", -1];	//tgt number
			_active = call compile format ["missionNamespace getVariable ['MEF_MAGIC_ACTIVE_MSN_%1', FALSE]", _msn_tgt_num_sel];
			_color_markers = missionNamespace getVariable ["MEF_MAGIC_COLOR_ECR_MARKERS", FALSE]; 
			
			//color ECR markers
			if
			(
				_msn_tgt_num == _msn_tgt_num_sel &&
				_active &&
				_color_markers
			)			
			then
			{
				[_guns_idx, _startTime, _waitTime] call fn_magic_color_ECR;
			};
			
			//wait till delay is done (start time + delay start)
			time > (_startTime+_waitTime)
		};

		//check if msn is still active
		_active = call compile format ["missionNamespace getVariable ['MEF_MAGIC_ACTIVE_MSN_%1', FALSE]", _msn_tgt_num];
		
		if (_active) then
		{
			//loop to create artillery strike at each aimpoint
			{
				_impact_pt = _x;

				if ("dpicm" in _shell_name) then
				{
					//from mission sqf file, for DPICM (old system)
					_artillery_0 = ["_artillery_0", _impact_pt, _shell_name, MEF_MAGIC_SCRIPT_RDS, MEF_MAGIC_SCRIPT_GUNS, _impact_PE, MEF_MAGIC_SCRIPT_DGUNS, MEF_MAGIC_SCRIPT_RELOAD, _script_dStart, objNull, "", [], "true", "", 270] call fn_vbs_editor_artillery_create;
				}
				else
				{
					//new modular artillery system
					//can be used for air bursts
					//_modular_artillery_strike_2  = ["_modular_artillery_strike_2", _impact_pt, [], ["true", "false", "true", "false"], _shell_type, _shell_name, _fuseType, _fuseParam, _impact_PE, MEF_MAGIC_SCRIPT_RDS, MEF_MAGIC_SCRIPT_RELOAD, MEF_MAGIC_SCRIPT_GUNS, MEF_MAGIC_SCRIPT_DGUNS, _script_dStart] call fn_vbs_createMAS;
					
					// Call fn_vbs_artilleryStrike with alt syntax

					_veh = "vbs2_ScriptLogic_MAS" createVehicle _impact_pt;
					
					[_impact_pt, _shell_name, _fuseType, _fuseParam, _impact_PE, MEF_MAGIC_SCRIPT_RDS, MEF_MAGIC_SCRIPT_RELOAD, MEF_MAGIC_SCRIPT_GUNS, MEF_MAGIC_SCRIPT_DGUNS, _script_dStart, _veh] call fn_vbs_artilleryStrike;

				};
			} forEach _aimPoint_array;
		}
		else
		{
			//End of Msn, end of mission, stop loop
			_i = 999;
			call compile format ["missionNamespace setVariable ['MEF_MAGIC_ACTIVE_MSN_%1', FALSE]", _msn_tgt_num];
		};
	};
};

//rounds complete, mission is no longer active
call compile format ["missionNamespace setVariable ['MEF_MAGIC_ACTIVE_MSN_%1', FALSE]", _msn_tgt_num];

[_guns_idx, _startTime, _interval] call fn_magic_color_ECR; 




