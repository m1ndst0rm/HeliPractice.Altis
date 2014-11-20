private ["_introText","_script","_result","_tasks","_groups","_groupObject"];
//Start mission
FHQ_TTI_supressTaskHints = true;
player allowDamage false;
HELI_DISPLAY_LIVES = false;
HELI_TEAMMATES = [];
HELI_ENEMIES = [];
HELI_PLAYER_POS = position player;
_introText = HELI_CURRENT_MISSION_SUBTYPE select 3;
hintC _introText;
HELI_MISSION_DONE = false;
[] call HELI_fnc_DiagInfoThread;
_script = HELI_CURRENT_MISSION_SUBTYPE select 4;
_result = [] call _script;

sleep 2;
titleCut ["", "BLACK OUT", 1];
sleep 1;

//Done moveout player
moveOut player;
player setVelocity [0, 0, 0];
player setPos HELI_PLAYER_POS;

//Cleanup 
//Vehicle
if !(isNull HELI_CURRENT_VEHICLE) then
{
	deleteVehicle HELI_CURRENT_VEHICLE; 
};

//Teammates
_groups = [];
{
	_groupObject = group _x;
	if !(_groupObject in _groups) then { _groups set [count _groups, _groupObject]; };
	deleteVehicle _x;
} foreach HELI_TEAMMATES;

//Enemies 
{
	_groupObject = group _x;
	if !(_groupObject in _groups) then { _groups set [count _groups, _groupObject]; };
	deleteVehicle _x;
} foreach HELI_ENEMIES;

{ deleteGroup _x;} foreach _groups;

FHQ_TTI_supressTaskHints = true;
{
	
	player removeSimpleTask _x;
} foreach simpleTasks player;
FHQ_TTI_TaskList = [];
FHQ_TTI_ClientTaskList = [];
player setVariable ["FHQ_TTI_ClientTaskList", [], true];

player allowDamage true;
titleCut ["", "BLACK IN", 1];
sleep 1;

_tasks = (["assigned"] call FHQ_TT_getAllTasksWithState); 
{
	[_x, "failed"] call FHQ_TT_setTaskState;
} foreach _tasks;

if!(_result) then
{
	hintc "You failed. Try again!";
}
else
{
	hintc "You passed the mission!";
};
HELI_DISPLAYFUNC = {};
HELI_VOTE_TYPE = "MISSIONTYPE";
