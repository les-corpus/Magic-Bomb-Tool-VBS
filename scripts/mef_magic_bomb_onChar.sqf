
//for edit boxes that require numbers only such as direction, mgrs (north or easting), distances.
//Checks what the user is entering.  

//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//passed data
_ctrl = _this select 0;
_char_id = _this select 1;

//get ctrls
_idc = ctrlIDC _ctrl;
_display = MEF_MAGIC_BOMB_TOOL;

switch (_idc) do
{
	case IDC_PG_02_MGRS_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
	};
	case IDC_PG_02_DIR_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
	};
	case IDC_PG_03_MGRS_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
	};
	case IDC_PG_03_DIR_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
	};
	case IDC_PG_03_DIS_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;		
	};
	case IDC_PG_04_DIR_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
	};
	case IDC_PG_04_LEFT_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
		
		_right_ctrl = _display displayCtrl (_idc+3); 
		_right_ctrl ctrlSetText "";
	};
	case IDC_PG_04_RIGHT_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
		
		_left_ctrl = _display displayCtrl (_idc-3); 
		_left_ctrl ctrlSetText "";
	};
	case IDC_PG_04_ADD_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;	

		_drop_ctrl = _display displayCtrl (_idc+3); 
		_drop_ctrl ctrlSetText "";		
	};
	case IDC_PG_04_DROP_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;	

		_add_ctrl = _display displayCtrl (_idc-3); 
		_add_ctrl ctrlSetText "";		
	};
	case IDC_PG_07_ATTITIUDE_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
	};
	case IDC_PG_08_ATTITIUDE_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
	};
	case IDC_PG_09_RADIUS_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;		
	};
	case IDC_PG_11_HR_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;		
	};
	case IDC_PG_11_MIN_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;	
	};
	case IDC_PG_12_DIR_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
	};
	case IDC_PG_13_DIR_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
	};
	case IDC_PG_13_LEFT_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;	
		
		_right_ctrl = _display displayCtrl (_idc+3); 
		_right_ctrl ctrlSetText "";
	};
	case IDC_PG_13_RIGHT_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;
		
		_left_ctrl = _display displayCtrl (_idc-3); 
		_left_ctrl ctrlSetText "";
	};
	case IDC_PG_13_ADD_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;	
		
		_drop_ctrl = _display displayCtrl (_idc+3); 
		_drop_ctrl ctrlSetText "";
	};
	case IDC_PG_13_DROP_EDIT:
	{
		[_ctrl, _char_id, _idc] call fn_magic_check_numbers;	
		
		_add_ctrl = _display displayCtrl (_idc-3); 
		_add_ctrl ctrlSetText "";
	};
};
	
	
	
	
	
	
	
	
	
	
	
	
	
	