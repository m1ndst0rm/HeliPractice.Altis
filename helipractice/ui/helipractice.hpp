class RscText {
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	type = 0;
	style = 0;
	shadow = 1;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	colorText[] = {1, 1, 1, 1.0};
	colorBackground[] = {0, 0, 0, 0};
	linespacing = 1;
};

class RscStructuredText {
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	type = 13;
	style = 0;
	shadow = 1;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)";
	size = 0.03;
	text = "";
	colorText[] = {1, 1, 1, 1.0};
	colorBackground[] = {0, 0, 0, 0};
	linespacing = 1;
};

class MCListBox {
	idc = -1;
	type = 102;
	style = 0;
	font = "PuristaMedium";
	x = 0;
	y = 0;
	w = .2;
	h = .4;
	// number of columns used, and their left positions 
	// if using side buttons, space has to be reserved for those,
	// at a width of roughly 120% of rowHeight
	columns[] = {}; 
	// height of each row
	sizeEx = 0.03; 
	drawSideArrows = 0; 
	
	colorSelect[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0.28,0.28,0.28,0.28};
	colorSelect2[] = {0, 0, 0, 1};
	colorSelectBackground[] = {0.95, 0.95, 0.95, 0.5};
	colorSelectBackground2[] = {0.9, 0.9, 0.9, 0};
	colorscrollbar[] = {0.2, 0.2, 0.2, 1};
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	wholeHeight = 0.45;
	rowHeight = 0.03;
	color[] = {0.7, 0.7, 0.7, 1};
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	
	idcLeft = 0;
	idcRight = 0;
	
	class VScrollbar {
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		shadow = 0;
	};
	
	class ListScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	
	class Controls {};
};

class RscListBox {
	style = 16;
	idc = -1;
	type = 5;
	w = 0.275;
	h = 0.04;
	font = "PuristaMedium";
	colorSelect[] = {0, 0, 0, 1};
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0.28,0.28,0.28,0.28};
	colorSelect2[] = {0, 0, 0, 1};
	colorSelectBackground[] = {0.95, 0.95, 0.95, 0.5};
	colorSelectBackground2[] = {0.9, 0.9, 0.9, 0};
	colorscrollbar[] = {0.2, 0.2, 0.2, 1};
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	wholeHeight = 0.45;
	rowHeight = 0.03;
	color[] = {0.7, 0.7, 0.7, 1};
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	sizeEx = 0.023;
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;

	class ListScrollBar {
		color[] = {1, 1, 1, 0.6};
		autoScrollEnabled = 1;
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		shadow = 0;
		scrollSpeed = 0.06;
		width = 0;
		height = 0;
	};
};

class RscShortcutButton {
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "(		(		((safeZoneW / safeZoneH) min 1.2) / 1.2) / 20)";
	color[] = {1, 1, 1, 1.0};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 1};
	colorBackground2[] = {1, 1, 1, 1};
	colorFocused[] = { 1, 1, 1, 1 }; 
	colorBackgroundFocused[] = { 1, 1, 1, 0 };  
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	periodFocus = 1.2;
	periodOver = 0.8;
	
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	
	class ShortcutPos {
		left = 0;
		top = "(			(		(		((safeZoneW / safeZoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	
	class TextPos {
		left = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(			(		(		((safeZoneW / safeZoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	period = 0.4;
	font = "PuristaMedium";
	size = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	soundEnter[] = 
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] = 
	{
		"task_force_radio\sounds\softPush",
		0.5,
		1
	};
	soundClick[] = 
	{
		"task_force_radio\sounds\softClick",
		0.5,
		1
	};
	soundEscape[] = 
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
	action = "";
	
	class Attributes {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	
	class AttributesImage {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};

class RscButtonMenu : RscShortcutButton {
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,0.5)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0, 0, 0, 0.8};
	colorBackground2[] = {1, 1, 1, 0.5};
	color[] = {1, 1, 1, 1};
	color2[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)";
	
	class TextPos {
		left = "0.25 * 			(			((safeZoneW / safeZoneH) min 1.2) / 40)";
		top = "(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) - 		(			(			(			((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	
	class Attributes {
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	
	class ShortcutPos {
		left = "(6.25 * 			(			((safeZoneW / safeZoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
};

class RscPicture
{
	access = 0;
	type = 0;
	idc = -1;
	style = 48;//ST_PICTURE
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
};

class RscPositionText : RscText
{
	idc = -1;
	colorBackground[] = {0.2,0.2,0.2,1};
	colorText[] = {0.45, 0.45, 0.45, 1};
	text = "";
	sizeEx = 0.04;
	x = safeZoneX + safeZoneW - 0.29; 
	w = 0.25; h = 0.05;
	font = "puristaMedium";
	shadow = 0;
};

class RscPositionNumberText : RscText
{
	idc = -1;
	colorBackground[] = {0, 0, 0, 1};
	colorText[] = {0.45, 0.45, 0.45, 1};
	text = "";
	sizeEx = 0.04;
	x = safeZoneX + safeZoneW - 0.32; 
	w = 0.03; h = 0.05;
	font = "puristaMedium";
	shadow = 0;
};

class RscProgress
{
	access = 0;
	type = 8;
	style = 0;
	colorFrame[] = {1,1,1,1};
	colorBar[] = {1,1,1,1};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	w = 1.2;
	h = 0.03;
	shadow = 0;
};

class DiagMission
{
	idd = 45600;
	name= "Heli practice selection";
	movingEnable = false;
	enableSimulation = true;
	onLoad = "[] spawn HELI_fnc_DiagMissionInit";
	onUnLoad = "";
	
	class controls 
	{
		class SelectList : RscListBox
		{
			idc = 45601;
			text = "";
			sizeEx = 0.030;
			onLBSelChanged = "[] spawn HELI_fnc_DiagMissionSelectChanged";
			
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.340;
		};
		
		class ButtonClose : RscButtonMenu 
		{
			idc = 45605;
			text = "Confirm";
			onButtonClick = "[] spawn HELI_fnc_DiagMissionButtonChoose;";
			x = 0.5 - (0.275) + (0.075 / 2) + (0.275 / 2) - (0.275 / 2); y = 0.5 + (0.340 /2);
			w = 0.20;
			h = 0.04;
		};
		
		class ButtonRestartLast : RscButtonMenu 
		{
			idc = 45604;
			text = "Restart last";
			onButtonClick = "[] spawn HELI_fnc_StartMission; closeDialog 45600;";
			x = 0.5 - (0.275) + (0.075 / 2) + (0.275 / 2) + (0.275 / 2); y = 0.5 + (0.340 /2);
			w = 0.20;
			h = 0.04;
		};
		
		class MissionText : RscText
		{
			idc = 45602;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "placeholder";
			sizeEx = 0.04;
			x = 0.5 - (0.275); y = 0.5 - (0.340 /2) - 0.05;
			w = 0.275 * 2; h = 0.04;
		};
		
		class MissionInfo : RscStructuredText
		{
			idc = 45603;
			style = 0;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
			text = "Click an item to get information about it.";
			sizeEx = 0.02;
			x = 0.5; y = 0.5 - (0.340 /2);
			w = 0.275; h = 0.340;
		};
	};
};

class rscTitles
{
	class DiagInfo
	{
		idd = 45700;
		name= "Diag info";
		movingEnable = false;
		enableSimulation = true;
		duration = 9999999;
		fadeIn = 0;
		fadeOut = 0;
		onLoad = "uiNamespace setVariable ['HELI_DIAGINFO', _this select 0];";
		onUnLoad = "uiNamespace setVariable ['HELI_DIAGINFO', nil]";
		class controls
		{
			class Lives : RscStructuredText
			{
				idc = 45701;
				style = 0;
				colorBackground[] = {0,0,0,0};//{"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
				text = "";
				sizeEx = 0.08;
				x = safeZoneX + safeZoneW * 0.01; y = safeZoneY + 0.2;
				w = 0.3; h = 0.05;
			};
			
			class Info : RscStructuredText
			{
				idc = 45702;
				style = 0;
				colorBackground[] = {0,0,0,0};//{"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", 0.5};
				colorText[] = {0.45, 0.45, 0.45, 1};
				text = "";
				sizeEx = 0.5;
				x = safeZoneX + safeZoneW * 0.3; y = safeZoneY + 0.05;
				w = 0.41; h = 0.1;
			};
			
		};
	};
};