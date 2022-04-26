//terminate script
//executes when the dialog is closed

//delete ECRs
for "_i" from 1 to 8 do
{
	call compile format ["deleteMarkerLocal ECR_%1", _i];
};

//terminate map update script
terminate MEF_MAGIC_UPDATE_MAP;

{unBindKey _x} forEach MEF_MAGIC_BINDKEYS; 