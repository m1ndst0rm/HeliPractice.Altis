private ["_nearCity","_spawnEnemies","_posFrom","_posTo","_availableCargo","_unitType","_unitpos","_unit","_randomPos","_spawnGroup","_markerPos","_friendlyGroup","_enemyGroup"];

_nearCity = _this select 0;
_spawnEnemies = _this select 1;

_posFrom = ["NONE"] call HELI_fnc_MissionInit;
_posTo = [_posFrom, _nearCity] call HELI_fnc_FindSafePos;


player moveInDriver HELI_CURRENT_VEHICLE;

_friendlyGroup = createGroup (side player);

_availableCargo = getNumber(configFile >> "CfgVehicles" >> HELI_CURRENT_VEHICLE_TYPE >> "transportSoldier");
_unitType = "B_soldier_AR_F";

for "_i" from 1 to _availableCargo do
{
	_range = 50;
	_unitpos = [_posTo ,0 ,_range , 1, 0, 0, 0] call BIS_fnc_findSafePos;
	
	while {count _unitpos == 0} do 
	{
		_range = _range + 50;
		_unitpos = [_posTo ,0 ,_range , 1, 0, 0, 0] call BIS_fnc_findSafePos;
	};
	
	_unit = _friendlyGroup createUnit [_unitType , _unitpos, [], 0, "None"];
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
		diag_log format ["Enemies: %1", count units _spawnGroup];
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

_markerPos = [_posTo select 0, _posTo select 1];
if(HELI_CURRENT_MISSION_DIFFICULTY >= HELI_DIFICULTY_HARD) then
{ //Troop location unknown, so place marker somewhere random.
	_markerPos set [0, (_markerPos select 0) + floor(random 101)];
	_markerPos set [1, (_markerPos select 1) + floor(random 101)];
};

[
player, ["extract", "Extract troops from location.", "Extract troops.", "", "", "assigned"],
[["extractTroops","extract"], "Pickup troops at location.", "Pickup troops", "Pickup location", _markerPos],
[["return","extract"], "Return to mission start location.", "Return to start location", "Return location", _posFrom]
] call FHQ_TT_addTasks;

FHQ_TTI_supressTaskHints = false;
["extractTroops", "assigned"] call FHQ_TT_setTaskState;

_canPass = false;
while{!_canPass} do
{
	_canPass =  (HELI_CURRENT_VEHICLE distance _posTo) < 500 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };

if(HELI_CURRENT_MISSION_DIFFICULTY <= HELI_DIFICULTY_NORMAL) then
{
	"SmokeShellGreen" createVehicle (_posTo);
};

_canPass = false;
while{!_canPass} do
{
	_canPass =  (HELI_CURRENT_VEHICLE distance _posTo) < 75 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };

{
	_x assignAsCargo HELI_CURRENT_VEHICLE;
	[_x] orderGetIn true;
} foreach HELI_TEAMMATES;

HELI_DISPLAYFUNC = {
	format ["<t size='2'>Boarded:  %1</t><t size='1.5'>/%2</t>", {_x in HELI_CURRENT_VEHICLE && alive _x} count HELI_TEAMMATES, {alive _x} count HELI_TEAMMATES];
};

_canPass = false;
while{!_canPass} do
{
	_canPass =  ({_x in HELI_CURRENT_VEHICLE || !alive _x} count HELI_TEAMMATES == count HELI_TEAMMATES) || HELI_MISSION_DONE;
	
	{
		_x assignAsCargo HELI_CURRENT_VEHICLE;
		[_x] orderGetIn true;
	} foreach HELI_TEAMMATES;
	
	sleep HELI_MISSION_SLEEP + 0.9;
};
if(HELI_MISSION_DONE) exitWith { false; };

HELI_DISPLAYFUNC = {};

["dropOff", "succeeded", "return"] call FHQ_TT_setTaskStateAndNext;

_canPass = false;
while{!_canPass} do
{
	_canPass =  (HELI_CURRENT_VEHICLE distance _posFrom) < 75 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };

{ unassignVehicle _x } forEach HELI_TEAMMATES;

HELI_DISPLAYFUNC = {
	format ["<t size='2'>Unloaded:  %1</t><t size='1.5'>/%2</t>", {!(_x in HELI_CURRENT_VEHICLE) && alive _x} count HELI_TEAMMATES, {alive _x} count HELI_TEAMMATES];
};

_canPass = false;
while{!_canPass} do
{
	_canPass =  {_x in HELI_CURRENT_VEHICLE} count HELI_TEAMMATES == 0 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };

["extract", "succeeded"] call FHQ_TT_setTaskState;

sleep 2;
HELI_DISPLAYFUNC = {};
HELI_MISSION_DONE = true;
true;