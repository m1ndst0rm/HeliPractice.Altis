_posFrom = ["FLY"] call HELI_fnc_MissionInit;;
_toPos = [_posFrom, 4000, 5000, true] call HELI_fnc_RandomPos;

_amount = 1;
_enemyType = "";
switch (HELI_CURRENT_MISSION_DIFFICULTY) do
{
	case HELI_DIFICULTY_VERYEASY;
	case HELI_DIFICULTY_EASY;
	case HELI_DIFICULTY_NORMAL: { _enemyType = "O_MRAP_02_gmg_F"; };
	case HELI_DIFICULTY_HARD: { _enemyType = "O_MRAP_02_hmg_F"; };
	case HELI_DIFICULTY_VERYHARD: { _enemyType = "O_MRAP_02_hmg_F"; _amount = 2};
	case HELI_DIFICULTY_INSANE: { _enemyType = "O_APC_Tracked_02_AA_F"; };
};
_enemyPos = [_posFrom, _toPos, 2000, 1000]  call HELI_fnc_RandomPosBetween;

for "_i" from 1 to _amount do
{
	_randomPos =  [_enemyPos ,50 ,200 , 5, 0, 2, 0] call BIS_fnc_findSafePos;
	_unit = _enemyType createVehicle _randomPos;
	createVehicleCrew _unit;
	diag_log format ["Created %1 at pos %2", _unit, _randomPos];
	HELI_ENEMIES set [count HELI_ENEMIES, _unit];
};
titleCut ["", "BLACK IN", 1];
sleep 1;

[
player, ["breakturn", "Fly to destination and perform a beakturn once shot upon.", "Fly to destination.", "Destination", _toPos, "assigned"]
] call FHQ_TT_addTasks;

//Wait until enemy knows presence of player

_canPass = false;
while{!_canPass} do
{
	_canPass =  {_x distance HELI_CURRENT_VEHICLE < 700} count HELI_ENEMIES > 0  || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };
{
	_x reveal [HELI_CURRENT_VEHICLE,4];
	_x doTarget HELI_CURRENT_VEHICLE;
	_x doFire HELI_CURRENT_VEHICLE;
} foreach HELI_ENEMIES;

HELI_DIR_START = direction HELI_CURRENT_VEHICLE;
sleep 2;

if(HELI_CURRENT_MISSION_DIFFICULTY <= HELI_DIFICULTY_NORMAL) then
{
	_text = "<t align='center' valign='middle' size='1.8'>Break left now!</t>";
	[_text, -1, -1, 4, 0.2] spawn BIS_fnc_dynamicText;
	
	HELI_DISPLAYFUNC = {
		format ["<t size='2'>Turned:  %1</t><t size='1.5'>/90</t>", round ((HELI_DIR_START max direction HELI_CURRENT_VEHICLE) - (HELI_DIR_START min direction HELI_CURRENT_VEHICLE))]
	};
};

sleep 7;
_currentDir = direction HELI_CURRENT_VEHICLE;
_diff = (HELI_DIR_START max _currentDir) - (HELI_DIR_START min _currentDir);
sleep 7;

if(_diff < 90) exitWith { false; };


FHQ_TTI_supressTaskHints = false;
["breakturn", "succeeded"] call FHQ_TT_setTaskState;

sleep 10;

true;