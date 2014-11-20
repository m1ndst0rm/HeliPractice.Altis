sleep 0.01;
disableSerialization;
closeDialog 45600;
createDialog "DiagMission";
waitUntil {(!(isNull (findDisplay 45600)))};
true;