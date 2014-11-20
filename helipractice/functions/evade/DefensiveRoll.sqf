_posFrom = ["FLY"] call HELI_fnc_MissionInit;
_toPos = [_posFrom, 4000, 5000, true] call HELI_fnc_RandomPos;
_enemyPos = [_posFrom, _toPos, 2000, 1000]  call HELI_fnc_RandomPosBetween;

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
player, ["defesiveRoll", "Fly to destination, stay below 50 meters, and perform a defensiveroll once shot upon.", "Fly to destination.", "Destination", _toPos, "assigned"]
] call FHQ_TT_addTasks;

_canPass = false;
_checkEnemy = objNull;
while{!_canPass} do
{
	_canPass =  {_x distance HELI_CURRENT_VEHICLE < 700} count HELI_ENEMIES > 0  || HELI_MISSION_DONE;
	if(_canPass) then
	{
		{
			if(_x distance HELI_CURRENT_VEHICLE < 700) then
			{
				_checkEnemy = _x;
			};
		} foreach HELI_ENEMIES;
	};
	
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };
{
	_x reveal [HELI_CURRENT_VEHICLE,4];
	_x doTarget HELI_CURRENT_VEHICLE;
	_x doFire HELI_CURRENT_VEHICLE;
} foreach HELI_ENEMIES;


sleep 2;
if(HELI_CURRENT_MISSION_DIFFICULTY <= HELI_DIFICULTY_NORMAL) then
{
	_text = "<t align='center' valign='middle' size='1.8'>Perform the defensive roll now!</t>";
	[_text, -1, -1, 4, 0.2] spawn BIS_fnc_dynamicText;
};

_inRoll = true;
_outOfRollTime = 0;
_notGoodPitchTime = 0;
_lastDistanceToEnemey = 100;

_maxAllowedFalsePitchTime = 2 + (0.4 * ((5 - HELI_CURRENT_MISSION_DIFFICULTY)));



if(HELI_CURRENT_MISSION_DIFFICULTY <= HELI_DIFICULTY_NORMAL) then
{
	HELI_DISPLAYFUNC = 
	{
		format ["<t size='2'>Deviation: %1°</t>", round (abs(HELI_CURRENTPITCH - HELI_SHOULDHAVEANGLE))]
	};
};

//TODO: Add color display for easy levels to display safe pitch.
while{_inRoll} do
{
	_distanceToEnemy = player distance _checkEnemy;
	_dx = _distanceToEnemy - _lastDistanceToEnemey;
	if(_dx > 0 && speed HELI_CURRENT_VEHICLE > 100) then
	{	//Moving away
		_outOfRollTime = _outOfRollTime + 0.1;
		if(_outOfRollTime > 1) then
		{
			_inRoll = false;
		};
	};
	_lastDistanceToEnemey = _distanceToEnemy;
	
	//TODO: Check if bottom is facing  during most of roll
	_pitbchbank = HELI_CURRENT_VEHICLE call BIS_fnc_getPitchBank;
	HELI_CURRENTPITCH = _pitbchbank select 0;
	
	//sin-1   (height/distancebetween)
	_heightDiff = (position HELI_CURRENT_VEHICLE select 2) - (position _checkEnemy select 2);
	_flatPosP = [position HELI_CURRENT_VEHICLE select 0, position HELI_CURRENT_VEHICLE select 1];
	_flatPosE = [position _checkEnemy select 0, position _checkEnemy select 1];
	_groundDiff =  sqrt ((((_flatPosE select 0) - (_flatPosP select 0)) ^ 2) + (((_flatPosE select 1) - (_flatPosP select 1)) ^ 2));
	HELI_SHOULDHAVEANGLE = asin (_heightDiff / _groundDiff);
	
	//HELI_SHOULDHAVEANGLE is perfect angle for a 90 degree facing.
	hint format ["Pitch: %1. Should be : %2", HELI_CURRENTPITCH, HELI_SHOULDHAVEANGLE];
	if(abs (HELI_SHOULDHAVEANGLE - HELI_CURRENTPITCH) > 45) then
	{//Not perfect
		_notGoodPitchTime = _notGoodPitchTime + 0.1;
	}
	else
	{
		_notGoodPitchTime = 0;
	};
	
	//Easy gets max 4 seconds allowed non-good pitchtime.
	if(_notGoodPitchTime > _maxAllowedFalsePitchTime) then
	{
		_inRoll = false;
	};
	
	sleep 0.1;
};

if(_notGoodPitchTime > _maxAllowedFalsePitchTime) exitWith { false; };

FHQ_TTI_supressTaskHints = false;
["defesiveRoll", "succeeded"] call FHQ_TT_setTaskState;

sleep 10;

true;