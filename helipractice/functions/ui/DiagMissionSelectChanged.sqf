private ["_dialog","_list","_item","_textControl","_missionType","_text","_missionSubTypes","_missionSubType","_difficulties","_difficulty","_picture","_maxSpeed","_armor","_turrets"];
disableSerialization;
_dialog = findDisplay 45600;

_list = _dialog displayctrl 45601;
_item = Lbselection _list select 0;
if(isNil {_item}) then {_item = 0;};
_item = lbData[45601,_item];
_textControl = _dialog displayctrl 45603;
if !(isNil {_item}) then 
{
	switch (HELI_VOTE_TYPE) do
	{
		case "MISSIONTYPE":
		{
			{
				_missionType = _x select 0;
				if (_missionType == _item) then
				{
					//ctrlSetText [4003, _x select 2];
					_text = (_x select 2);
					_textControl ctrlSetStructuredText parseText _text;
				};
			} foreach HELI_MISSIONS;
		};
		case "MISSIONSUBTYPE":
		{
			_missionSubTypes = HELI_CURRENT_MISSION select 3;
		
			{
				_missionSubType = _x select 0;
				if(_missionSubType == _item) then
				{
					_text = _x select 2;
					_textControl ctrlSetStructuredText parseText _text;
				};
			} foreach _missionSubTypes;
		};
		case "MISSIONDIFFICULTY":
		{
			_difficulties = HELI_CURRENT_MISSION_SUBTYPE select 5;
			{
				_difficulty = _x select 0;
				
				if(_difficulty == parseNumber(_item)) then
				{
					_text = _x select 1;
					_textControl ctrlSetStructuredText parseText _text;
				};
			} foreach _difficulties;
		};
		case "VEHICLETYPE":
		{
			_picture = getText(configFile >> "CfgVehicles" >> _item >> "picture");
			_maxSpeed = getNumber(configFile >> "CfgVehicles" >> _item >> "maxSpeed");
			_armor = getNumber(configFile >> "CfgVehicles" >> _item >> "armor");
			_turrets = getArray (configFile >> "CfgVehicles" >> _item >> "weapons"); //"Turrets" >> "MainTurret" >> 
			_availableCargo = getNumber(configFile >> "CfgVehicles" >> _item >> "transportSoldier");
			
			_text = format["<img size='3' image='%1' /><br/>Maximum speed: %2<br/>Armor: %3<br/>Weapons: %4<br/>Cargo slots: %5", _picture, _maxSpeed, _armor, count _turrets, _availableCargo];
			
			/*
			_partCount = (count (configFile >> "CfgVehicles" >> _item >> "HitPoints")) - 1; 
			_parts = []; _partTypes = [];
			for "_i" from 0 to _partCount do { 
				_sctcl = (configFile >> "CfgVehicles" >> _item >> "HitPoints") select _i; 
				
				_sct = getText(_sctcl >> "name"); 
				__parts set [count _parts, _sct]; 
				_partTypes set [count _partTypes, _sctcl]; 
			};
			diag_log format ["Parts: %1, Partypes: %2", _parts, _partTypes];*/
			
			_textControl ctrlSetStructuredText parseText _text;
		};
	};
};