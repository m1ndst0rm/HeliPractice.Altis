_enemyType = _this select 0;
_nearCity = _this select 1;

_posFrom = ["FLY"] call HELI_fnc_MissionInit;
_posTo = [_posFrom, _nearCity] call HELI_fnc_FindSafePos;

switch (_enemyType) do
{
	case HELI_ENEMY_INFANTRY:
	{
		_randomPos =  [_posTo ,0 ,400 , 5, 0, 2, 0] call BIS_fnc_findSafePos;
		_spawnGroup= [];
		switch(HELI_CURRENT_MISSION_DIFFICULTY) do
		{
			case HELI_DIFICULTY_VERYEASY;
			case HELI_DIFICULTY_EASY;
			case HELI_DIFICULTY_NORMAL;
			case HELI_DIFICULTY_HARD:
			{
			
				_spawnGroup = [_randomPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
			};
			case HELI_DIFICULTY_VERYHARD:
			{
				_spawnGroup = [_randomPos, EAST, (configFile >> "CfgGrups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
				//diag_log format ["Enemies: %1 at pos %2", count units _spawnGroup, _randomPos];
			};
			case HELI_DIFICULTY_INSANE:
			{
				_spawnGroup = [_randomPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
				_randomPos2 =  [_posTo ,0 ,400 , 5, 0, 2, 0] call BIS_fnc_findSafePos;
				_spawnGroup2 = [_randomPos2, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
				{HELI_ENEMIES set [count HELI_ENEMIES, _x]} foreach units _spawnGroup2;
			};
		};

		{HELI_ENEMIES set [count HELI_ENEMIES, _x]} foreach units _spawnGroup;
		if(HELI_CURRENT_MISSION_DIFFICULTY <= HELI_DIFICULTY_NORMAL) then
		{
			[_randomPos] spawn {
				private ["_enemyPos"];
				_enemyPos = _this select 0;
				waitUntil {player distance _enemyPos < 1000};
				"SmokeShellRed" createVehicle (_enemyPos);
			};
		};

		
	};
	case HELI_ENEMY_VEHICLE:
	{
		_enemyType = "";
		_amount = 1;
		switch(HELI_CURRENT_MISSION_DIFFICULTY) do
		{
			case HELI_DIFICULTY_VERYEASY;
			case HELI_DIFICULTY_EASY;
			case HELI_DIFICULTY_NORMAL:
			{
				_enemyType = "O_MRAP_02_gmg_F";
			};
			case HELI_DIFICULTY_HARD:
			{
				_enemyType = "O_MRAP_02_hmg_F";
			};
			case HELI_DIFICULTY_VERYHARD:
			{
				_enemyType = "O_MRAP_02_hmg_F";
				_amount = 2;
			};
			case HELI_DIFICULTY_INSANE:
			{
				_enemyType = "O_APC_Tracked_02_AA_F"
			};
		};
			
		for "_i" from 1 to _amount do
		{
			_randomPos =  [_posTo ,0 ,150 , 5, 0, 2, 0] call BIS_fnc_findSafePos;
			_unit = _enemyType createVehicle _randomPos;
			//diag_log format ["Created %1 at pos %2", _unit, _randomPos];
			createVehicleCrew _unit;
			HELI_ENEMIES set [count HELI_ENEMIES, _unit];
			if(HELI_CURRENT_MISSION_DIFFICULTY <= HELI_DIFICULTY_NORMAL) then
			{
				[_randomPos] spawn {
					private ["_enemyPos"];
					_enemyPos = _this select 0;
					waitUntil {player distance _enemyPos < 1000};
					"SmokeShellRed" createVehicle (_enemyPos);
				};
			};
		};
		
		[] spawn {
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
		};
	};
	case HELI_ENEMY_CONVOY:
	{
	
	};
};

titleCut ["", "BLACK IN", 1];
sleep 1;

[
player, ["killEnemies", "Kill all enemies present at waypoint.", "Kill all enemies.", "Enemies", _posTo, "assigned"]
] call FHQ_TT_addTasks;

HELI_DISPLAYFUNC = {
	format ["<t size='2'>Dead:  %1</t><t size='1.5'>/%2</t>", {!alive _x} count HELI_ENEMIES, count HELI_ENEMIES];
};

_canPass = false;
while{!_canPass} do
{
	_canPass =  {alive _x} count HELI_ENEMIES == 0 || HELI_MISSION_DONE;
	sleep HELI_MISSION_SLEEP;
};
if(HELI_MISSION_DONE) exitWith { false; };

FHQ_TTI_supressTaskHints = false;
["killEnemies", "succeeded"] call FHQ_TT_setTaskState;

sleep 10;
HELI_DISPLAYFUNC = {};
true;