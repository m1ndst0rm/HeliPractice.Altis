[HELI_CURRENT_VEHICLE] spawn 
{
	waitUntil {!alive (_this select 0) || HELI_MISSION_DONE};
	HELI_MISSION_DONE = true;
};