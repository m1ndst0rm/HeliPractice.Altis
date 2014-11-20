private ["_nearCity","_posOriginal","_toPos","_notToClose","_startDistance","_list","_loc","_cityPos"];
_posOriginal = _this select 0;
_nearCity = _this select 1;
_toPos = [];
if(_nearCity) then
{
	_notToClose = [];
	_startDistance = 4000;
	 while {count _notToClose == 0} do
	{
		_list = nearestLocations [_posOriginal, ["NameCityCapital", "NameCity"],_startDistance];
		{
			_loc = locationPosition _x;
			if((_loc distance _posOriginal) > 2000) then
			{
				_notToClose set [count _notToClose, _loc];
			};
		} foreach _list;
		_startDistance = _startDistance + 1000;
	};
	
	
	_cityPos = _notToClose call BIS_fnc_selectRandom;
	//set z value to 0. Normal z pos is see level position.
	_cityPos set [2, 0];
	//Random it up a bit
	_toPos = [_cityPos, 0, 100, true] call HELI_fnc_RandomPos;
	if(count _toPos == 0) then
	{
		_toPos = [_cityPos ,0 ,300 , 5, 0, 1, 0] call BIS_fnc_findSafePos;
	};
}
else
{
	_toPos = [_posOriginal, 2000, 3000, true] call HELI_fnc_RandomPos;
	//_toPos = [_toPos ,0 ,100 , 5, 0, 2, 0] call BIS_fnc_findSafePos;
};
_toPos;