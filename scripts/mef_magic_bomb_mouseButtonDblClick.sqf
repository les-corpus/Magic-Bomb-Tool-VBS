
//when user double LMB click on a row in the advanced tree
 
//constants for the gui
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_projectdefines.hpp"
#include "\vbs2\customer\other\mef_magic_bomb_tool\data\scripts\mef_magic_bomb_defines.hpp"

//display name

_display = MEF_MAGIC_BOMB_TOOL;
_adj_tree_ctrl = _display displayCtrl IDC_MAIN_ADJUSTMENTS_TREE;
_map = _display displayCtrl IDC_MAIN_2D_MAP;

_row = _this select 1;
_msn_tgt_num = (_adj_tree_ctrl advTreeValue _row) select 0;

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
_tgt_loc  = _msn_array select 3;	//[game X, game Y]

//center on map 

_map ctrlMapAnimAdd [.5, ctrlMapScale _map, _tgt_loc];
ctrlMapAnimCommit _map;
	
//Do not draw new marker
missionNamespace setVariable ["MEF_MAGIC_DRAW_TGT", FALSE];


