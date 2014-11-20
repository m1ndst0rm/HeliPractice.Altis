//External
call compile preprocessFileLineNumbers "helipractice\external\fhqtt2.sqf";

//#REGION FUNCTIONS
HELI_fnc_FindSafePos = compileFinal preprocessFileLineNumbers "helipractice\functions\FindSafePos.sqf";
HELI_fnc_GetVehiclesFromConfig = compileFinal preprocessFileLineNumbers "helipractice\functions\GetVehiclesFromConfig.sqf";
HELI_fnc_MissionInit = compileFinal preprocessFileLineNumbers "helipractice\functions\MissionInit.sqf";
HELI_fnc_RandomPos = compileFinal preprocessFileLineNumbers "helipractice\functions\RandomPos.sqf";
HELI_fnc_RandomPosBetween = compileFinal preprocessFileLineNumbers "helipractice\functions\RandomPosBetween.sqf";
HELI_fnc_SetVehicleDamageHandler = compileFinal preprocessFileLineNumbers "helipractice\functions\SetVehicleDamageHandler.sqf";
HELI_fnc_StartMission = compileFinal preprocessFileLineNumbers "helipractice\functions\StartMission.sqf";
HELI_fnc_VehicleAliveCheck = compileFinal preprocessFileLineNumbers "helipractice\functions\VehicleAliveCheck.sqf";

HELI_fnc_TroopExtract = compileFinal preprocessFileLineNumbers "helipractice\functions\transport\TroopExtract.sqf";
HELI_fnc_TroopTransport = compileFinal preprocessFileLineNumbers "helipractice\functions\transport\TroopTransport.sqf";
HELI_fnc_VehicleTransport = compileFinal preprocessFileLineNumbers "helipractice\functions\transport\VehicleTransport.sqf";

HELI_fnc_Breakdive = compileFinal preprocessFileLineNumbers "helipractice\functions\evade\Breakdive.sqf";
HELI_fnc_Breakturn = compileFinal preprocessFileLineNumbers "helipractice\functions\evade\Breakturn.sqf";
HELI_fnc_DefensiveRoll = compileFinal preprocessFileLineNumbers "helipractice\functions\evade\DefensiveRoll.sqf";
HELI_fnc_Jinking = compileFinal preprocessFileLineNumbers "helipractice\functions\evade\Jinking.sqf";

HELI_fnc_EngageEnemy = compileFinal preprocessFileLineNumbers "helipractice\functions\engage\EngageEnemy.sqf";

HELI_fnc_Failure = compileFinal preprocessFileLineNumbers "helipractice\functions\failure\Failure.sqf";
//#ENDREGION

//#REGION DIALOG FUNCTIONS

HELI_fnc_DiagInfoThread = compileFinal preprocessFileLineNumbers "helipractice\functions\ui\DiagInfoThread.sqf";
HELI_fnc_DiagMission = compileFinal preprocessFileLineNumbers "helipractice\functions\ui\DiagMission.sqf";
HELI_fnc_DiagMissionButtonChoose = compileFinal preprocessFileLineNumbers "helipractice\functions\ui\DiagMissionButtonChoose.sqf";
HELI_fnc_DiagMissionInit = compileFinal preprocessFileLineNumbers "helipractice\functions\ui\DiagMissionInit.sqf";
HELI_fnc_DiagMissionSelectChanged = compileFinal preprocessFileLineNumbers "helipractice\functions\ui\DiagMissionSelectChanged.sqf";

//#ENDREGION

HELI_VOTE_TYPE = "MISSIONTYPE";
HELI_CURRENT_MISSION_SUBTYPE = [];
HELI_DISPLAYFUNC = {};

HELI_MISSION_SLEEP = 0.1; //Sleep time for checking objectives.

HELI_DIFICULTY_VERYEASY = 0;
HELI_DIFICULTY_EASY = 1;
HELI_DIFICULTY_NORMAL = 2;
HELI_DIFICULTY_HARD = 3;
HELI_DIFICULTY_VERYHARD = 4;
HELI_DIFICULTY_INSANE = 5;

_difficultiesSafeDropOff = [
[HELI_DIFICULTY_VERYEASY, "Your helicopter is indestructible."],
[HELI_DIFICULTY_EASY, "Your helicopter destructible  but you take only 20% damage."],
[HELI_DIFICULTY_NORMAL, "Your helicopter is destructible."]
];
_difficultiesSafePickUp = [
[HELI_DIFICULTY_VERYEASY, "Your helicopter is indestructible. Troop location is marked with green smoke."],
[HELI_DIFICULTY_EASY, "Your helicopter destructible  but you take only 20% damage. Troop location is marked with green smoke."],
[HELI_DIFICULTY_NORMAL, "Your helicopter is destructible. Troop location is marked with green smoke."],
[HELI_DIFICULTY_HARD, "Your helicopter is destructible. Troops are somewhere near the destination. Exact location is unclear."]
];
_difficultiesDropOff = [
[HELI_DIFICULTY_VERYEASY, "Your helicopter is indestructible. Enemies are marked with red smoke."],
[HELI_DIFICULTY_EASY, "Your helicopter destructible  but you take only 20% damage. Enemies are marked with red smoke."],
[HELI_DIFICULTY_NORMAL, "Your helicopter is destructible. Enemies are marked with red smoke."],
[HELI_DIFICULTY_HARD, "Your helicopter is destructible. Enemy location is unknown."],
[HELI_DIFICULTY_VERYHARD, "Your helicopter is destructible. Enemy location is unknown. There's also an enemy RPG unit near the drop off location."],
[HELI_DIFICULTY_INSANE, "Your helicopter is destructible. Enemy location is unknown. Enemy RPG unit and anti air present."]
];
_difficultiesPickUp = [
[HELI_DIFICULTY_VERYEASY, "Your helicopter is indestructible. Troop location is marked with green smoke. Enemies are marked with red smoke."],
[HELI_DIFICULTY_EASY, "Your helicopter destructible  but you take only 20% damage. Troop location is marked with green smoke. Enemies are marked with red smoke."],
[HELI_DIFICULTY_NORMAL, "Your helicopter is destructible. Troop location is marked with green smoke. Enemies are marked with red smoke."],
[HELI_DIFICULTY_HARD, "Your helicopter is destructible. Troops are somewhere near the destination. Exact location is unclear. Enemy location is unknown."],
[HELI_DIFICULTY_VERYHARD, "Your helicopter is destructible. Troops are somewhere near the destination. Exact location is unclear. There's also an enemy RPG unit near the pick-up location."],
[HELI_DIFICULTY_INSANE, "Your helicopter is destructible. Troops are somewhere near the destination. Exact location is unclear. Enemy RPG unit and anti air present."]
];

_MISSIONS_TRANSPORT = [
["SAFETROOP","Safe troop transport","Transport troops from A to B. Safe scenario.", "Wait for troops to load and transport them to the waypoint.", {[false, false] call HELI_fnc_TroopTransport}, _difficultiesSafeDropOff],
["SAFETROOPCITY","Safe troop transport city","Transport troops to a city. Safe scenario.", "Wait for troops to load and transport them to the waypoint.", {[true, false] call HELI_fnc_TroopTransport}, _difficultiesSafeDropOff],
/*["SAFEVEHICLE","Safe vehicle transport","Transport a vehicle from A to B. Safe scenario.", "Wait for vehicle to load and transport them to the waypoint.", {[] call HELI_fnc_SafeVehicleTransport}],*/
["SAFEEXTRACTTROOP","Safe troop extraction","Extract troops from somewhere. Safe scenario.", "Extract troops at designated waypoint.",{[false, false] call HELI_fnc_TroopExtract}, _difficultiesSafePickUp],
["SAFEEXTRACTTROOPCITY","Safe troop extraction city","Extract troops from a city. Safe scenario.", "Extract troops at designated waypoint.",{[true, false] call HELI_fnc_TroopExtract}, _difficultiesSafePickUp],
["TROOP","Troop tansport","Transport troops from A to B. Landing zone will be hot.", "Wait for troops to load and when they are loaded transport them to the waypoint. Intel suggest enemies present at drop-off zone.",{[false, true] call HELI_fnc_TroopTransport}, _difficultiesDropOff],
["TROOPCITY","Troop tansport city","Transport troops to a city. Landing zone will be hot.", "Wait for troops to load and when they are loaded transport them to the waypoint. Intel suggest enemies present at drop-off zone.",{[true, true] call HELI_fnc_TroopTransport}, _difficultiesDropOff],
/*["VEHICLE","Vehicle transport","Transport a vehicle from A to B. Landing zone will be hot.", "Wait for vehicle to load and when they are loaded transport them to the waypoint. Intel suggest enemies present at drop-off zone.", {[] call HELI_fnc_VehicleTransport}],*/
["EXTRACTTROOP","Troop extraction","Extract troops from somewhere. Landing zone will be hot.", "Extract troops at designated waypoint. Troops are under fire so be carefull.",{[false, true] call HELI_fnc_TroopExtract}, _difficultiesPickUp],
["EXTRACTTROOPCITY","Troop extraction city","Extract troops from a city. Landing zone will be hot.", "Extract troops at designated waypoint. Troops are under fire so be carefull.",{[true, true] call HELI_fnc_TroopExtract}, _difficultiesPickUp]
];

_difficultiesEvade = [
[HELI_DIFICULTY_VERYEASY, "Your helicopter is indestructible. You will be shot upon by a Ifrit HMG."],
[HELI_DIFICULTY_EASY, "Your helicopter destructible  but you take only 20% damage. You will be shot upon by a Ifrit HMG."],
[HELI_DIFICULTY_NORMAL, "Your helicopter is destructible. You will be shot upon by a Ifrit HMG."],
[HELI_DIFICULTY_HARD, "Your helicopter is destructible. You will be shot upon by a Ifrit GMG."],
[HELI_DIFICULTY_VERYHARD, "Your helicopter is destructible. You will be shot upon by two Ifrit GMG."],
[HELI_DIFICULTY_INSANE, "Your helicopter is destructible. You will be shot upon by aa anti-air unit."]
];

_MISSIONS_EVADE = [
["BREAKTURN","Breakturn","Fly from a to b. You will be shot at, perform a breakturn in order to avoide being shot.", "Fly to the waypoint. Somewhere along the route enemies will start shooting at your. Perform a  breakturn as soon as you get shot at. A breakturn is a manoeuvre where you make a hard turn of 90 degrees or more.", {[] call HELI_fnc_Breakturn}, _difficultiesEvade],
["BREAKLOW","Breaklow","Fly from a to b. You will be shot at, perform a breaklow in order to avoide being shot.", "Fly to the waypoint and keep a altitide of atleast 100m. Somewhere along the route enemies will start shooting at your. Perform a  brewklow as soon as you get shot at. A brewklow is a manoeuvre where you make a hard turn of 90 degrees or more and combine this with a fast dive and optional a barrel rol.", {[] call HELI_fnc_Breakdive}, _difficultiesEvade],
/*["DEFENSIVEROLL","Definsive roll","Fly from a to b. You will be shot at, perform a defensive roll in order to avoide being shot.", "Fly to the waypoint. Somewhere along the route enemies will start shooting at your. Perform a defensive roll as soon as you get shot. A defensive defensive roll means you move upwards to make sure your bottom (armor) is pointed at the enemy while you turnaround 180 degrees.", {[] call HELI_fnc_DefensiveRoll},_difficultiesEvade],*/
["JINKING","Jinking","Fly from a to b. You will be shot at, start jinking in order to avoide getting shot.", "Fly to the waypoint and keep below 50 meters. Somewhere along the route enemies will start shooting at your. Start jinking in order to avoid being shot. Jinking means you randomly change direction and altitude in order to avoid getting hit.", {[] call HELI_fnc_Jinking}, _difficultiesEvade]
];

_dificultiesEngageInfantry =
[
[HELI_DIFICULTY_VERYEASY, "Your helicopter is indestructible. You need to wipe out one platoon of riflemen which are marked with red smoke."],
[HELI_DIFICULTY_EASY, "Your helicopter destructible  but you take only 20%. damage You need to wipe out one platoon of riflemen which are marked with red smoke."],
[HELI_DIFICULTY_NORMAL, "Your helicopter is destructible. You need to wipe out one platoon of riflemen which are marked with red smoke"],
[HELI_DIFICULTY_HARD, "Your helicopter is destructible. You need to wipe out one platoon of riflemen."],
[HELI_DIFICULTY_VERYHARD, "Your helicopter is destructible. You need to wipe out one anti-air platoon."],
[HELI_DIFICULTY_INSANE, "Your helicopter is destructible. You need to wipe out several anti-air platoons."]
];

_dificultiesEngageVehicle =
[
[HELI_DIFICULTY_VERYEASY, "Your helicopter is indestructible. You need to wipe out a Ifrit HMG."],
[HELI_DIFICULTY_EASY, "Your helicopter destructible  but you take only 20%. damage You need to wipe out a Ifrit HMG."],
[HELI_DIFICULTY_NORMAL, "Your helicopter is destructible. You need to wipe out a Ifrit HMG."],
[HELI_DIFICULTY_HARD, "Your helicopter is destructible. You need to wipe out a Ifrit GMG."],
[HELI_DIFICULTY_VERYHARD, "Your helicopter is destructible. You need to wipe out two Ifrit GMG."],
[HELI_DIFICULTY_INSANE, "Your helicopter is destructible. You need to wipe out  an anti-air unit."]
];

HELI_ENEMY_INFANTRY = 0;
HELI_ENEMY_VEHICLE = 1;
HELI_ENEMY_CONVOY = 2;

_MISSIONS_ENGAGE = [
["ENGAGEINFANTRY","Infantry","Engage infantry at designated location.", "Fly to the waypoint and kill all infantry present..", {[HELI_ENEMY_INFANTRY,false] call HELI_fnc_EngageEnemy}, _dificultiesEngageInfantry],
["ENGAGEINFANTRYCITY","Infantry city","Engage infantry at designated city.", "Fly to the designated city and kill all infantry present..", {[HELI_ENEMY_INFANTRY,true] call HELI_fnc_EngageEnemy}, _dificultiesEngageInfantry],
["ENGAGEVEHICLE","Engage vehicle", "Engage vehicle at designated location.", "Fly to the waypoint and kill all vehicles present.", {[HELI_ENEMY_VEHICLE, false] call HELI_fnc_EngageEnemy}, _dificultiesEngageVehicle],
["ENGAGEVEHICLECITY","Engage vehicle city", "Engage vehicle at designated city.", "Fly to the designated city and kill all vehicles present.", {[HELI_ENEMY_VEHICLE, true] call HELI_fnc_EngageEnemy}, _dificultiesEngageVehicle]//,
/*["ENGAGECONVOY","Engage convoy", "Engage convoy at designated location.", "Fly to the waypoint and kill all vehicles in the convoy.", {[HELI_ENEMY_CONVOY, false] call HELI_fnc_EngageEnemy}, _dificultiesEngageInfantry],
["ENGAGECONVOYCITY","Engage convoy city", "Engage convoy at designated city.", "Fly to the designated city and kill all vehicles in the convoy.", {[HELI_ENEMY_CONVOY, true] call HELI_fnc_EngageEnemy}, _dificultiesEngageInfantry]*/
];

HELI_FAILURE_RANDOM = 0;
HELI_FAILURE_TAILROTOR = 1;
HELI_FAILURE_ENGINE = 2;

_difficultiesFailure = [
[HELI_DIFICULTY_NORMAL, "Hover still or fly around. Failure will occur at a random time."],
[HELI_DIFICULTY_HARD, "Failure will only occur once flying faster then 150km/h."]
];

_MISSIONS_FAILURE = [
["FAILURERANDOM","Random failure","A random part will fail during flight. Try to survive.", "Fly around and try to safe yourself when the random failure occurs.", {[HELI_FAILURE_RANDOM] call HELI_fnc_Failure}, _difficultiesFailure],
["FAILURETRAILROTOR","Tail rotor failure","The tail rotor will fail during flight. Try to survive.", "Fly around and try to safe yourself when the tail rotor failure occurs.", {[HELI_FAILURE_TAILROTOR] call HELI_fnc_Failure}, _difficultiesFailure],
["FAILUREENGINE","Engine failure","The engine will fail during flight. Try to survive.", "Fly around and try to safe yourself when engine failure occurs.", {[HELI_FAILURE_ENGINE] call HELI_fnc_Failure}, _difficultiesFailure]
];

HELI_MISSIONS = [
["TRANSPORT","Transport","Various transport missions including drop off/pick up in either safe or unsafe scenarios (selectable).",_MISSIONS_TRANSPORT],
["EVADE","Evade","Various evasive missions. Practice evasive types.",_MISSIONS_EVADE],
["ENGAGE","Engage","Various attack mission where you have to engage enemies.",_MISSIONS_ENGAGE],
["FAILURE","Failures","Various mechanical failures and learning to survive them.",_MISSIONS_FAILURE]
];

if(!isDedicated) then
{
	waitUntil {!isNil {player}};
	waitUntil {!isNull player};
	waitUntil {!(isNull (findDisplay 46))};	
};