private ["_posStart","_posStop","_minDistanceFromStart","_minDistanceFromStop","_dir","_distanceBetween","_distance","_xPos","_yPos"];
_posStart = _this select 0;
_posStop = _this select 1;
_minDistanceFromStart = _this select 2;
_minDistanceFromStop = _this select 3;

_dir = ((((_posStart select 0) - (_posStop select 0)) atan2 ((_posStart select 1) - (_posStop select 1))) + 360) % 360;
_dir = _dir - 180;

_distanceBetween = (_posStart distance _posStop) - _minDistanceFromStart - _minDistanceFromStop;
_distance = floor(random (_distanceBetween + 1)) + _minDistanceFromStart;

_xPos = (_posStart select 0) + (_distance * sin(_dir));
_yPos = (_posStart select 1) + (_distance * cos(_dir));

[_xPos,_yPos];