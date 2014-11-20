private ["_dialog","_list","_missionType","_missionName"];
disableSerialization;

_dialog = findDisplay 45600;
_list = _dialog displayCtrl 45601;
_button = _dialog displayCtrl 45604;

if(count HELI_CURRENT_MISSION_SUBTYPE == 0) then
{
	ctrlShow [45604, false];
}
else
{
	ctrlShow [45604, true];
};

lbClear _list;

ctrlSetText [45602, "Choose mission type"];
{
	_missionType = _x select 0;
	_missionName = _x select 1;

	_list lbAdd format["%1",_missionName];
	_list lbSetData [(lbSize _list)-1,_missionType];
	ctrlShow [45601,true];
} foreach HELI_MISSIONS;
		
