// determine mission time and date

//initialize controls
_display = MEF_MAGIC_BOMB_TOOL;
_ctrl_day_month_date = _display displayCtrl IDC_MAIN_WATCH_DY_MM_DD;
_ctrl_hr_min_sec = _display displayCtrl IDC_MAIN_WATCH_HR_MIN_SEC;
_ctrl_body = _display displayCtrl IDC_MAIN_WATCH_BODY;

//start loop
while {SHOW_DIGITAL_WATCH && !isNull _display} do
{
	//HH:MM:SS in 24 hr clock time
	_scenarioTime = [daytime] call fn_vbs_timeToString;
	_strLen = strLen _scenarioTime;  //should return 8 digits

	//trim string for hours:minutes and seconds
	_HH_MM = trim [_scenarioTime, 0, (_strLen - 5)];
	_SS = trim [_scenarioTime, (_strLen - 2), 0];

	//numeric representation of the day of the week: 1 (for Monday) through 7 (for Sunday)
	_dayOfWeek = ["N", date] call fn_vbs_dateToString;
	
	//convert to a 2 letter uppercase string
	switch (_dayOfWeek) do
	{
		case "1": {_dayOfWeek = "MO"};
		case "2": {_dayOfWeek = "TU"};
		case "3": {_dayOfWeek = "WE"};
		case "4": {_dayOfWeek = "TH"};
		case "5": {_dayOfWeek = "FR"};
		case "6": {_dayOfWeek = "SA"};
		case "7": {_dayOfWeek = "SU"};
	};
	
	//Numeric representation of a month, without leading zeros: 1 through 12
	_month = ["n", date] call fn_vbs_dateToString;

	//Day of the month without leading zeros: 1 to 31
	_dayOfMonth = ["j", date] call fn_vbs_dateToString;
	
	//output values to ctrls

	_ctrl_day_month_date ctrlSetText format["%1 %2-%3",_dayOfWeek, _month, _dayOfMonth];

	//font size is hard coded.  not sure if it will adjust with screen resoultions
	_ctrl_hr_min_sec ctrlSetStructuredText parseText format ["<t size='.39' >%1</t><t size='.25' valign='middle'>%2</t>",_HH_MM, _SS];

	sleep .2;	//update rate
};

//loop stopped, reset variables
cutRsc ["default", "PLAIN"];
SHOW_DIGITAL_WATCH = nil;
MEF_DIGITAL_WATCH = nil;


