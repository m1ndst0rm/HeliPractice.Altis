_special = _this select 0;
_enableDamageHandler = [_this ,1, true] call BIS_fnc_param;
titleCut ["", "BLACK OUT", 1];
sleep 1;
_posFrom = [getMarkerPos "HELI_MARKER_START", 0, 4000, true] call HELI_fnc_RandomPos;

if(_special == "FLY") then
{
	_posFrom set[2, 100];
}
else
{
	_posFrom set[2, 0];
};
//_posFrom set [2, (_posFrom select 1) + 100];
HELI_CURRENT_VEHICLE = createVehicle [HELI_CURRENT_VEHICLE_TYPE, _posFrom, [], 0, _special];
player moveInDriver HELI_CURRENT_VEHICLE;
HELI_CURRENT_VEHICLE engineOn true;

_damageMultiplier = 1;
switch(HELI_CURRENT_MISSION_DIFFICULTY) do
{
	case HELI_DIFICULTY_VERYEASY:
	{
		HELI_CURRENT_VEHICLE allowDamage false;
	};
	case HELI_DIFICULTY_EASY:
	{
		_damageMultiplier = 0.2;
		
	};
};
if(_enableDamageHandler) then
{
	[HELI_CURRENT_VEHICLE, _damageMultiplier] call HELI_fnc_SetVehicleDamageHandler;
};
[] call HELI_fnc_VehicleAliveCheck;

_posFrom;