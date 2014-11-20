/* DYN_fnc_SetVehicleDamageHandler: 

*/
private ["_unit"];
_unit = _this select 0;
_unit setVariable ["selections", []];
_unit setVariable ["gethit", []];
_unit setVariable ["damageMultiplication", _this select 1];
_unit addEventHandler
[
	"HandleDamage",
	{	
		private ["_selections","_gethit","_selection","_i","_olddamage","_countAsDeath","_inflictedDamage","_damage"];
		_unit = _this select 0;
		_selections = _unit getVariable ["selections", []];
		_gethit = _unit getVariable ["gethit", []];
		_selection = _this select 1;
		
		if !(_selection in _selections) then
		{
			_selections set [count _selections, _selection];
			_gethit set [count _gethit, 0];
		};
		_i = _selections find _selection;
		_olddamage = _gethit select _i;
		
		_countAsDeath = false;
		switch (_selection) do
		{
			case "fuel_hit";
			case "hull_hit";
			case "engine_hit";
			case "engine_1_hit";
			case "engine_2_hit";
			case "avionics_hit";
			case "main_rotor_hit";
			case "HitBody";
			case "HitBody";
			case "HitBody";
			case "HitFuel";
			case "HitEngine";
			case "HitEngine2";
			case "HitEngine3";
			case "HitBody";
			case "HitHull": { _countAsDeath = true; };
		};
		_inflictedDamage= ((_this select 2) - _olddamage) * (_unit getVariable "damageMultiplication");
		_damage = _olddamage + _inflictedDamage;
		//diag_log format ["%1 damage to %2", _damage, _selection];
		
		if(_damage >= 1 && _countAsDeath) then
		{
			_unit setDamage 1;
			HELI_MISSION_DONE = true;
		};
		_gethit set [_i, _damage];
		_damage;
	}
];