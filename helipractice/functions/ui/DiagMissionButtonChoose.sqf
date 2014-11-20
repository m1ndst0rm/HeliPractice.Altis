private ["_dialog","_list","_vehicleName","_item","_missionType","_missionSubTpes","_missionSubType","_missionName","_difficulties","_difficulty","_difficultyText","_onlyUnarmorred","_vehicles","_classname","_picture","_availableCargo","_hasEnoughCargo","_isHeli"];
disableSerialization;
_dialog = findDisplay 45600;

_list = _dialog displayctrl 45601;
_item = Lbselection _list select 0;
if(isNil {_item}) then {_item = 0;};
_item = lbData[45601,_item];

if !(isNil {_item}) then 
{
	switch (HELI_VOTE_TYPE) do
	{
		case "MISSIONTYPE":
		{
			HELI_VOTE_TYPE = "MISSIONSUBTYPE";
			{
				_missionType = _x select 0;
				if(_missionType == _item) then
				{
					HELI_CURRENT_MISSION = _x;
				};
			} foreach HELI_MISSIONS;
			
			lbClear _list;
			ctrlSetText [45602, "Choose mission subtype"];
			
			_missionSubTpes = HELI_CURRENT_MISSION select 3;
			
			{
				_missionSubType = _x select 0;
				_missionName = _x select 1;
				_list lbAdd format["%1",_missionName];
				_list lbSetData [(lbSize _list)-1,_missionSubType];
				ctrlShow [4001,true];
			} foreach _missionSubTpes;
			lbSetCurSel[45601,0];
		};
		
		case "MISSIONSUBTYPE":
		{
			HELI_VOTE_TYPE = "MISSIONDIFFICULTY";
			_missionSubTpes = HELI_CURRENT_MISSION select 3;
			
			{
				_missionSubType = _x select 0;
				if(_missionSubType == _item) then
				{
					HELI_CURRENT_MISSION_SUBTYPE = _x;
				};
			} foreach _missionSubTpes;
			
			lbClear _list;
			ctrlSetText [45602, "Choose difficulty"];
			
			_difficulties = HELI_CURRENT_MISSION_SUBTYPE select 5;
			
			{
				_difficulty = _x select 0;
				_difficultyText = "";
				switch (_difficulty) do
				{
					case HELI_DIFICULTY_VERYEASY:
					{
						_difficultyText = "Very easy";
					};
					case HELI_DIFICULTY_EASY:
					{
						_difficultyText = "Easy";
					};
					case HELI_DIFICULTY_NORMAL:
					{
						_difficultyText = "Normal";
					};
					case HELI_DIFICULTY_HARD:
					{
						_difficultyText = "Hard";
					};
					case HELI_DIFICULTY_VERYHARD:
					{
						_difficultyText = "Very hard";
					};
					case HELI_DIFICULTY_INSANE:
					{
						_difficultyText = "Insane";
					};
				};
					
				_list lbAdd format["%1",_difficultyText];
				_list lbSetData [(lbSize _list)-1, format["%1",_difficulty]];
				ctrlShow [4001,true];
			} foreach _difficulties;
			
			lbSetCurSel[45601,0];
		};
		case "MISSIONDIFFICULTY":
		{
			ctrlShow [45605, false];
			HELI_VOTE_TYPE = "VEHICLETYPE";
			_difficulties = HELI_CURRENT_MISSION_SUBTYPE select 5;
			{
				_difficulty = _x select 0;
				if(_difficulty == parseNumber(_item)) then
				{
					HELI_CURRENT_MISSION_DIFFICULTY = _difficulty;
				};
			} foreach _difficulties;
			
			lbClear _list;
			ctrlSetText [45602, "Choose vehicle"];
			
			_onlyUnarmorred = false;
			if(HELI_CURRENT_MISSION select 0 == "TRANSPORT") then
			{
				_onlyUnarmorred = true;
			};
			
			_vehicles = ["Air", _onlyUnarmorred] call HELI_fnc_GetVehiclesFromConfig;
			{
				_classname = _x;
				_vehicleName = getText(configFile >> "CfgVehicles" >> _classname >> "displayname");
				_picture = getText(configFile >> "CfgVehicles" >> _classname >> "picture");
				_availableCargo = getNumber(configFile >> "CfgVehicles" >> _classname >> "transportSoldier");
				_turrets = getArray (configFile >> "CfgVehicles" >> _classname >> "weapons");
				
				_hasEnoughCargo = true;
				if(HELI_CURRENT_MISSION select 0 == "TRANSPORT") then
				{
					_hasEnoughCargo = _availableCargo > 0;
				};
				_allowUnArmorred = true;
				if(HELI_CURRENT_MISSION select 0 == "ENGAGE") then
				{
					_allowUnArmorred = (count _turrets) > 0;
				};
				
				_isHeli = ["heli", _classname] call BIS_fnc_inString;
				if(_isHeli && _hasEnoughCargo && _allowUnArmorred) then
				{
					_list lbAdd format["%1",_vehicleName];
					_list lbSetPicture [(lbSize _list)-1,_picture];
					_list lbSetData [(lbSize _list)-1,_classname];
					ctrlShow [45601,true];
				}
			} foreach _vehicles;
			
			lbSetCurSel[45601,0];
			ctrlShow [45605, true];
		};
		case "VEHICLETYPE":
		{
			HELI_CURRENT_VEHICLE_TYPE = _item;
			closeDialog 45600;
			[] call HELI_fnc_StartMission;
		};
	};
};