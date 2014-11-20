private ["_nearCity","_spawnEnemies","_posFrom","_posTo","_teamGroup","_availableCargo","_unitType","_unitpos","_unit","_randomPos","_spawnGroup","_enemyGroup"];

_nearCity = _this select 0;
_spawnEnemies = _this select 1;

_posFrom = ["NONE"] call HELI_fnc_MissionInit;

_posTo = [_posFrom, _nearCity] call HELI_fnc_FindSafePos;
_teamGroup = createGroup (side player);

_availableCargo = getNumber(configFile >> "CfgVehicles" >> HELI_CURRENT_VEHICLE_TYPE >> "transportSoldier");
_unitType = "B_soldier_AR_F";
for "_i" from 1 to _availableCargo do
{
	_unitpos = [_posFrom ,5 ,15 , 1, 0, 0, 0] call BIS_fnc_findSafePos;

	_unit = _teamGroup createUnit [_unitType , _unitpos, [], 0, "None"];
	_unit setPos _unitpos;
	HELI_TEAMMATES set [count HELI_TEAMMATES, _unit];
};

if(_spawnEnemies) then
{
	for "_i" from 1 to 3 do
	{
		_randomPos =  [_posTo ,200 ,400 , 5, 0, 2, 0] call BIS_fnc_findSafePos;
		_spawnGroup = [_randomPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		
		
		if(HELI_CURRENT_MISSION_DIFFICULTY <= HELI_DIFICULTY_NORMAL) then
		{
			[_randomPos] spawn {
				private ["_enemyPos"];
				_enemyPos = _this select 0;
				waitUntil {player distance _enemyPos < 1000};
				"SmokeShellRed" createVehicle (_enemyPos);
			};
		};
		
		{HELI_ENEMIES set [count HELI_ENEMIES, _x]} foreach units _spawnGroup;
	};
	
	if(HELI_CURRENT_MISSION_DIFFICULTY >= HELI_DIFICULTY_VERYHARD) then
	{
		_randomPos =  [_posTo ,200 ,400 , 5, 0, 2, 0] call BIS_fnc_findSafePos;
		_spawnGroup = [_randomPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
		{HELI_ENEMIES set [count HELI_ENEMIES, _x]} foreach units _spawnGroup;
	};
	
	if(HELI_CURRENT_MISSION_DIFFICULTY >= HELI_DIFICULTY_INSANE) then
	{
		_randomPos =  [_posTo ,400 ,600 , 5, 0, 2, 0] call BIS_fnc_findSafePos;
		_spawnGroup = [_randomPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Mechanized" >> "OIA_MechInf_AA")] call BIS_fnc_spawnGroup;
		{HELI_ENEMIES set [count HELI_ENEMIES, _x]} foreach units _spawnGroup;
	};
};

titleCut ["", "BLACK IN", 1];
sleep 1;


[
player, ["transport", "Transport troops to destination.", "Transport troops.", "", "", "assigned""",""],
[["waitBoard","transport"], "Wait for all units to board your chopper.", "Wait until units board","",""],
[["dropOff","transport"], "Drop off troops", "Dropoff units at waypoin", "Dropoff location", _posTo],
[["return","transport"], "Return to mission start location.", "Return to start location", "Return location",  _posFrom]
] call FHQ_TT_addTasks;

FHQ_TTI_supressTaskHints = false;

HELI_DISPLAYFUNC = {
	format ["<t size='2'>Boarded:  %1</t><t size='1.5'>/%2</t>", {_x in HELI_CURRENT_VEHICLE && alive _x} count HELI_TEAMMATES, {alive _x} count HELI_TEAMMATES];
};

{
	_x assignAsCargo HELI_CURRENT_VEHICLE;
	[_x] orderGetIn true;
} foreach HELI_TEAMMATES;

_canPass = false;
while{!_canPass} do
{
	_canPass =  ({_x in HELI_CURRENT_VEHICLE || !alive _x} count HELI_TEAMMATES == count HELI_TEAMMATES) || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };

HELI_DISPLAYFUNC = {};
["waitBoard", "succeeded", "dropOff"] call FHQ_TT_setTaskStateAndNext;

_canPass = false;
while{!_canPass} do
{
	_canPass =  (HELI_CURRENT_VEHICLE distance _posTo) < 50 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };

//Make enemies shoot suppressing fire?
//_unit suppressFor 30
HELI_DISPLAYFUNC = {
	format ["<t size='2'>Unloaded:  %1</t><t size='1.5'>/%2</t>", {!(_x in HELI_CURRENT_VEHICLE) && alive _x} count HELI_TEAMMATES, {alive _x} count HELI_TEAMMATES];
};

{ unassignVehicle _x } forEach HELI_TEAMMATES;

_canPass = false;
while{!_canPass} do
{
	_canPass =  {_x in HELI_CURRENT_VEHICLE} count HELI_TEAMMATES == 0 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};

HELI_DISPLAYFUNC = {};
["dropOff", "succeeded", "return"] call FHQ_TT_setTaskStateAndNext;
_canPass = false;
while{!_canPass} do
{
	_canPass =  (HELI_CURRENT_VEHICLE distance _posTo) > 2000 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};

["transport", "succeeded"] call FHQ_TT_setTaskState;
sleep 2;

HELI_MISSION_DONE = true;
true;