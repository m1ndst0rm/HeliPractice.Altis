private ["_minDistanceFrom","_maxDistanceFrom","_pos","_toPos","_dx","_dy"];
_pos = _this select 0;
_minDistanceFrom =  _this select 1;
_maxDistanceFrom = _this select 2;
_safePos = _this select 3;

_toPos = [];
_toPos set [0, _pos select 0];
_toPos set [1, _pos select 1];

_dx = _minDistanceFrom + (floor(random (_maxDistanceFrom - _minDistanceFrom + 1)));
if((floor(random 2)) == 0) then {_dx = _dx * -1};
_dy = _minDistanceFrom + (floor(random (_maxDistanceFrom - _minDistanceFrom + 1)));
if((floor(random 2)) == 0) then {_dy = _dy * -1};

_toPos set [0, (_pos select 0) + _dx];
_toPos set [1, (_pos select 1) + _dy];
if(_safePos) then
{
	_toPos = [_toPos ,0 ,100 , 5, 0, 1, 0] call BIS_fnc_findSafePos;
};
_toPos;