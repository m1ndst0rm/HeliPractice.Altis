_failType = _this select 0;
_posFrom = ["FLY", false] call HELI_fnc_MissionInit;

_failTime = 10 + floor(random (21));
titleCut ["", "BLACK IN", 1];
sleep 1;

[
player, ["survive", "Land the chopper once failure occures.", "Land chopper once failure occures.", "", "", "assigned"]
] call FHQ_TT_addTasks;

if(HELI_CURRENT_MISSION_DIFFICULTY > HELI_DIFICULTY_NORMAL) then
{
	_failTime = floor(random (5));
	_canPass = false;
	while{!_canPass} do
	{
		_canPass =  speed HELI_CURRENT_VEHICLE > 150 || HELI_MISSION_DONE;
		sleep HELI_MISSION_SLEEP;
	};
	if(HELI_MISSION_DONE) exitWith { false; };
};
sleep _failTime;
if(_failType == HELI_FAILURE_RANDOM) then
{
	if((floor(random 2)) == 0) then {_failType = HELI_FAILURE_TAILROTOR} else {_failType = HELI_FAILURE_ENGINE} ;
};	

_part = "";
switch(_failType) do
{
	case HELI_FAILURE_TAILROTOR:
	{
		_part = getText(configFile >> "cfgVehicles" >> typeOf HELI_CURRENT_VEHICLE >> "HitPoints" >> "HitVRotor" >> "name");
	};
	case HELI_FAILURE_ENGINE:
	{
		_part = getText(configFile >> "cfgVehicles" >> typeOf HELI_CURRENT_VEHICLE >> "HitPoints" >> "HitEngine" >> "name");
	};
};
diag_log format ["Part %1 failed.", _part];
HELI_CURRENT_VEHICLE setHit [_part, 1];
//Fail  a part

_canPass = false;
while{!_canPass} do
{
	_canPass =  ((position HELI_CURRENT_VEHICLE) select 2) < 1 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
_canPass = false;
while{!_canPass} do
{
	_canPass =  ((position HELI_CURRENT_VEHICLE) select 2) < 1 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };


FHQ_TTI_supressTaskHints = false;
["survive", "succeeded"] call FHQ_TT_setTaskState;

sleep 5;
if(HELI_MISSION_DONE) exitWith { false; };

true;