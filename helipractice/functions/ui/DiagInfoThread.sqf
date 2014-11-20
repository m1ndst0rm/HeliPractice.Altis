#define HELI_LOOPTIMER 1
[] spawn {
	private ["_uiObj","_textLives","_textCrewAlive","_aliveText"];
	disableSerialization;
	45700 cutRsc ["DiagInfo","PLAIN"]; 

	_uiObj = uiNamespace getVariable "HELI_DIAGINFO";
	_textLives = _uiObj displayCtrl 45701;
	_textLives ctrlShow false;
	_textCrewAlive = _uiObj displayCtrl 45702;
	_textCrewAlive ctrlShow false;
	
	while {!HELI_MISSION_DONE} do
	{
		/*
		if(HELI_DISPLAY_LIVES) then
		{
			_textLives ctrlShow true;
			_textLives ctrlSetStructuredText parseText format ["<t align='left' size='1'>Lives left: %1<t>", HELI_CURRENT_LIVES];
		};*/
		
		if(typeName HELI_DISPLAYFUNC == "CODE") then
		{
			_textCrewAlive ctrlShow true;
			_aliveText = [] call HELI_DISPLAYFUNC;
			if(isNil {_aliveText}) then { _aliveText = ""; };
			_textCrewAlive ctrlSetStructuredText parseText _aliveText;
		};
		sleep HELI_LOOPTIMER;
	};
	_textLives ctrlShow false;
	_textCrewAlive ctrlShow false;
};