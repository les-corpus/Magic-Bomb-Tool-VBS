
//mef_uas_bindKey_actions.sqf

//key codes
#include "\vbs2\headers\dikCodes.hpp"

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//development variables
#ifdef MEF_MAGIC_BOMB_USE_MISSION_SCRIPTS
_projectDataFolder = "P:\vbs2\customer\other\mef_magic_bomb_tool\data\";
#else
_projectDataFolder = "\vbs2\customer\other\mef_magic_bomb_tool\data\";
#endif


_bindKey = _this select 0;

switch (_bindKey) do
{
	case "DIK_T":
	{	
		//toggle DTG
		private ["_date_type"];

		_display = MEF_MAGIC_BOMB_TOOL;
		
		_control_type_ctrl = _display displayCtrl IDC_PG_15_TYPE_COMBO;	
		_control_pg_15_panel = _display displayCtrl IDC_PG_15_PANEL;
		
		_date_type = missionNamespace getVariable ["MEF_MAGIC_TOGGLE_DTG", 0];
		
		_date_type = (_date_type+1) % 3;  //crazy math to rotate between 0-2
		
		missionNamespace setVariable  ["MEF_MAGIC_TOGGLE_DTG",_date_type];
		
		//show or hide the "Time on Tgt" option for method of fire and control
		if (_date_type == 2) then
		{
			lbClear _control_type_ctrl;
			_control_type_ctrl lbAdd "Delay";

			if (ctrlShown _control_pg_15_panel) then
			{
				_control_type_ctrl lbSetCurSel 0;  //set focus to index 0
			};
		};
		
		if (_date_type == 0) then
		{
			//add time on target
			lbClear _control_type_ctrl;
			
			{_control_type_ctrl lbAdd _x} forEach MEF_MAGIC_CONTROL;
		};
	};
	
	case "DIK_RETURN":
	{
		
	};
	
	case "DIK_NUMPADENTER":
	{
		
	};	
};











