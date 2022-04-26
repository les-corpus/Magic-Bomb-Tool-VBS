//executes when user changes a drop down menu

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//get passed variables determine controls
_ctrl = _this select 0;
_idx = _this select 1;

_idc = ctrlIDC _ctrl;
_display = MEF_MAGIC_BOMB_TOOL;

switch (_idc) do
{
	case IDC_MAIN_OBSERVER_COMBO:
	{
		//main page observer
		private ["_obs_data_ctrl", "_idx_observer", "_observer_tx", "_saved_marker_info", "_observer_name", "_observer_pos", "_aimPoint_array"];
		
		//init varialbes
		_obs_data_ctrl = _display displayCtrl IDC_MAIN_OTL_DATA;
		
		//find idx of selected text
		_idx_observer = lbCurSel IDC_MAIN_OBSERVER_COMBO;
		_observer_tx = lbText [IDC_MAIN_OBSERVER_COMBO, _idx_observer];	
		
		if ("(Optional)" in _observer_tx) then
		{
			//no observer selected
			missionNamespace setVariable ["MEF_MAGIC_OBSERVER", ""]; 
		}
		else
		{
			//find marker info
			_saved_marker_info = [_observer_tx, "MEF_MAGIC_OBS_LIST"] call fn_magic_find_marker_info; //returns [_marker_name,_marker_pos]
		
			_observer_name = _saved_marker_info select 0;
			_observer_pos = _saved_marker_info select 1;

			//save selected firing unit marker
			missionNamespace setVariable ["MEF_MAGIC_OBSERVER", _observer_name]; 
		};
		
		//calculate aimpoints
		_aimPoint_array = call fn_magic_find_aimPoints;
	};
	case IDC_MAIN_FIRE_COMBO:
	{
		//main page firing unit
		private ["_tgt_data_ctrl", "_idx_fire_unit", "_fire_unit_tx", "_saved_marker_info", "_fire_unit_name", "_fire_unit_pos", "_aimPoint_array"];
		
		//init variables
		_tgt_data_ctrl = _display displayCtrl IDC_MAIN_GTL_DATA;		
		
		//find idx of selected text
		_idx_fire_unit = lbCurSel IDC_MAIN_FIRE_COMBO;
		_fire_unit_tx = lbText [IDC_MAIN_FIRE_COMBO, _idx_fire_unit];	
		
		if ("(Optional)" in _fire_unit_tx) then
		{
			//no firing unit selected
			missionNamespace setVariable ["MEF_MAGIC_FIRING_UNIT", ""]; 
		}
		else
		{
			//find marker info
			_saved_marker_info = [_fire_unit_tx, "MEF_MAGIC_FIRE_LIST"] call fn_magic_find_marker_info; //returns [_marker_name,_marker_pos]
		
			_fire_unit_name = _saved_marker_info select 0;
			_fire_unit_pos = _saved_marker_info select 1;

			//save selected firing unit marker
			missionNamespace setVariable ["MEF_MAGIC_FIRING_UNIT", _fire_unit_name]; 

		};
		
		//calculate aimpoints
		_aimPoint_array = call fn_magic_find_aimPoints;
		
	};
	case IDC_PG_01_SAVED_COMBO:
	{
		//saved target 
	};
	case IDC_PG_04_SAVED_COMBO:
	{
		//saved target
	};
	
	case IDC_PG_05_GUNS_COMBO:
	{
		//number of guns
	};
	
	case IDC_PG_14_TYPE_COMBO:
	{
		//sheaf
		
		//determine what sheaf was selected
		switch (_idx) do
		{
			case 0:
			{
				//sheaf circle
				private ["_radius", "_radius_ctrl"];
				
				[["PG_06","PG_07","PG_08"], FALSE] call fn_magic_hide_page;
				[["PG_09"], TRUE] call fn_magic_load_page;

				//find radius
				_radius = missionNamespace getVariable ["MEF_MAGIC_RADIUS", "100"];
				
				//force radius if initial is 0m
				if (_radius == "0") then
				{
					_radius = "100";
				};
				
				_radius_ctrl = _display displayCtrl IDC_PG_09_RADIUS_EDIT;
				_radius_ctrl ctrlSetText _radius;		
				
				//set focus
				ctrlSetFocus (_display displayCtrl IDC_PG_09_RADIUS_EDIT);
			};
			case 1:
			{
				//sheaf converged
				[["PG_07","PG_08","PG_09"], FALSE] call fn_magic_hide_page;
				[["PG_06"], TRUE] call fn_magic_load_page;
			};
			case 2:
			{
				//sheaf linear
				private ["_line_len", "_line_len_ctrl","_idx_line_len", "_line_att", "_line_att_ctrl"];
				
				[["PG_06","PG_07","PG_09"], FALSE] call fn_magic_hide_page;
				[["PG_08"], TRUE] call fn_magic_load_page;
				
				//find length
				_line_len = missionNamespace getVariable ["MEF_MAGIC_LINE_LEN", "300"];
				_line_len_ctrl = _display displayCtrl IDC_PG_08_LENGTH_COMBO;
				
				//check if previous length selected
				if (_line_len != "") then
				{
					_idx_line_len = MEF_MAGIC_LINE_LENGTH find _line_len;
					_line_len_ctrl lbSetCurSel _idx_line_len;
				}
				else
				{
					//force selection 
					_line_len_ctrl lbSetCurSel 2;
				};		

				//update control
				_line_att = missionNamespace getVariable ["MEF_MAGIC_LINE_ATT", "6400"];
				_line_att_ctrl = _display displayCtrl IDC_PG_08_ATTITIUDE_EDIT;
				_line_att_ctrl ctrlSetText _line_att;		
		
				[IDC_PG_08_MILS_IMAGE, IDC_PG_08_DEGS_IMAGE, "MEF_MAGIC_LINE_ATT_UNITS_PRE"] call fn_magic_change_dir;
				
				//set focus
				ctrlSetFocus (_display displayCtrl IDC_PG_14_TYPE_COMBO);
			};
			case 3:
			{
				//sheaf open
				[["PG_07","PG_08","PG_09"], FALSE] call fn_magic_hide_page;
				[["PG_06"], TRUE] call fn_magic_load_page;
			};
			case 4:
			{
				//sheaf parallel
				[["PG_07","PG_08","PG_09"], FALSE] call fn_magic_hide_page;
				[["PG_06"], TRUE] call fn_magic_load_page;
			};
			case 5:
			{
				//sheaf rectangle
				private ["_rect_len", "_rect_len_ctrl","_idx_rect_len", "_rect_wid", "_rect_wid_ctrl", "_idx_rect_wid", "_rect_att", "_rect_att_ctrl"];
				
				[["PG_06","PG_08","PG_09"], FALSE] call fn_magic_hide_page;
				[["PG_07"], TRUE] call fn_magic_load_page;
				
				//find length	
				_rect_len = missionNamespace getVariable ["MEF_MAGIC_RECT_LEN", ""];
				_rect_len_ctrl = _display displayCtrl IDC_PG_07_LENGTH_COMBO;
				
				//check if previous length saved
				if (_rect_len != "") then
				{
					_idx_rect_len = MEF_MAGIC_RECT_LENGTH find _rect_len;
					_rect_len_ctrl lbSetCurSel _idx_rect_len;
				}
				else
				{
					//force length
					_rect_len_ctrl lbSetCurSel 2;
				};				
				
				//check if previous width
				_rect_wid = missionNamespace getVariable ["MEF_MAGIC_RECT_WID", ""];
				_rect_wid_ctrl = _display displayCtrl IDC_PG_07_WIDTH_COMBO;
				
				if (_rect_wid != "") then
				{
					_idx_rect_wid = MEF_MAGIC_WIDTH find _rect_wid;
					_rect_wid_ctrl lbSetCurSel _idx_rect_wid;
				}
				else
				{
					//force width
					_rect_wid_ctrl lbSetCurSel 1;
				};		

				//check previous attitude
				_rect_att = missionNamespace getVariable ["MEF_MAGIC_RECT_ATT", "6400"];
				_rect_att_ctrl = _display displayCtrl IDC_PG_07_ATTITIUDE_EDIT;
				_rect_att_ctrl ctrlSetText _rect_att;		
		
				//load direction units "pre"
				[IDC_PG_07_MILS_IMAGE, IDC_PG_07_DEGS_IMAGE, "MEF_MAGIC_RECT_ATT_UNITS_PRE"] call fn_magic_change_dir;
				
				//set focus
				ctrlSetFocus (_display displayCtrl IDC_PG_14_TYPE_COMBO);
			};
		};
	};
	case IDC_PG_15_TYPE_COMBO:
	{
		switch (_idx) do
		{
			case 0:  //delay
			{
				[["PG_11"], FALSE] call fn_magic_hide_page;
				[["PG_10"], TRUE] call fn_magic_load_page;	

			};
			case 1:	//time on target
			{
				private ["_control_hr_ctrl", "_control_min_ctrl", "_control_sec_ctrl", "_time_array", "_time_sec", "_two_mins", "_time_TOT", "_control_sec", "_idx_control_sec"];
				
				[["PG_10"], FALSE] call fn_magic_hide_page;
				[["PG_11"], TRUE] call fn_magic_load_page;	 
				
				//initialize variables
				_control_hr_ctrl = _display displayCtrl IDC_PG_11_HR_EDIT;
				_control_min_ctrl = _display displayCtrl IDC_PG_11_MIN_EDIT;
				_control_sec_ctrl = _display displayCtrl IDC_PG_11_SEC_COMBO;
				
				//calculate time
				_time_array = [daytime ,"ARRAY"] call fn_vbs_timeToString; //returns ["hr","min","sec","mili"]
				
				_time_sec = parseNumber (_time_array select 2); //convert sec to a number
				
				_two_mins = (120 + _time_sec)/3600; //2 mins + current seconds in mili seconds
				_time_TOT =  [daytime + _two_mins ,"ARRAY"] call fn_vbs_timeToString;
				
				//output numbers
				_control_hr_ctrl ctrlSetText (_time_TOT select 0);
				_control_min_ctrl ctrlSetText (_time_TOT select 1);
				
				//check if previous seconds saved
				_control_sec = missionNamespace getVariable ["MEF_MAGIC_CONTROL_SEC", "00"];
				
				if (_control_sec != "") then
				{
					_idx_control_sec = MEF_MAGIC_CONTROL_SEC find _control_sec;
					_control_sec_ctrl lbSetCurSel _idx_control_sec;
				}
				else
				{
					//force seconds selected
					_control_sec_ctrl lbSetCurSel 0;
				};	
				
				//set focus
				ctrlSetFocus _control_min_ctrl;
			};
		};
	};
};
	
	
	
	
	
	
	