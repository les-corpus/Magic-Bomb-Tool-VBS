//defines for my script

//basic defines

//conversion factors from one unit to another
#define MPS_TO_KN					1.9438445	//1 meter per sec to knots
#define KPH_TO_KN					0.5399568	//1 kilometer per hour to knots
#define MPS_TO_MPH					2.236936292054402	//1 meter per sec to miles per hour
#define MPS_TO_KPH					3.6 		//1 meter per sec to kilometers per hour

#define M_TO_FT						3.28084		//meter to feet conversion
#define M_TO_NM						0.000539957	//1 meter to nautical miles
#define DEG_TO_MILS					17.7777778	//number of mils in 1 degree

//Common parameters
#define MGRS_PRECISION 				5			//to return a 10 digit grid
#define CENTER_SCREEN				[0.5,0.5]
#define ZERO_POS_ARRAY				[0,0,0]	

//colors
#define MEF_MAGIC_LIGHT_BLUE		[0.60000002,0.60000002,1,1]; //light blue	
#define MEF_MAGIC_LIGHT_RED			[1,0.60000002,0.60000002,1]; //light red
#define MEF_MAGIC_LIGHT_GREEN		[0.60000002,1,0.60000002,1]; //light green
#define MEF_MAGIC_LIGHT_YELLOW		[1,1,0.60000002,1]; //light Yellow
#define MEF_MAGIC_LIGHT_GREY		[0.60000002,0.60000002,0.60000002,1]; //light grey

//hard coded mission defaults
#define MEF_MAGIC_DEFAULT_GUNS				0	//1 gun
#define MEF_MAGIC_DEFAULT_RDS				1	//1 round / gun
#define MEF_MAGIC_DEFAULT_SHELL				5	//155mm HE
#define MEF_MAGIC_DEFAULT_INT				1	//15 sec					
#define MEF_MAGIC_DEFAULT_SHEAF				1	//converged
#define MEF_MAGIC_DEFAULT_CONTROL			0	//delay
#define MEF_MAGIC_DEFAULT_CONTROL_DELAY		0	//5 sec
#define MEF_MAGIC_DEFAULT_SHELL_DATA		["arty_155_he", 50]

//artillery script constants
#define MEF_MAGIC_SCRIPT_RDS		1	//1 rnd
#define MEF_MAGIC_SCRIPT_GUNS		1	//1 gun
//#define ARMNIT_PROBABLE_ERROR		1  	//raduis.
#define MEF_MAGIC_SCRIPT_DGUNS		0	//delay between guns.
#define MEF_MAGIC_SCRIPT_RELOAD 	1	//delay between vollies


//dialog defines
#define DLG_X 		1
#define DLG_Y 		1
#define DLG_W		1	
#define DLG_H		1

#define DLG_CTRL_SIZE	.125	//x,y,w,h will use multiples of this number to calculate positions


//font for GUI
#define MAIN_FONT_MAGIC_BOMB_TOOL	"NewsGothicB"		
#define MAGIC_BOMB_FONT_HT			0.0275

//arrays for combo boxes
#define MEF_MAGIC_SHELL 			["60mm HE", "81mm HE", "105mm HE", "120mm HE", "5 inch/54 NGF", "155mm HE", "DPICM", "Illum on Deck", "Illumination", "Smoke","WP Felt Wedge"]
#define MEF_MAGIC_INTERVAL 			["5", "15", "30", "45", "60"]		//number of seconds between vollies
#define MEF_MAGIC_RECT_LENGTH 		["100","200","300","400","500","600"]
#define MEF_MAGIC_WIDTH 			["50","100","150","200","250","300"]
#define MEF_MAGIC_LINE_LENGTH 		["100","200","300","400","500","600"]
#define MEF_MAGIC_CONTROL  			["Delay", "Time on Tgt"]
#define MEF_MAGIC_CONTROL_DELAY 	["5", "15", "30", "45", "60"]
#define MEF_MAGIC_CONTROL_SEC 		["00", "15", "30", "45"]
#define MEF_MAGIC_SHEAF 			["Circle","Converged","Linear","Open","Parallel","Rectangle"]

//basic shell data
#define MEF_MAGIC_60MM_ILUM_TIME	25	//burn time in seconds
#define MEF_MAGIC_81MM_ILUM_TIME	60
#define MEF_MAGIC_105MM_ILUM_TIME	75
#define MEF_MAGIC_120MM_ILUM_TIME	60
#define MEF_MAGIC_5INCH54_ILLUM_TIME 60
#define MEF_MAGIC_155MM_ILUM_TIME	120

#define MEF_MAGIC_60MM_HE_ECR		30	//effective casualty radius in meters
#define MEF_MAGIC_81MM_HE_ECR		35
#define MEF_MAGIC_105MM_HE_ECR		35
#define MEF_MAGIC_120MM_HE_ECR		45
#define MEF_MAGIC_5INCH54_HE_ECR	45
#define MEF_MAGIC_155MM_HE_ECR		50
#define MEF_MAGIC_155MM_DPICM_ECR	100
#define MEF_MAGIC_227MM_HE_ECR		100

#define MEF_MAGIC_60MM_HE_STR		"mortar_60_he"	//string name of shell
#define MEF_MAGIC_81MM_HE_STR		"mortar_81_he"
#define MEF_MAGIC_105MM_HE_STR		"mortar_105_he"
#define MEF_MAGIC_120MM_HE_STR		"mortar_120_he"
#define MEF_MAGIC_5INCH54_HE_STR	"mortar_120_he"
#define MEF_MAGIC_155MM_HE_STR		"arty_155_he"
#define MEF_MAGIC_155MM_DPICM_STR	"arty_155_dpicm"
#define MEF_MAGIC_155MM_SMOKE_STR	"Smoke"
#define MEF_MAGIC_227MM_HE_STR		"arty_155_he"
#define MEF_MAGIC_227MM_DPICM_STR	"arty_155_dpicm"

#define MEF_MAGIC_60MM_HE_ROF		20	//rate of fire in rds per min
#define MEF_MAGIC_81MM_HE_ROF		15
#define MEF_MAGIC_105MM_HE_ROF		2
#define MEF_MAGIC_5INCH54_HE_ROF	12
#define MEF_MAGIC_120MM_HE_ROF		4
#define MEF_MAGIC_155MM_HE_ROF		2
#define MEF_MAGIC_155MM_DPICM_ROF	2
#define MEF_MAGIC_227MM_HE_ROF		2

#define MEF_MAGIC_60MM_MIN_RNG		70	//minimum range in meters
#define MEF_MAGIC_81MM_MIN_RNG		83
#define MEF_MAGIC_105MM_MIN_RNG		35
#define MEF_MAGIC_120MM_MIN_RNG		200
#define MEF_MAGIC_5INCH54_MIN_RNG	910
#define MEF_MAGIC_155MM_MIN_RNG		100
#define MEF_MAGIC_227MM_MIN_RNG		100

#define MEF_MAGIC_60MM_MAX_RNG		3500	//max range in meters
#define MEF_MAGIC_81MM_MAX_RNG		5700
#define MEF_MAGIC_105MM_MAX_RNG		14000
#define MEF_MAGIC_120MM_MAX_RNG		8135
#define MEF_MAGIC_5INCH54_MAX_RNG	23000
#define MEF_MAGIC_155MM_MAX_RNG		18100
#define MEF_MAGIC_227MM_MAX_RNG		32000


//resourceTitle defines
#define IDD_GENERIC					-1
#define IDC_GENERIC					-1

//defines for call for fire gui
#define IDD_MAGIC_BOMB_TOOL				60000		// display

//ARMNIT Toolbar
#define	IDC_MAIN_PREVIOUS_BUTTON		60101
#define	IDC_MAIN_NEXT_BUTTON			60102
#define IDC_MAIN_CURRENT_TX				60103
#define IDC_MAIN_NEW_BUTTON				60104
#define IDC_MAIN_DELETE_BUTTON			60105

//Top of GUI
#define IDC_MAIN_FIRE_COMBO				60201
#define IDC_MAIN_OBSERVER_COMBO			60202
#define IDC_MAIN_TGT_LOC_TX				60203
#define IDC_MAIN_TGT_LOC_BUTTON			60204

//Options
#define IDC_MAIN_OPTIONS_TX				60301
#define IDC_MAIN_ENGAGEMENT_BUTTON		60302
#define IDC_MAIN_SHEAF_BUTTON			60303
#define IDC_MAIN_METHOD_BUTTON			60304

//bottom of GUI
#define IDC_MAIN_OBS_DIR_TX				60401
#define IDC_MAIN_OBS_DIR_BUTTON			60402
#define IDC_MAIN_ADJUST_BUTTON			60403
#define IDC_MAIN_ADJUSTMENTS_TREE		60404
#define IDC_MAIN_CREATE_BUTTON			60405
#define IDC_MAIN_EOM_BUTTON				60409
#define IDC_MAIN_GUI_PANEL				60406
#define IDC_MAIN_DISABLE_GUI_BUTTON		60407
//map
#define IDC_MAIN_2D_MAP					60408

//method of target location
#define IDC_PG_01_METHOD_TX				60501
#define IDC_PG_01_MOVING_BUTTON			60502
#define IDC_PG_01_GRID_BUTTON			60503
#define IDC_PG_01_POLAR_BUTTON			60504
#define IDC_PG_01_SHIFT_BUTTON			60505
#define IDC_PG_01_SAVED_TX				60506
#define IDC_PG_01_SAVED_COMBO			60507
#define IDC_PG_01_CANCEL_BUTTON			60508
#define IDC_PG_01_OK_BUTTON				60509
#define IDC_PG_01_PANEL					60510

//target location grid
#define IDC_PG_02_GRID_TX				60601
#define IDC_PG_02_MGRS_TX				60602
#define IDC_PG_02_SQID_EDIT				60603
#define IDC_PG_02_MGRS_EDIT				60604
#define IDC_PG_02_DIR_TX				60605
#define IDC_PG_02_DIR_EDIT				60606
#define IDC_PG_02_MILS_TX				60607
#define IDC_PG_02_MILS_BUTTON			60608
#define IDC_PG_02_MILS_IMAGE			60609
#define IDC_PG_02_DEGS_TX				60610
#define IDC_PG_02_DEGS_BUTTON			60611
#define IDC_PG_02_DEGS_IMAGE			60612
#define IDC_PG_02_CANCEL_BUTTON			60613
#define IDC_PG_02_OK_BUTTON				60614
#define IDC_PG_02_PANEL					60615

//target location polar
#define IDC_PG_03_POLAR_TX				60701
#define IDC_PG_03_OBS_LOC_TX			60702
#define IDC_PG_03_SQID_EDIT				60703
#define IDC_PG_03_MGRS_EDIT				60704
#define IDC_PG_03_DIR_TX				60705
#define IDC_PG_03_DIR_EDIT				60706
#define IDC_PG_03_MILS_IMAGE			60707
#define IDC_PG_03_MILS_TX				60708
#define IDC_PG_03_MILS_BUTTON			60709
#define IDC_PG_03_DEGS_IMAGE			60710
#define IDC_PG_03_DEGS_TX				60711
#define IDC_PG_03_DEGS_BUTTON			60712
#define IDC_PG_03_DIS_TX				60713
#define IDC_PG_03_DIS_EDIT				60714
#define IDC_PG_03_DIS_M_TX				60715
#define IDC_PG_03_CANCEL_BUTTON			60716
#define IDC_PG_03_OK_BUTTON				60717
#define IDC_PG_03_PANEL					60718

//target location shift
#define IDC_PG_04_SHIFT_FROM_TX			60801
#define IDC_PG_04_SAVED_TX				60802
#define IDC_PG_04_SAVED_COMBO			60803
#define IDC_PG_04_DIR_TX				60804
#define IDC_PG_04_DIR_EDIT				60805
#define IDC_PG_04_MILS_TX				60806
#define IDC_PG_04_MILS_BUTTON			60807
#define IDC_PG_04_MILS_IMAGE			60808
#define IDC_PG_04_DEGS_TX				60809
#define IDC_PG_04_DEGS_BUTTON			60810
#define IDC_PG_04_DEGS_IMAGE			60811
#define IDC_PG_04_LEFT_TX				60812
#define IDC_PG_04_LEFT_EDIT				60813
#define IDC_PG_04_LEFT_M_TX				60814
#define IDC_PG_04_RIGHT_TX				60815
#define IDC_PG_04_RIGHT_EDIT			60816
#define IDC_PG_04_RIGHT_M_TX			60817
#define IDC_PG_04_ADD_TX				60818
#define IDC_PG_04_ADD_EDIT				60819
#define IDC_PG_04_ADD_M_TX				60820
#define IDC_PG_04_DROP_TX				60821
#define IDC_PG_04_DROP_EDIT				60822
#define IDC_PG_04_DROP_M_TX				60823
#define IDC_PG_04_CANCEL_BUTTON			60824
#define IDC_PG_04_OK_BUTTON				60825
#define IDC_PG_04_PANEL					60826

//Method of engagement
#define IDC_PG_05_ENGAGEMENT_TX			60901
#define IDC_PG_05_GUNS_TX				60902
#define IDC_PG_05_GUNS_COMBO			60903
#define IDC_PG_05_INTERVAL_TX			60904
#define IDC_PG_05_ROUNDS_TX				60905
#define IDC_PG_05_ROUNDS_COMBO			60906
#define IDC_PG_05_INTERVAL_COMBO		60907
#define IDC_PG_05_SEC_TX				60908
#define IDC_PG_05_SHELL_TX				60909
#define IDC_PG_05_SHELL_COMBO			60910
#define IDC_PG_05_CANCEL_BUTTON			60911
#define IDC_PG_05_OK_BUTTON				60912
#define IDC_PG_05_PANEL					60913

//Sheaf page 14
#define IDC_PG_14_SHEAF_TX				61801
#define IDC_PG_14_TYPE_TX				61802
#define IDC_PG_14_TYPE_COMBO			61803
#define IDC_PG_14_PANEL					61804

//open, parallel, converged
#define IDC_PG_06_CANCEL_BUTTON			61004
#define IDC_PG_06_OK_BUTTON				61005

//rectangle
#define IDC_PG_07_LENGHT_TX				61101
#define IDC_PG_07_LENGTH_COMBO			61102
#define IDC_PG_07_WIDTH_TX				61103
#define IDC_PG_07_WIDTH_COMBO			61104
#define IDC_PG_07_ATTITUDE_TX			61105
#define IDC_PG_07_ATTITIUDE_EDIT		61106
#define IDC_PG_07_MILS_TX				61107
#define IDC_PG_07_MILS_BUTTON			61108
#define IDC_PG_07_MILS_IMAGE			60109
#define IDC_PG_07_DEGS_TX				61110
#define IDC_PG_07_DEGS_BUTTON			61111
#define IDC_PG_07_DEGS_IMAGE			60112
#define IDC_PG_07_CANCEL_BUTTON			61113
#define IDC_PG_07_OK_BUTTON				61114
#define IDC_PG_07_PANEL					61115

//linear
#define IDC_PG_08_LENGHT_TX				61201
#define IDC_PG_08_LENGTH_COMBO			61202
#define IDC_PG_08_ATTITUDE_TX			61203
#define IDC_PG_08_ATTITIUDE_EDIT		61204
#define IDC_PG_08_MILS_TX				61205
#define IDC_PG_08_MILS_BUTTON			61206
#define IDC_PG_08_MILS_IMAGE			61207
#define IDC_PG_08_DEGS_TX				61208
#define IDC_PG_08_DEGS_BUTTON			61209
#define IDC_PG_08_DEGS_IMAGE			61210
#define IDC_PG_08_CANCEL_BUTTON			61211
#define IDC_PG_08_OK_BUTTON				61212
#define IDC_PG_08_PANEL					61213

//circle
#define IDC_PG_09_RADIUS_TX				61301
#define IDC_PG_09_RADIUS_EDIT			61302
#define IDC_PG_09_RADIUS_M_TX			61303
#define IDC_PG_09_CANCEL_BUTTON			61304
#define IDC_PG_09_OK_BUTTON				61305
#define IDC_PG_09_PANEL					61306

//method of fire control, page 15
#define IDC_PG_15_FIRE_CTRL_TX			61901
#define IDC_PG_15_TYPE_TX				61902
#define IDC_PG_15_TYPE_COMBO			61903
#define IDC_PG_15_PANEL					61904

//delay
#define IDC_PG_10_AMMOUNT_TX			61404
#define IDC_PG_10_SEC_COMBO				61405
#define IDC_PG_10_SEC_TX				61406
#define IDC_PG_10_CANCEL_BUTTON			61407
#define IDC_PG_10_OK_BUTTON				61408

//time on target
#define IDC_PG_11_TIME_TX				61501
#define IDC_PG_11_HR_EDIT				61502
#define IDC_PG_11_HR_TX					61503
#define IDC_PG_11_MIN_EDIT				61504
#define IDC_PG_11_MIN_TX				61505
#define IDC_PG_11_SEC_COMBO				61506
#define IDC_PG_11_SEC_TX				61507
#define IDC_PG_11_CANCEL_BUTTON			61508
#define IDC_PG_11_OK_BUTTON				61509
#define IDC_PG_11_PANEL					61510

//observer to target direction
#define IDC_PG_12_OBSERVER_TX			61601
#define IDC_PG_12_DIR_TX				61602
#define IDC_PG_12_DIR_EDIT				61603
#define IDC_PG_12_MILS_TX				61604
#define IDC_PG_12_MILS_BUTTON			61605
#define IDC_PG_12_MILS_IMAGE			61606
#define IDC_PG_12_DEGS_TX				61607
#define IDC_PG_12_DEGS_BUTTON			61608
#define IDC_PG_12_DEGS_IMAGE			61609
#define IDC_PG_12_CANCEL_BUTTON			61610
#define IDC_PG_12_OK_BUTTON				61611
#define IDC_PG_12_PANEL					61612

//adjustments
#define IDC_PG_13_ADJUST_TX				61701
#define IDC_PG_13_DIR_TX				61702
#define IDC_PG_13_DIR_EDIT				61703
#define IDC_PG_13_MILS_TX				61704
#define IDC_PG_13_MILS_BUTTON			61705
#define IDC_PG_13_MILS_IMAGE			61706
#define IDC_PG_13_DEGS_TX				61707
#define IDC_PG_13_DEGS_BUTTON			61708
#define IDC_PG_13_DEGS_IMAGE			61709
#define IDC_PG_13_LEFT_TX				61710
#define IDC_PG_13_LEFT_EDIT				61711
#define IDC_PG_13_LEFT_M_TX				61712
#define IDC_PG_13_RIGHT_TX				61713
#define IDC_PG_13_RIGHT_EDIT			61714
#define IDC_PG_13_RIGHT_M_TX			61715
#define IDC_PG_13_ADD_TX				61716
#define IDC_PG_13_ADD_EDIT				61717
#define IDC_PG_13_ADD_M_TX				61718
#define IDC_PG_13_DROP_TX				61719
#define IDC_PG_13_DROP_EDIT				61720
#define IDC_PG_13_DROP_M_TX				61721
#define IDC_PG_13_CANCEL_BUTTON			61722
#define IDC_PG_13_OK_BUTTON				61723
#define IDC_PG_13_PANEL					61724

#define IDC_MAIN_GTL_DATA				62001
#define IDC_MAIN_OTL_DATA				62002
#define IDC_MAIN_OT_DATA_03				62003
#define IDC_MAIN_OT_DATA_04				62004

#define IDC_MAIN_WATCH_DY_MM_DD			62005
#define IDC_MAIN_WATCH_HR_MIN_SEC		62006
#define IDC_MAIN_WATCH_BODY				62007

//#define IDC_MAIN_WATCH_MONTH_DAY		62006
//#define IDC_MAIN_WATCH_SEC				62008




// Scrollbar definition to be included in several controls
#define SCROLLBAR \
	class ScrollBar \
	{ \
		color[] = {1,1,1,0.6}; \
		colorActive[] = {1,1,1,1}; \
		colorDisabled[] = {1,1,1,0.3}; \
		thumb="\vbs2\ui\data\ui_scrollbar_thumb_ca.paa"; \
		arrowFull="\vbs2\ui\data\ui_arrow_top_active_ca.paa"; \
		arrowEmpty="\vbs2\ui\data\ui_arrow_top_ca.paa"; \
		border="\vbs2\ui\data\ui_border_scroll_ca.paa"; \
		shadow = 0;\
	};	\
	class VScrollbar	\
	{	\
		color[] = {1, 1, 1, 1};	\
		width = 0.0210;	\
		autoScrollSpeed = -1;	\
		autoScrollDelay = 5;	\
		autoScrollRewind = false;	\
		shadow = 0;	\
	};	\
	class HScrollbar	\
	{	\
		color[] = {1, 1, 1, 1};	\
		height = 0.0280;	\
	};	\





