#define HELI_JINKINTERVAL 0.1

_posFrom = ["FLY"] call HELI_fnc_MissionInit;
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
	HELI_ENEMIES set [count HELI_ENEMIES, _unit];
};

titleCut ["", "BLACK IN", 1];
sleep 1;

[
player, ["jinking", "Fly to destination and start jinking as soon as you get shot at..", "Fly to destination.", "Destination", _toPos, "assigned"]
] call FHQ_TT_addTasks;

_canPass = false;
while{!_canPass} do
{
	_canPass =  {_x distance HELI_CURRENT_VEHICLE < 1500} count HELI_ENEMIES > 0  || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };
{
	_x reveal [HELI_CURRENT_VEHICLE,4];
	_x doTarget HELI_CURRENT_VEHICLE;
	_x doFire HELI_CURRENT_VEHICLE;
} foreach HELI_ENEMIES;

if(HELI_CURRENT_MISSION_DIFFICULTY <= HELI_DIFICULTY_NORMAL) then
{
	_text = "<t align='center' valign='middle' size='1.8'>Start jinking!</t>";
	[_text, -1, -1, 4, 0.2] spawn BIS_fnc_dynamicText;
};

_doJinkCheck = true;

_jinkDir = 0;
_jinkAltitude = 0;
_checkTime = 0;
_flags = 0;
_totalTime = 0;
HELI_JINKDIR = 0;
HELI_JINKALTITUDE = 0;
if(HELI_CURRENT_MISSION_DIFFICULTY <= HELI_DIFICULTY_NORMAL) then
{
	HELI_DISPLAYFUNC = 
	{
		format ["<t size='2'>JinkLevel:  %1</t><t size='1.5'>/100</t>", round (((((20 min HELI_JINKDIR)/20) * 100) + (((10 min HELI_JINKALTITUDE)/10) * 100)) / 2)]
	};
};

while {_doJinkCheck} do
{
	_currentDir = direction HELI_CURRENT_VEHICLE;
	_currentAltitude = (position HELI_CURRENT_VEHICLE) select 2;
	
	sleep HELI_JINKINTERVAL;
	
	_diffDir = (direction HELI_CURRENT_VEHICLE max _currentDir) - (direction HELI_CURRENT_VEHICLE min _currentDir);
	_diffAltitude = abs (_currentAltitude - ((position HELI_CURRENT_VEHICLE) select 2));
	
	_jinkDir = _jinkDir + _diffDir;
	_jinkAltitude = _jinkAltitude + _diffAltitude;
	
	_checkTime = _checkTime + HELI_JINKINTERVAL;
	if(_checkTime > 2) then
	{
		_totalTime = _totalTime + 1;
		_checkTime = 0;
		hint format ["Dir: %1 Alt: %2", _jinkDir, _jinkAltitude];
		
		if(_jinkDir < 20 || _jinkAltitude < 10) then
		{
			_flags = _flags + 1;
		};
		HELI_JINKDIR = _jinkDir;
		HELI_JINKALTITUDE  = _jinkAltitude;
		_jinkDir = 0;
		_jinkAltitude = 0;
	};
	
	if(_totalTime > 30) then
	{
		_doJinkCheck = false;
	};
	if(HELI_MISSION_DONE) then {_doJinkCheck = false;};
};

//TODO: Check
if(_flags > 5 || HELI_MISSION_DONE) exitWith { false; };

FHQ_TTI_supressTaskHints = false;
["jinking", "succeeded"] call FHQ_TT_setTaskState;

true;