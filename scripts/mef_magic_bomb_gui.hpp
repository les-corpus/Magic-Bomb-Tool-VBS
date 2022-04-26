
//development variables
#ifdef MEF_MAGIC_BOMB_USE_MISSION_SCRIPTS
	__EXEC(_projectDataFolder = "P:\vbs2\customer\other\mef_magic_bomb_tool\data\");
#else
	__EXEC(_projectDataFolder = "\vbs2\customer\other\mef_magic_bomb_tool\data\");
#endif

//always change this to be the path (without drive) to the directory you are working in!
#define __CurrentDir__ \vbs2\customer\other\mef_magic_bomb_tool

class MEF_MAGIC_BOMB_TOOL
{
	idd = IDD_MAGIC_BOMB_TOOL;
	duration = 999999;   //how long the resource stays on the screen
	enableSimulation = true;
	movingEnable = true;
	onload = __EVAL("_this execVM '"+_projectDataFolder+"scripts\mef_magic_bomb_init.sqf'");
	onUnload = __EVAL("_this execVM '"+_projectDataFolder+"scripts\mef_magic_bomb_terminate.sqf'");
	
	class MAGIC_BOMB_LABEL : RscText
	{
		idc = IDC_GENERIC;
		type = CT_STATIC;
		style = ST_LEFT;			
		x = 0;
		y = 0;
		w = 0.29;
		h = 0.035;
		colorBackground[] = {0, 0, 0, 0};
		colorText[] = {1, 1, 1, 1};
		font = MAIN_FONT_MAGIC_BOMB_TOOL;
		SizeEx = MAGIC_BOMB_FONT_HT;	
		text = "";	
	};
	
	class MAGIC_BOMB_STRUCTURED_TEXT
	{
		idc = IDC_GENERIC;
		type = CT_STRUCTURED_TEXT;
		style = ST_LEFT;
		x=0.5;
		y=0.5;
		w=0.2;
		h=MAGIC_BOMB_FONT_HT;
		colorText[] = {1, 1, 1, 1};
		shadow = 1;
		class Attributes
		{
			font = MAIN_FONT_MAGIC_BOMB_TOOL;
			color = "#ffffff";
			align = "left";
			shadow = true;
		};
		size = MAGIC_BOMB_FONT_HT;
		sizeEx = MAGIC_BOMB_FONT_HT;
		text = "";
	};
	
	class MAGIC_BOMB_BUTTON : RscButton
	{
		idc = IDC_GENERIC;
		style = ST_CENTER;
		x = 0;
		y = 0;
		w = 0.12;
		h = 0.035;

		colorText[] = Color_Black;
		colorBackgroundDisabled[] = {0,63/255,125/255,.8};  //background color when disabled (darker blue)
		colorDisabled[] = {0, 0, 0, 1};	//text color when disabled (black)
		colorBackground[] = {0,128/255,255/255,1};		// background color (light blue)
		colorBackgroundActive[] = Color_Orange;	// color when mouse enters control
		colorFocused[] = {0,128/255,255/255,1};			// when clicked, fade from background color to this color
		colorShadow[] = {0, 0, 0, 0};
		colorBorder[] = {0, 0, 0, 0};

		//color for tipbox
		tooltipColorText[]={1,1,1,1};
		tooltipColorBox[]={1,1,1,1};
		tooltipColorShade[]={0.5,0.5,0.5,1};
		toolTip = "";
		
		action = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_btnClick.sqf'");
		
		font = MAIN_FONT_MAGIC_BOMB_TOOL;
		SizeEx = MAGIC_BOMB_FONT_HT;		
		text = "";			
	};
	
	class MAGIC_BOMB_EDIT : RscEdit
	{
		idc = IDC_GENERIC;	
		x = 0;
		y = 0;
		w = 0.07;
		h = 0.035;
		
		//color for tipbox
		colorText[]={1,1,1,1};
		tooltipColorText[]={1,1,1,1};
		tooltipColorBox[]={1,1,1,1};
		tooltipColorShade[]={0.5,0.5,0.5,1};
		toolTip = "";
		
		onChar = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_onChar.sqf'");  //when user types

		text = "";
	};
	
	class MAGIC_BOMB_COMBO : RscCombo
	{
		idc = IDC_GENERIC;
		x = 0;
		y = 0;
		w = 0.20;
		h = 0.035;
		
		colorSelect[] = Color_Black;							//text color when choice is made
		colorText[] = Color_Black;							//text color of menu items
		colorBackground[] = {0,128/255,255/255,1};		//background color (light blue)
		colorSelectBackground[]=Color_Orange;				//background color when selecting item
		
		//color for tipbox
		tooltipColorText[]={1,1,1,1};
		tooltipColorBox[]={1,1,1,1};
		tooltipColorShade[]={0.5,0.5,0.5,1};
		
		onLBSelChanged = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_lbSelChanged.sqf'");
	};
	
	class MAGIC_BOMB_IMAGE : RscPictureKeepAspect
	{
		idc = IDC_GENERIC;
		style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
		x = 0;
		y = 0;
		w = 0.02;
		h = 0.035;

		//insert image
		text = "";	
	};
	
	/// Advanced Tree
	class MAGIC_BOMB_TREE
	{
		idc = -1; 
		type = CT_ADV_TREE;
		style = ST_LEFT;  // TR_AUTOCOLLAPSE:2 | ST_DYNAMIC_HEIGHT:224
		SizeEx = MAGIC_BOMB_FONT_HT;
		font = MAIN_FONT_MAGIC_BOMB_TOOL;
		
		colorText[] = {0, 0, 0, 1}; // connection line color 
		colorBorder[] = {0, 0, 0, 1}; 
		colorBackground[] = {0.2, 0.2, 0.2, 1};
		
		// odd rows
		rowColorBackground1[] = {0,128/255,255/255,1};		// background color (light blue)
		rowColorBackgroundSelected1[] = Color_Orange;
		rowColorText1[] = {0, 0, 0, 1};
		rowColorTextSelected1[] = {0, 0, 0, 1};
		// even rows
		rowColorBackground2[] = {0,100/255,255/255,1};	//background color (darker blue)
		rowColorBackgroundSelected2[] = Color_Orange;
		rowColorText2[] = {0, 0, 0, 1};
		rowColorTextSelected2[] = {0, 0, 0, 1};
		
		onAdvTreeMouseDown  = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_mouseButtonClick.sqf'");
		onAdvTreeDblClick = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_mouseButtonDblClick.sqf'");
		onMouseZChanged = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_mouseZChanged.sqf'");
	
		text = "";
		SCROLLBAR  
	};
	
	class Controls
	{
		//main page
		__EXEC(_x=.65; _y=.02; _h= 0.035; _ln_gap = .005; _ctrl_gap = .005;)	//default positions and gaps
		__EXEC(_text_w = 0.29; _combo_w=.17; _btn_w=.05; _tree_w=_btn_w*10.2;)	//main page ctrl sizes	

		class MAIN_GTL_DATA : MAGIC_BOMB_STRUCTURED_TEXT
		{
			idc = IDC_MAIN_GTL_DATA;
			x = 0;			
			y = 0;
			w = .25;
			h = __EVAL(_h*4);
			text = "1111 mils, 1111 m";
		};

		class MAIN_OTL_DATA : MAGIC_BOMB_STRUCTURED_TEXT
		{
			idc = IDC_MAIN_OTL_DATA;	
			x = 0;
			y = 0;
			w = .25;
			h = __EVAL(_h*4);
			text = "2222 mils, 2222 m";
		};
		
		class MAIN_WATCH_BODY : MAGIC_BOMB_IMAGE
		{
			idc = IDC_MAIN_WATCH_BODY;
			style = ST_PICTURE;
			
			x = .1;
			y = .1;
			w = .1;  
			h = .1; 
			
			text = __EVAL(_projectDataFolder + "digital_watch_ca.paa");
		};	
		
		
		class MAIN_WATCH_HR_MIN_SEC : MAGIC_BOMB_STRUCTURED_TEXT
		{
			idc = IDC_MAIN_WATCH_HR_MIN_SEC;
			style = 0; 
			
			x = .1;
			y = .2;
			w = .1;  
			h = .1; 
			
			colorText[] = {.286, .286, .286, 1};	
			shadow = 0;

			class Attributes
			{
				font = "vbs2_digital";
				color = "#494949";
				align = "left";
				shadow = false;
			};

			size = .1;
				
			text = "28:88:88";
		};
		
		class MAIN_WATCH_DY_MM_DD : MAGIC_BOMB_LABEL
		{
			idc = IDC_MAIN_WATCH_DY_MM_DD;
			style = ST_CENTER;
			
			x = .1;
			y = .3;
			w = .1;  
			h = .1; 
			
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {.286, .286, .286, 1};
			font = "vbs2_digital";
			
			text = "WE 88-88";	
		};

		class MAIN_PREVIOUS_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_MAIN_PREVIOUS_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*0);
			w = __EVAL(_btn_w);

			colorBackground[] = Color_GrayLight;		// background color
			colorBackgroundActive[] = Color_Orange;	// color when mouse enters control
			colorFocused[] = Color_GrayLight;		// when clicked, fade from background color to this color
			
			font = "Bitstream";
			text = "<";
			toolTip = "Open Documentation";			
		};	
		class MAIN_NEXT_BUTTON: MAIN_PREVIOUS_BUTTON
		{
			idc = IDC_MAIN_NEXT_BUTTON;
			x = __EVAL(_x + _btn_w + _ctrl_gap*1);
			text = ">";
			toolTip = "Next mission.";					
		};		
		class MAIN_CURRENT_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_MAIN_CURRENT_TX;
			type = CT_STATIC;
			style = ST_CENTER + ST_WITH_RECT;			
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			y = __EVAL(_y + _h*0);
			w = __EVAL(_text_w);
			colorBackground[] = {0, 0, 0, 0};
			colorText[] = {1, 1, 1, 1};
			font = MAIN_FONT_MAGIC_BOMB_TOOL;
			SizeEx = MAGIC_BOMB_FONT_HT;	
			text = "A. R. M. N. I. T.";
		};	
		class MAIN_NEW_BUTTON: MAIN_PREVIOUS_BUTTON
		{
			idc = IDC_MAIN_NEW_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _text_w + _ctrl_gap*3);
			text = "+";
			toolTip = "Create a new mission.";	
		};
		class MAIN_DELETE_BUTTON: MAIN_PREVIOUS_BUTTON
		{
			idc = IDC_MAIN_DELETE_BUTTON;
			x = __EVAL(_x + _btn_w*3 + _text_w + _ctrl_gap*4);
			text = "-";	
			toolTip = "Delete this mission.";
		};		
		//Magic Bomb GUI
		class MAIN_FIRE_COMBO : MAGIC_BOMB_COMBO
		{
			idc = IDC_MAIN_FIRE_COMBO
			x = __EVAL(_x);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_combo_w);
			toolTip = "Select a firing unit marker.";
		};	
		class MAIN_OBSERVER_COMBO : MAIN_FIRE_COMBO
		{
			idc = IDC_MAIN_OBSERVER_COMBO;
			x = __EVAL(_x + _combo_w*2);
			toolTip = "Select an observer marker";
		};	
		
		__EXEC(_text_w=.2;)		
		
		class MAIN_TGT_LOC_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_MAIN_TGT_LOC_TX;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_text_w);
			text = "(Method) and Tgt Loc:";
		};
		class MAIN_TGT_LOC_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_MAIN_TGT_LOC_BUTTON;
			style = ST_LEFT;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_btn_w*10.2);

			colorBackground[] = {255/255,128/255,128/255,1};		// background color (light red)
			colorBackgroundActive[] = {128/255,255/255,128/255,1};	// color when mouse enters control
			colorFocused[] = {255/255,128/255,128/255,1};			// when clicked, fade from background color to this color

			text = "";
			toolTip = "(Method of target location) and target grid.";			
		};
		class MAIN_OPTIONS_TX : MAIN_TGT_LOC_TX
		{
			idc = IDC_MAIN_OPTIONS_TX;	
			y = __EVAL(_y + _h*6 + _ln_gap*6);
			text = "Options:";
		};
		class MAIN_ENGAGEMENT_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_MAIN_ENGAGEMENT_BUTTON;
			style = ST_LEFT;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*7 + _ln_gap*7);
			w = __EVAL(_btn_w*10.2);

			colorBackground[] = {0,128/255,255/255,1};		// background color (light blue)
			colorBackgroundActive[] = Color_Orange;	// color when mouse enters control
			colorFocused[] = {0,128/255,255/255,1};			// when clicked, fade from background color to this color
			
			text = "Method of Engagement (Optional)";
			toolTip = "Number of guns, rounds, and shell. Default: 1 gun, 1 round, high explosive.";
		};
		class MAIN_SHEAF_BUTTON : MAIN_ENGAGEMENT_BUTTON
		{
			idc = IDC_MAIN_SHEAF_BUTTON;
			y = __EVAL(_y + _h*8 + _ln_gap*8);
			text = "Sheaf (Optional)";
			toolTip = "Distribution of rounds i.e. open, linear, etc. Default: converged sheaf.";
		};
		class MAIN_METHOD_BUTTON : MAIN_ENGAGEMENT_BUTTON
		{
			idc = IDC_MAIN_METHOD_BUTTON;
			y = __EVAL(_y + _h*9 + _ln_gap*9);
			text = "Method of Fire Control (Optional)";
			toolTip = "When rounds will impact.  Default: 5 seconds after mission is created.";
		};
		class MAIN_OBS_DIR_TX : MAIN_TGT_LOC_TX
		{
			idc = IDC_MAIN_OBS_DIR_TX;	
			y = __EVAL(_y + _h*11 + _ln_gap*11);
			text = "Observer Direction:";
		};
		class MAIN_OBS_DIR_BUTTON : MAIN_ENGAGEMENT_BUTTON
		{
			idc = IDC_MAIN_OBS_DIR_BUTTON;
			x = __EVAL(_x + _text_W);
			y = __EVAL(_y + _h*11 + _ln_gap*11);
			w = __EVAL(_btn_w*6.2);
			text = "6400 mils grid";
			toolTip = "Current direction from observer to target grid.";
		};
		class MAIN_ADJUST_BUTTON : MAIN_ENGAGEMENT_BUTTON
		{
			idc = IDC_MAIN_ADJUST_BUTTON;
			style = ST_CENTER;
			y = __EVAL(_y + _h*13 + _ln_gap*13);
			text = "Adjustments";
			toolTip = "Enter adjustments to move the impact left, right, away, or closer.";
		};
		
		class MAIN_CREATE_BUTTON : MAIN_ENGAGEMENT_BUTTON
		{
			idc = IDC_MAIN_CREATE_BUTTON;
			style = ST_CENTER;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*15 + _ln_gap*15);
			w = __EVAL(_combo_w);
			text = "Create";
			toolTip = "Create a magic bomb.";
		};

		class MAIN_EOM_BUTTON : MAIN_ENGAGEMENT_BUTTON
		{
			idc = IDC_MAIN_EOM_BUTTON;
			style = ST_CENTER;
			x = __EVAL(_x + _combo_w*2);
			y = __EVAL(_y + _h*15 + _ln_gap*15);
			w = __EVAL(_combo_w);
			text = "End Msn";
			toolTip = "Stop rounds from impacting.";
		};
		
		class MAIN_ADJUSTMENTS_TREE : MAGIC_BOMB_TREE
		{
			idc = IDC_MAIN_ADJUSTMENTS_TREE;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*17 + _ln_gap*17);
			w = __EVAL(_tree_w);
			h = __EVAL(_h*8);
			defaultColumnWidth = .46;

			toolTip = "Adjustments to the mission will be listed here.";
		};

		//invisible button to disable the main GUI
		__EXEC(_text_w = 0.29;)
		
		class MAIN_DISABLE_GUI_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_MAIN_DISABLE_GUI_BUTTON;
			x = __EVAL(_x-.01);
			y = 0;
			w = __EVAL(_btn_w*4 + _text_w + _ctrl_gap*4 + .02);
			h = 1;
			colorText[] = {0,0,0,0};
			colorBackground[] = {0, 0, 0, .8};		
			colorBackgroundActive[] = {0, 0, 0, .8};	
			colorFocused[] = {0, 0, 0, .8};
		};	


		//page 1  method of target location
		__EXEC(_x=.1; _y=.3; _text_w = 0.28; _combo_w=.15; _btn_w=.12; _menu_w=_btn_w*3;)		
	
		class PG_01_PANEL : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_01_PANEL;
			x = __EVAL(_x-.01);
			y = __EVAL(_y-.01);
			w = __EVAL(_menu_w + _ctrl_gap*2 + .02);
			h = __EVAL(_h*5 + _ln_gap*5 + .02);
			colorBackground[] = {0, 0, 0, .8};		
		};
		
		class PG_01_METHOD_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_01_METHOD_TX;
			x = __EVAL(_x);
			y = __EVAL(_y);
			w = __EVAL(_text_w);
			text = "Method of Target Location";
		};
		class PG_01_MOVING_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_01_MOVING_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_btn_w*3 + _ctrl_gap*2);
			text = "Moving Marker";
			toolTip = "Left click + drag marker on map.";
		};
		class PG_01_GRID_BUTTON : PG_01_MOVING_BUTTON
		{
			idc = IDC_PG_01_GRID_BUTTON;
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_btn_w);
			text = "Grid";
			toolTip = "Enter MGRS grid to target";
		};
		class PG_01_POLAR_BUTTON : PG_01_GRID_BUTTON
		{
			idc = IDC_PG_01_POLAR_BUTTON;
			x = __EVAL(_x + _btn_w*1 + _ctrl_gap*1);
			text = "Polar";
			toolTip = "Enter direction and distance from observer to the target.";
		};
		class PG_01_SHIFT_BUTTON : PG_01_GRID_BUTTON
		{
			idc = IDC_PG_01_SHIFT_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "Shift";
			toolTip = "From a saved target or known point, enter meters left, right, add, or drop to the target.";
		};
		class PG_01_SAVED_TX : PG_01_METHOD_TX
		{
			idc = IDC_PG_01_SAVED_TX;	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_text_w/2);
			text = "Saved Target:";
		};
		class PG_01_SAVED_COMBO : MAGIC_BOMB_COMBO
		{ 
			idc = IDC_PG_01_SAVED_COMBO;
			x = __EVAL(_x + _text_w/2 + _ctrl_gap*1);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_combo_w);
			toolTip = "Engage a saved target with a magic bomb.";
		};
		
		//cancel and ok button at the bottom of each page
		class PG_01_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_01_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_01_OK_BUTTON : PG_01_CANCEL_BUTTON
		{
			idc = IDC_PG_01_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
			toolTip = "Accept current data.";
		};


	
		//page 2 Grid mission	
		__EXEC(_x=.1; _y=.3; _text_w = 0.05; _btn_w=.12; _edit_w = .09; _menu_w=_btn_w*3;)	
		
		class PG_02_PANEL : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_02_PANEL;
			x = __EVAL(_x-.01);
			y = __EVAL(_y-.01);
			w = __EVAL(_menu_w + _ctrl_gap*2 + .02);
			h = __EVAL(_h*4 + _ln_gap*4 + .02);
			colorBackground[] = {0, 0, 0, .8};		
		};	
		class PG_02_GRID_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_02_GRID_TX;
			x = __EVAL(_x);
			y = __EVAL(_y);
			w = __EVAL(_text_w*8);
			text = "Target Location and Direction If Known";
		};		
		class PG_02_MGRS_TX : PG_02_GRID_TX
		{
			idc = IDC_PG_02_MGRS_TX;	
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w*2.5);
			text = "Tgt Loc MGRS:";
		};		
		class PG_02_SQID_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_02_SQID_EDIT;	
			x = __EVAL(_x + _text_w*2.5 + _ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_edit_w);
			toolTip = "Enter map sheet and square ID with no spaces, i.e. 11SMS.";
			text = "24SVJ";
		};
		class PG_02_MGRS_EDIT : PG_02_SQID_EDIT
		{
			idc = IDC_PG_02_MGRS_EDIT;	
			x = __EVAL(_x + _text_w*2.5 + _edit_w + _ctrl_gap*2);
			w = __EVAL(_edit_w*1.5);
			toolTip = "Enter 6-8 MGRS grid no spaces, i.e. 1234567890.";
			text = "02900 82600";
		};	
	
		//*******************************
		//direction and attitude controls
		__EXEC(_text_w=.05; _edit_w=0.08; _circle_d=0.02; _col_2= _x + _text_w + _edit_w + _ctrl_gap*2; _col_3 = _x + _text_w*2 + .03 + _edit_w +  _circle_d + _ctrl_gap*6;)
		
		class PG_02_DIR_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_02_DIR_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w);
			text = "Dir:";
		};		
		class PG_02_DIR_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_02_DIR_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_edit_w);
			toolTip = "Enter observer to target direction. 0 to 6400 mils grid or 0 to 360 degs mag.";
			text = "6400";
		};
		class PG_02_MILS_TX : PG_02_DIR_TX
		{
			idc = IDC_PG_02_MILS_TX;	
			x = __EVAL(_col_2);
			w = __EVAL(_text_w + .03);
			text = "Mils Grid";
		};
		class PG_02_MILS_IMAGE : MAGIC_BOMB_IMAGE
		{
			idc = IDC_PG_02_MILS_IMAGE;
			x = __EVAL(_col_2 + _text_w+.03 + _ctrl_gap*1);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_circle_d);

			//insert image
			text = __EVAL(_projectDataFolder + "mef_magic_bomb_gui_circle.paa");
			colorText[] = {1, 1, 1, 1};
		};
		class PG_02_MILS_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_02_MILS_BUTTON;
			x = __EVAL(_col_2);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w + _ctrl_gap*1 + .05);
			
			//disable all the color
			colorText[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};		
			colorBackgroundActive[] = {0, 0, 0, 0};	
			colorFocused[] = {0, 0, 0, 0};		
		};	
		class PG_02_DEGS_TX : PG_02_MILS_TX
		{
			idc = IDC_PG_02_DEGS_TX;	
			x = __EVAL(_col_3);
			text = "Deg Mag";
		};
		class PG_02_DEGS_IMAGE : PG_02_MILS_IMAGE
		{
			idc = IDC_PG_02_DEGS_IMAGE;
			x = __EVAL(_col_3 +  _text_w+.03 + _ctrl_gap*1);
		};
		class PG_02_DEGS_BUTTON : PG_02_MILS_BUTTON
		{
			idc = IDC_PG_02_DEGS_BUTTON;
			x = __EVAL(_col_3);
		};	
		//*****************************************	

		//cancel and ok button at the bottom of each page
		class PG_02_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_02_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_02_OK_BUTTON : PG_02_CANCEL_BUTTON
		{
			idc = IDC_PG_02_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
			toolTip = "Accept current data.";
		};

		//page 3 polar mission	
		__EXEC(_x=.1; _y=.3; _text_w = 0.05; _btn_w=.12;_edit_w = .09;_menu_w=_btn_w*3;)
		
		class PG_03_PANEL : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_03_PANEL;
			x = __EVAL(_x-.01);
			y = __EVAL(_y-.01);
			w = __EVAL(_menu_w + _ctrl_gap*2 + .02);
			h = __EVAL(_h*5 + _ln_gap*5 + .02);
			colorBackground[] = {0, 0, 0, .8};		
		};
		
		class PG_03_POLAR_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_03_POLAR_TX;
			x = __EVAL(_x);
			y = __EVAL(_y);
			w = __EVAL(_text_w*8);
			text = "Direction and Distance from Observer";
		};
		
		class PG_03_OBS_LOC_TX : PG_03_POLAR_TX
		{
			idc = IDC_PG_03_OBS_LOC_TX;	
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w*2.5);
			text = "Obs Loc MGRS:";
		};		
		class PG_03_SQID_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_03_SQID_EDIT;	
			x = __EVAL(_x + _text_w*2.5 + _ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_edit_w);
			toolTip = "Enter map sheet and square ID with no spaces, i.e. 11SMS.";
			text = "24SVJ";
		};
		class PG_03_MGRS_EDIT : PG_03_SQID_EDIT
		{
			idc = IDC_PG_03_MGRS_EDIT;	
			x = __EVAL(_x + _text_w*2.5 + _edit_w + _ctrl_gap*2);
			w = __EVAL(_edit_w*1.5);
			toolTip = "Enter 6-8 MGRS grid no spaces, i.e. 1234567890.";
			text = "02540 81980";
		};
		
		//*******************************
		//direction and attitude controls
		__EXEC(_text_w=.05; _edit_w=0.08; _circle_d=0.02; _col_2= _x + _text_w + _edit_w + _ctrl_gap*2; _col_3 = _x + _text_w*2 + .03 + _edit_w +  _circle_d + _ctrl_gap*6;)
		
		class PG_03_DIR_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_03_DIR_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w);
			text = "Dir:";
		};		
		class PG_03_DIR_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_03_DIR_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_edit_w);
			toolTip = "Enter observer to target direction. 0 to 6400 mils grid or 0 to 360 degs mag.";
			text = "6400";
		};
		class PG_03_MILS_TX : PG_03_DIR_TX
		{
			idc = IDC_PG_03_MILS_TX;	
			x = __EVAL(_col_2);
			w = __EVAL(_text_w + .03);
			text = "Mils Grid";
		};
		class PG_03_MILS_IMAGE : MAGIC_BOMB_IMAGE
		{
			idc = IDC_PG_03_MILS_IMAGE;
			x = __EVAL(_col_2 + _text_w+.03 + _ctrl_gap*1);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_circle_d);

			//insert image
			text = __EVAL(_projectDataFolder + "mef_magic_bomb_gui_circle.paa");
			colorText[] = {0,128/255,255/255,1};
		};
		class PG_03_MILS_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_03_MILS_BUTTON;
			x = __EVAL(_col_2);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w + _ctrl_gap*1 + .05);
			
			//disable all the color
			colorText[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};		
			colorBackgroundActive[] = {0, 0, 0, 0};	
			colorFocused[] = {0, 0, 0, 0};		
		};	
		class PG_03_DEGS_TX : PG_03_MILS_TX
		{
			idc = IDC_PG_03_DEGS_TX;	
			x = __EVAL(_col_3);
			text = "Deg Mag";
		};
		class PG_03_DEGS_IMAGE : PG_03_MILS_IMAGE
		{
			idc = IDC_PG_03_DEGS_IMAGE;
			x = __EVAL(_col_3 +  _text_w+.03 + _ctrl_gap*1);
			colorText[] = {1, 1, 1, 1};
		};
		class PG_03_DEGS_BUTTON : PG_03_MILS_BUTTON
		{
			idc = IDC_PG_03_DEGS_BUTTON;
			x = __EVAL(_col_3);
		};	
		//*****************************************
		
		__EXEC(_edit_w = .08;)
	
		class PG_03_DIS_TX : PG_03_POLAR_TX
		{
			idc = IDC_PG_03_DIS_TX;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_text_w);
			text = "Dis:";
		};
		class PG_03_DIS_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_03_DIS_EDIT;
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_edit_w);
			toolTip = "Distance from Observer to Target in Meters";
			text = "16400";
		};
		class PG_03_DIS_M_TX : PG_03_DIS_TX
		{
			idc = IDC_PG_03_DIS_M_TX;	
			x = __EVAL(_x + _text_w*1 + _edit_w*1 + _ctrl_gap*2);
			text = "m";
		};	

		//cancel and ok button at the bottom of each page
		class PG_03_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_03_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_03_OK_BUTTON : PG_03_CANCEL_BUTTON
		{
			idc = IDC_PG_03_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
			toolTip = "Accept current data.";
		};
		
	
	
		//page 4 shift from known point
		__EXEC(_x=.1; _y=.3; _text_w = 0.05; _combo_w=.15; _btn_w=.12;_edit_w = .08;_menu_w=_btn_w*3;)
		
		class PG_04_PANEL : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_04_PANEL;
			x = __EVAL(_x-.01);
			y = __EVAL(_y-.01);
			w = __EVAL(_menu_w + _ctrl_gap*2 + .02);
			h = __EVAL(_h*6 + _ln_gap*6 + .02);
			colorBackground[] = {0, 0, 0, .8};		
		};	
		
		class PG_04_SHIFT_FROM_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_04_SHIFT_FROM_TX;
			x = __EVAL(_x);
			y = __EVAL(_y);
			w = __EVAL(_text_w*6);
			text = "Shift from Known Point";
		};
		class PG_04_SAVED_TX : PG_04_SHIFT_FROM_TX
		{
			idc = IDC_PG_04_SAVED_TX;	
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w*3);
			text = "Saved Target:";
		};
		class PG_04_SAVED_COMBO : MAGIC_BOMB_COMBO
		{ 
			idc = IDC_PG_04_SAVED_COMBO;
			x = __EVAL(_x + _text_w*3 + _ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_combo_w);
			toolTip = "Engage a saved target with a magic bomb.";
		};
		
		//*******************************
		//direction and attitude controls
		__EXEC(_text_w=.05; _edit_w=0.08; _circle_d=0.02; _col_2= _x + _text_w + _edit_w + _ctrl_gap*2; _col_3 = _x + _text_w*2 + .03 + _edit_w +  _circle_d + _ctrl_gap*6;)
		
		class PG_04_DIR_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_04_DIR_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w);
			text = "Dir:";
		};		
		class PG_04_DIR_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_04_DIR_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_edit_w);
			toolTip = "Enter observer to target direction. 0 to 6400 mils grid or 0 to 360 degs mag.";
			text = "6400";
		};
		class PG_04_MILS_TX : PG_04_DIR_TX
		{
			idc = IDC_PG_04_MILS_TX;	
			x = __EVAL(_col_2);
			w = __EVAL(_text_w + .03);
			text = "Mils Grid";
		};
		class PG_04_MILS_IMAGE : MAGIC_BOMB_IMAGE
		{
			idc = IDC_PG_04_MILS_IMAGE;
			x = __EVAL(_col_2 + _text_w+.03 + _ctrl_gap*1);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_circle_d);

			//insert image
			text = __EVAL(_projectDataFolder + "mef_magic_bomb_gui_circle.paa");
			colorText[] = {0,128/255,255/255,1};
		};
		class PG_04_MILS_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_04_MILS_BUTTON;
			x = __EVAL(_col_2);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w + _ctrl_gap*1 + .05);
			
			//disable all the color
			colorText[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};		
			colorBackgroundActive[] = {0, 0, 0, 0};	
			colorFocused[] = {0, 0, 0, 0};		
		};	
		class PG_04_DEGS_TX : PG_04_MILS_TX
		{
			idc = IDC_PG_04_DEGS_TX;	
			x = __EVAL(_col_3);
			text = "Deg Mag";
		};
		class PG_04_DEGS_IMAGE : PG_04_MILS_IMAGE
		{
			idc = IDC_PG_04_DEGS_IMAGE;
			x = __EVAL(_col_3 +  _text_w+.03 + _ctrl_gap*1);
			colorText[] = {1, 1, 1, 1};
		};
		class PG_04_DEGS_BUTTON : PG_04_MILS_BUTTON
		{
			idc = IDC_PG_04_DEGS_BUTTON;
			x = __EVAL(_col_3);
		};	
		//*****************************************

		//left right add and drop controls
		class PG_04_LEFT_TX : PG_04_SHIFT_FROM_TX
		{
			idc = IDC_PG_04_LEFT_TX;	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_text_w);
			text = "Left:";
		};	
		class PG_04_LEFT_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_04_LEFT_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);			
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_edit_w);
			toolTip = "Number of meters to the left of known point.";
			text = "1111";
		};		
		class PG_04_LEFT_M_TX : PG_04_LEFT_TX
		{
			idc = IDC_PG_04_LEFT_M_TX;
			x = __EVAL(_x + _text_w*1 + _edit_w*1 + _ctrl_gap*2);
			text = "m";
		};	
		class PG_04_RIGHT_TX : PG_04_LEFT_TX
		{
			idc = IDC_PG_04_RIGHT_TX;
			x = __EVAL(_x + _text_w*2 + _edit_w*1 + _ctrl_gap*5);
			text = "Right:";
		};
		class PG_04_RIGHT_EDIT : PG_04_LEFT_EDIT
		{
			idc = IDC_PG_04_RIGHT_EDIT;
			x = __EVAL(_x + _text_w*3 + _edit_w*1 + _ctrl_gap*6);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			toolTip = "Number of meters to the right of known point.";
			text = "3333";
		};	
		class PG_04_RIGHT_M_TX : PG_04_LEFT_TX
		{
			idc = IDC_PG_04_RIGHT_M_TX;	
			x = __EVAL(_x + _text_w*3 + _edit_w*2 + _ctrl_gap*7);
			text = "m";
		};	
		class PG_04_ADD_TX : PG_04_LEFT_TX
		{
			idc = IDC_PG_04_ADD_TX;	
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "Add:";
		};
		class PG_04_ADD_EDIT : PG_04_LEFT_EDIT
		{
			idc = IDC_PG_04_ADD_EDIT;	
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			toolTip = "Number of meters farther than the known point.";
			text = "2222";
		};	
		class PG_04_ADD_M_TX : PG_04_LEFT_M_TX
		{
			idc = IDC_PG_04_ADD_M_TX;
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "m";
		};			
		class PG_04_DROP_TX : PG_04_RIGHT_TX
		{
			idc = IDC_PG_04_DROP_TX;
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "Drop:";
		};
		class PG_04_DROP_EDIT : PG_04_RIGHT_EDIT
		{
			idc = IDC_PG_04_DROP_EDIT;	
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			toolTip = "Number of meters closer to the known point.";
			text = "4444";
		};
		class PG_04_DROP_M_TX : PG_04_RIGHT_M_TX
		{
			idc = IDC_PG_04_DROP_M_TX;	
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "m";
		};	
		class PG_04_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_04_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*5 + _ln_gap*5);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_04_OK_BUTTON : PG_04_CANCEL_BUTTON
		{
			idc = IDC_PG_04_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
			toolTip = "Accept current data.";
		};
		
		
		
		//page 5 Method of Engagement, Guns, rounds, shell and interval
		__EXEC(_x=.1; _y=.3; _text_w = 0.075; _combo_w=.15; _btn_w=.12;_menu_w=_btn_w*3;)		
		
		class PG_05_PANEL : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_05_PANEL;
			x = __EVAL(_x-.01);
			y = __EVAL(_y-.01);
			w = __EVAL(_menu_w + _ctrl_gap*2 + .02);
			h = __EVAL(_h*5 + _ln_gap*5 + .02);
			colorBackground[] = {0, 0, 0, .8};		
		};	
		
		class PG_05_ENGAGEMENT_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_05_ENGAGEMENT_TX;
			x = __EVAL(_x);
			y = __EVAL(_y);
			w = __EVAL(_text_w*3);
			text = "Method of Engagement";
		};
		class PG_05_GUNS_TX : PG_05_ENGAGEMENT_TX
		{
			idc = IDC_PG_05_GUNS_TX;	
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w);
			text = "Guns:";
		};
		class PG_05_GUNS_COMBO : MAGIC_BOMB_COMBO
		{ 
			idc = IDC_PG_05_GUNS_COMBO;
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_combo_w);
			toolTip = "Number of guns to fire.";
		};
		class PG_05_INTERVAL_TX : PG_05_GUNS_TX
		{
			idc = IDC_PG_05_INTERVAL_TX;	
			x = __EVAL(_x + _text_w*1 + _combo_w + _ctrl_gap*5);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			text = "Interval:";
		};
		class PG_05_ROUNDS_TX : PG_05_GUNS_TX
		{
			idc = IDC_PG_05_ROUNDS_TX;	
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			text = "Rounds:";
		};
		class PG_05_ROUNDS_COMBO : PG_05_GUNS_COMBO
		{ 
			idc = IDC_PG_05_ROUNDS_COMBO;
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			toolTip = "Number of rounds each gun will fire.";
		};
		class PG_05_INTERVAL_COMBO : PG_05_GUNS_COMBO
		{ 
			idc = IDC_PG_05_INTERVAL_COMBO;
			x = __EVAL(_x + _text_w*1 + _combo_w*1 + _ctrl_gap*5);	
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_combo_w/2);
			toolTip = "Delay in seconds between each volley";
		};
		class PG_05_SEC_TX : PG_05_ROUNDS_TX
		{
			idc = IDC_PG_05_SEC_TX;	
			x = __EVAL(_x + _text_w*1 + _combo_w*1.5 + _ctrl_gap*6);	
			text = "sec";
		};
		class PG_05_SHELL_TX : PG_05_GUNS_TX
		{
			idc = IDC_PG_05_SHELL_TX;	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			text = "Shell:";
		};
		class PG_05_SHELL_COMBO : PG_05_GUNS_COMBO
		{ 
			idc = IDC_PG_05_SHELL_COMBO;
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			toolTip = "Type of ammunition to fire.";
		};		

		//cancel and ok button at the bottom of each page		
		class PG_05_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_05_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_05_OK_BUTTON : PG_05_CANCEL_BUTTON
		{
			idc = IDC_PG_05_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
		};

		
		//page 6 Sheaf, Open, Parallel, Converged
		__EXEC(_x=.1; _y=.3; _text_w = 0.07; _combo_w=.15; _btn_w=.12;_menu_w=_btn_w*3;)		
		class PG_14_PANEL : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_14_PANEL;
			x = __EVAL(_x-.01);
			y = __EVAL(_y-.01);
			w = __EVAL(_menu_w + _ctrl_gap*2 + .02);
			h = __EVAL(_h*6 + _ln_gap*6 + .02);
			colorBackground[] = {0, 0, 0, .8};		
		};	
		class PG_14_SHEAF_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_14_SHEAF_TX;
			x = __EVAL(_x);
			y = __EVAL(_y);
			w = __EVAL(_text_w*7);
			text = "Sheaf / Distribution of Rounds";
		};
		class PG_14_TYPE_TX : PG_14_SHEAF_TX
		{
			idc = IDC_PG_14_TYPE_TX;	
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w);
			text = "Type:";
		};
		class PG_14_TYPE_COMBO : MAGIC_BOMB_COMBO
		{ 
			idc = IDC_PG_14_TYPE_COMBO;
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_combo_w);
			toolTip = "Type of sheaf or how rounds will impact.";
		};
		//cancel and ok button at the bottom of each page		
		class PG_06_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_06_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*5 + _ln_gap*5);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_06_OK_BUTTON : PG_06_CANCEL_BUTTON
		{
			idc = IDC_PG_06_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
		};		
		
		//page 7 Sheaf, REctangle
		__EXEC(_x=.1; _y=.3; _text_w = 0.07; _combo_w=.15; _btn_w=.12;_menu_w=_btn_w*3;)	

		class PG_07_LENGHT_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_07_LENGHT_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w);
			text = "Length:";
		};
		class PG_07_LENGTH_COMBO : MAGIC_BOMB_COMBO
		{ 
			idc = IDC_PG_07_LENGTH_COMBO;
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_combo_w);
			toolTip = "Length of target in meters.";
		};
		class PG_07_WIDTH_TX : PG_07_LENGHT_TX
		{
			idc = IDC_PG_07_WIDTH_TX;	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_text_w);
			text = "Width:";
		};
		class PG_07_WIDTH_COMBO : MAGIC_BOMB_COMBO
		{ 
			idc = IDC_PG_07_WIDTH_COMBO;
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_combo_w);
			toolTip = "Width of target in meters.";
		};

		//*******************************
		//direction and attitude controls
		__EXEC(_text_w=.05; _edit_w=0.08; _circle_d=0.02; _col_2= _x + _text_w + _edit_w + _ctrl_gap*2; _col_3 = _x + _text_w*2 + .03 + _edit_w +  _circle_d + _ctrl_gap*6;)
		
		class PG_07_ATTITUDE_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_07_ATTITUDE_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_text_w);
			text = "Att:";
		};		
		class PG_07_ATTITIUDE_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_07_ATTITIUDE_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_edit_w);
			toolTip = "Enter orientation or direction of the sheaf, i.e. east to west = 1600 mils grid or 90 deg mag.";
			text = "6400";
		};
		class PG_07_MILS_TX : PG_07_ATTITUDE_TX
		{
			idc = IDC_PG_07_MILS_TX;	
			x = __EVAL(_col_2);
			w = __EVAL(_text_w + .03);
			text = "Mils Grid";
		};
		class PG_07_MILS_IMAGE : MAGIC_BOMB_IMAGE
		{
			idc = IDC_PG_07_MILS_IMAGE;
			x = __EVAL(_col_2 + _text_w+.03 + _ctrl_gap*1);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_circle_d);
			//insert image
			text = __EVAL(_projectDataFolder + "mef_magic_bomb_gui_circle.paa");
			colorText[] = {0,128/255,255/255,1};
		};
		class PG_07_MILS_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_07_MILS_BUTTON;
			x = __EVAL(_col_2);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_text_w + _ctrl_gap*1 + .05);
			
			//disable all the color
			colorText[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};		
			colorBackgroundActive[] = {0, 0, 0, 0};	
			colorFocused[] = {0, 0, 0, 0};		
		};	
		class PG_07_DEGS_TX : PG_07_MILS_TX
		{
			idc = IDC_PG_07_DEGS_TX;	
			x = __EVAL(_col_3);
			text = "Deg Mag";
		};
		class PG_07_DEGS_IMAGE : PG_07_MILS_IMAGE
		{
			idc = IDC_PG_07_DEGS_IMAGE;
			x = __EVAL(_col_3 +  _text_w+.03 + _ctrl_gap*1);
			colorText[] = {1, 1, 1, 1};
		};
		class PG_07_DEGS_BUTTON : PG_07_MILS_BUTTON
		{
			idc = IDC_PG_07_DEGS_BUTTON;
			x = __EVAL(_col_3);
		};	
		//*****************************************

		//cancel and ok button at the bottom of each page		
		class PG_07_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_07_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*5 + _ln_gap*5);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_07_OK_BUTTON : PG_07_CANCEL_BUTTON
		{
			idc = IDC_PG_07_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
		};
	
		//page 8, linear sheaf
		__EXEC(_x=.1; _y=.3; _text_w = 0.07; _combo_w=.15; _btn_w=.12;_menu_w=_btn_w*3;)	

		class PG_08_LENGHT_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_08_LENGHT_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_text_w);
			text = "Length:";
		};
		class PG_08_LENGTH_COMBO : MAGIC_BOMB_COMBO
		{ 
			idc = IDC_PG_08_LENGTH_COMBO;
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_combo_w);
			toolTip = "Length of target in meters.";
		};

		//*******************************
		//direction and attitude controls
		__EXEC(_text_w=.05; _edit_w=0.08; _circle_d=0.02; _col_2= _x + _text_w + _edit_w + _ctrl_gap*2; _col_3 = _x + _text_w*2 + .03 + _edit_w +  _circle_d + _ctrl_gap*6;)
		
		class PG_08_ATTITUDE_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_08_ATTITUDE_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_text_w);
			text = "Att:";
		};		
		class PG_08_ATTITIUDE_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_08_ATTITIUDE_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_edit_w);
			toolTip = "Enter orientation or direction of the sheaf, i.e. east to west = 1600 mils grid or 90 deg mag.";
			text = "6400";
		};
		class PG_08_MILS_TX : PG_08_ATTITUDE_TX
		{
			idc = IDC_PG_08_MILS_TX;	
			x = __EVAL(_col_2);
			w = __EVAL(_text_w + .03);
			text = "Mils Grid";
		};
		class PG_08_MILS_IMAGE : MAGIC_BOMB_IMAGE
		{
			idc = IDC_PG_08_MILS_IMAGE;
			x = __EVAL(_col_2 + _text_w+.03 + _ctrl_gap*1);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_circle_d);

			//insert image
			text = __EVAL(_projectDataFolder + "mef_magic_bomb_gui_circle.paa");
			colorText[] = {0,128/255,255/255,1};
		};
		class PG_08_MILS_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_08_MILS_BUTTON;
			x = __EVAL(_col_2);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_text_w + _ctrl_gap*1 + .05);
			
			//disable all the color
			colorText[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};		
			colorBackgroundActive[] = {0, 0, 0, 0};	
			colorFocused[] = {0, 0, 0, 0};		
		};	
		class PG_08_DEGS_TX : PG_08_MILS_TX
		{
			idc = IDC_PG_08_DEGS_TX;	
			x = __EVAL(_col_3);
			text = "Deg Mag";
		};
		class PG_08_DEGS_IMAGE : PG_08_MILS_IMAGE
		{
			idc = IDC_PG_08_DEGS_IMAGE;
			x = __EVAL(_col_3 +  _text_w+.03 + _ctrl_gap*1);
			colorText[] = {1, 1, 1, 1};
		};
		class PG_08_DEGS_BUTTON : PG_08_MILS_BUTTON
		{
			idc = IDC_PG_08_DEGS_BUTTON;
			x = __EVAL(_col_3);
		};	
		//*****************************************

		//cancel and ok button at the bottom of each page		
		class PG_08_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_08_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*5 + _ln_gap*5);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_08_OK_BUTTON : PG_08_CANCEL_BUTTON
		{
			idc = IDC_PG_08_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
		};

		//page 9, sheaf, circle
		__EXEC(_x=.1; _y=.3; _text_w = 0.07; _edit_w = 0.08; _btn_w=.12;_menu_w=_btn_w*3;)

		class PG_09_RADIUS_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_09_RADIUS_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_text_w);
			text = "Radius:";
		};		
		class PG_09_RADIUS_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_09_RADIUS_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			w = __EVAL(_edit_w);
			toolTip = "Enter circle radius in meters.";
			text = "100";
		};
		class PG_09_RADIUS_M_TX : PG_09_RADIUS_TX
		{
			idc = IDC_PG_09_RADIUS_M_TX;	
			x = __EVAL(_x + _text_w*1 + _edit_w*1 + _ctrl_gap*2);
			w = __EVAL(_text_w + .03);
			text = "m";
		};
		//cancel and ok button at the bottom of each page		
		class PG_09_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_09_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*5 + _ln_gap*5);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_09_OK_BUTTON : PG_09_CANCEL_BUTTON
		{
			idc = IDC_PG_09_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
		};

		
		
		//page 10 Method of Fire Control, Time to Target or Artillery Strike "Delay"
		__EXEC(_x=.1; _y=.3; _text_w = 0.05; _combo_w=.15; _btn_w=.12;_menu_w=_btn_w*3;)		
		
		class PG_15_PANEL : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_15_PANEL;
			x = __EVAL(_x-.01);
			y = __EVAL(_y-.01);
			w = __EVAL(_menu_w + _ctrl_gap*2 + .02);
			h = __EVAL(_h*5 + _ln_gap*5 + .02);
			colorBackground[] = {0, 0, 0, .8};		
		};	
		
		class PG_15_FIRE_CTRL_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_15_FIRE_CTRL_TX;
			x = __EVAL(_x);
			y = __EVAL(_y);
			w = __EVAL(_text_w*6);
			text = "Method of Fire Control";
		};
		class PG_15_TYPE_TX : PG_15_FIRE_CTRL_TX
		{
			idc = IDC_PG_15_TYPE_TX;	
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w);
			text = "Type:";
		};
		class PG_15_TYPE_COMBO : MAGIC_BOMB_COMBO
		{ 
			idc = IDC_PG_15_TYPE_COMBO;
			x = __EVAL(_x + _text_w + _ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_combo_w);
			toolTip = "Select when rounds will impact.";
		};
		class PG_10_AMMOUNT_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_10_AMMOUNT_TX;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w*8);
			text = "Amount of Time Before Rounds Impact:";
		};
		class PG_10_SEC_COMBO : MAGIC_BOMB_COMBO
		{ 
			idc = IDC_PG_10_SEC_COMBO;
			x = __EVAL(_x );	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_combo_w/2);
			toolTip = "After mission is created, delay in seconds when rounds will impact.";
		};
		class PG_10_SEC_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_10_SEC_TX;	
			x = __EVAL(_x + _combo_w/2 + _ctrl_gap*1);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_text_w*6);
			text = "sec";
		};

		//cancel and ok button at the bottom of each page		
		class PG_10_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_10_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_10_OK_BUTTON : PG_10_CANCEL_BUTTON
		{
			idc = IDC_PG_10_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
			toolTip = "Accept current data.";
		};	

		//page 11 Method of Fire Control Time on Target	
		__EXEC(_x=.1; _y=.3; _text_w = 0.05; _combo_w=.07; _btn_w=.12;_edit_w = .05;_menu_w=_btn_w*3;)	

		class PG_11_TIME_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_11_TIME_TX;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w*6);
			text = "Time Rounds Will Impact:";
		};
		class PG_11_HR_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_11_HR_EDIT;
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			x = __EVAL(_x);			
			w = __EVAL(_edit_w);
			toolTip = "Enter hours, 08:05:00 = 08.";
			text = "08";
		};	
		class PG_11_HR_TX : PG_11_TIME_TX
		{
			idc = IDC_PG_11_HR_TX;	
			x = __EVAL(_x + _edit_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_text_w);
			text = "hr";
		};		
		class PG_11_MIN_EDIT : PG_11_HR_EDIT
		{
			idc = IDC_PG_11_MIN_EDIT;
			x = __EVAL(_x + _text_w*1 + _edit_w*1 + _ctrl_gap*2);			
			toolTip = "Enter minutes, 08:05:00 = 05.";
			text = "05";
		};	
		class PG_11_MIN_TX : PG_11_HR_TX
		{
			idc = IDC_PG_11_MIN_TX;	
			x = __EVAL(_x + _text_w*1 + _edit_w*2 + _ctrl_gap*3);	
			text = "min";
		};	
		class PG_11_SEC_COMBO : MAIN_FIRE_COMBO
		{ 
			idc = IDC_PG_11_SEC_COMBO;
			x = __EVAL(_x + _text_w*2 + _edit_w*2 + _ctrl_gap*4);	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			w = __EVAL(_combo_w);
			toolTip = "Select seconds, 08:05:00 = 00.";
		};
		class PG_11_SEC_TX : PG_11_HR_TX
		{
			idc = IDC_PG_11_SEC_TX;	
			x = __EVAL(_x + _text_w*2 + _edit_w*2 + _combo_w + _ctrl_gap*5);
			text = "sec";
		};	

		//cancel and ok button at the bottom of each page	
		class PG_11_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_11_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_11_OK_BUTTON : PG_11_CANCEL_BUTTON
		{
			idc = IDC_PG_11_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
			toolTip = "Accept current data.";
		};		

		//page 12 Observer to target direction
		__EXEC(_x=.1; _y=.3; _text_w = 0.05; _btn_w=.12;_menu_w=_btn_w*3;)		
				
		class PG_12_PANEL : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_12_PANEL;
			x = __EVAL(_x-.01);
			y = __EVAL(_y-.01);
			w = __EVAL(_menu_w + _ctrl_gap*2 + .02);
			h = __EVAL(_h*3 + _ln_gap*3 + .02);
			colorBackground[] = {0, 0, 0, .8};		
		};	
		
		class PG_12_OBSERVER_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_12_OBSERVER_TX;
			x = __EVAL(_x);
			y = __EVAL(_y);
			w = __EVAL(_text_w*8);
			text = "Observer to Target Direction";
		};		
		//*******************************
		//direction and attitude controls
		__EXEC(_text_w=.05; _edit_w=0.08; _circle_d=0.02; _col_2= _x + _text_w + _edit_w + _ctrl_gap*2; _col_3 = _x + _text_w*2 + .03 + _edit_w +  _circle_d + _ctrl_gap*6;)

		class PG_12_DIR_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_12_DIR_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w);
			text = "Dir:";
		};		
		class PG_12_DIR_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_12_DIR_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_edit_w);
			toolTip = "Enter observer to target direction. 0 to 6400 mils grid or 0 to 360 degs mag.";
			text = "6400";
		};
		class PG_12_MILS_TX : PG_12_DIR_TX
		{
			idc = IDC_PG_12_MILS_TX;	
			x = __EVAL(_col_2);
			w = __EVAL(_text_w + .03);
			text = "Mils Grid";
		};
		class PG_12_MILS_IMAGE : MAGIC_BOMB_IMAGE
		{
			idc = IDC_PG_12_MILS_IMAGE;
			x = __EVAL(_col_2 + _text_w + .03 +_ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_circle_d);

			//insert image
			text = __EVAL(_projectDataFolder + "mef_magic_bomb_gui_circle.paa");
			colorText[] = {0,128/255,255/255,1};
		};		
		class PG_12_MILS_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_12_MILS_BUTTON;
			x = __EVAL(_col_2);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w + _ctrl_gap*1 + .05);
			
			//disable all the color
			colorText[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};		
			colorBackgroundActive[] = {0, 0, 0, 0};	
			colorFocused[] = {0, 0, 0, 0};		
		};	
		class PG_12_DEGS_TX : PG_12_MILS_TX
		{
			idc = IDC_PG_12_DEGS_TX;	
			x = __EVAL(_col_3);
			text = "Deg Mag";
		};
		class PG_12_DEGS_IMAGE : PG_12_MILS_IMAGE
		{
			idc = IDC_PG_12_DEGS_IMAGE;
			x = __EVAL(_col_3 + _text_w + .03 +_ctrl_gap*1);
			colorText[] = {1, 1, 1, 1};
		};
		class PG_12_DEGS_BUTTON : PG_12_MILS_BUTTON
		{
			idc = IDC_PG_12_DEGS_BUTTON;
			x = __EVAL(_col_3);
		};	
		//*****************************************			
		
		//cancel and ok button at the bottom of each page		
		class PG_12_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_12_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_12_OK_BUTTON : PG_12_CANCEL_BUTTON
		{
			idc = IDC_PG_12_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
		};
	
		
		
		//page 13 adjustments
		__EXEC(_x=.1; _y=.3; _text_w = 0.05; _combo_w=.15; _btn_w=.12;_edit_w = .08;_circle_d = .02;_menu_w=_btn_w*3;)
		
		class PG_13_PANEL : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_13_PANEL;
			x = __EVAL(_x-.01);
			y = __EVAL(_y-.01);
			w = __EVAL(_menu_w + _ctrl_gap*2 + .02);
			h = __EVAL(_h*5 + _ln_gap*5 + .02);
			colorBackground[] = {0, 0, 0, .8};		
		};
		
		class PG_13_ADJUST_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_13_ADJUST_TX;
			x = __EVAL(_x);
			y = __EVAL(_y);
			w = __EVAL(_text_w*6);
			text = "Adjustments";
		};

		//*******************************
		//direction and attitude controls
		__EXEC(_text_w=.05; _edit_w=0.08; _circle_d=0.02; _col_2= _x + _text_w + _edit_w + _ctrl_gap*2; _col_3 = _x + _text_w*2 + .03 + _edit_w +  _circle_d + _ctrl_gap*6;)
		
		class PG_13_DIR_TX : MAGIC_BOMB_LABEL
		{
			idc = IDC_PG_13_DIR_TX;	
			x = __EVAL(_x);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w);
			text = "Dir:";
		};		
		class PG_13_DIR_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_13_DIR_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_edit_w);
			toolTip = "Enter observer to target direction. 0 to 6400 mils grid or 0 to 360 degs mag.";
			text = "6400";
		};
		class PG_13_MILS_TX : PG_13_DIR_TX
		{
			idc = IDC_PG_13_MILS_TX;	
			x = __EVAL(_col_2);
			w = __EVAL(_text_w + .03);
			text = "Mils Grid";
		};
		class PG_13_MILS_IMAGE : MAGIC_BOMB_IMAGE
		{
			idc = IDC_PG_13_MILS_IMAGE;
			x = __EVAL(_col_2 + _text_w+.03 + _ctrl_gap*1);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_circle_d);

			//insert image
			text = __EVAL(_projectDataFolder + "mef_magic_bomb_gui_circle.paa");
			colorText[] = {0,128/255,255/255,1};
		};
		class PG_13_MILS_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_13_MILS_BUTTON;
			x = __EVAL(_col_2);
			y = __EVAL(_y + _h*1 + _ln_gap*1);
			w = __EVAL(_text_w + _ctrl_gap*1 + .05);
			
			//disable all the color
			colorText[] = {0, 0, 0, 0};
			colorBackground[] = {0, 0, 0, 0};		
			colorBackgroundActive[] = {0, 0, 0, 0};	
			colorFocused[] = {0, 0, 0, 0};		
		};	
		class PG_13_DEGS_TX : PG_13_MILS_TX
		{
			idc = IDC_PG_13_DEGS_TX;	
			x = __EVAL(_col_3);
			text = "Deg Mag";
		};
		class PG_13_DEGS_IMAGE : PG_13_MILS_IMAGE
		{
			idc = IDC_PG_13_DEGS_IMAGE;
			x = __EVAL(_col_3 +  _text_w+.03 + _ctrl_gap*1);
			colorText[] = {1, 1, 1, 1};
		};
		class PG_13_DEGS_BUTTON : PG_13_MILS_BUTTON
		{
			idc = IDC_PG_13_DEGS_BUTTON;
			x = __EVAL(_col_3);
		};	
		//*****************************************

		__EXEC(_text_w = 0.05; _edit_w = .08;)

		//left right add and drop controls
		class PG_13_LEFT_TX : PG_13_ADJUST_TX
		{
			idc = IDC_PG_13_LEFT_TX;	
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_text_w);
			text = "Left:";
		};	
		class PG_13_LEFT_EDIT : MAGIC_BOMB_EDIT
		{
			idc = IDC_PG_13_LEFT_EDIT;	
			x = __EVAL(_x + _text_w*1 + _ctrl_gap*1);			
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			w = __EVAL(_edit_w);
			//toolTip = "Number of meters to the left of known point.";
			toolTip = "Move left of impact in meters.";
			text = "1111";
		};		
		class PG_13_LEFT_M_TX : PG_13_LEFT_TX
		{
			idc = IDC_PG_13_LEFT_M_TX;
			x = __EVAL(_x + _text_w*1 + _edit_w*1 + _ctrl_gap*2);
			text = "m";
		};	
		class PG_13_RIGHT_TX : PG_13_LEFT_TX
		{
			idc = IDC_PG_13_RIGHT_TX;
			x = __EVAL(_x + _text_w*2 + _edit_w*1 + _ctrl_gap*5);
			text = "Right:";
		};
		class PG_13_RIGHT_EDIT : PG_13_LEFT_EDIT
		{
			idc = IDC_PG_13_RIGHT_EDIT;
			x = __EVAL(_x + _text_w*3 + _edit_w*1 + _ctrl_gap*6);
			y = __EVAL(_y + _h*2 + _ln_gap*2);
			toolTip = "Move right of impact in meters.";
			text = "3333";
		};	
		class PG_13_RIGHT_M_TX : PG_13_LEFT_TX
		{
			idc = IDC_PG_13_RIGHT_M_TX;	
			x = __EVAL(_x + _text_w*3 + _edit_w*2 + _ctrl_gap*7);
			text = "m";
		};	
		class PG_13_ADD_TX : PG_13_LEFT_TX
		{
			idc = IDC_PG_13_ADD_TX;	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			text = "Add:";
		};
		class PG_13_ADD_EDIT : PG_13_LEFT_EDIT
		{
			idc = IDC_PG_13_ADD_EDIT;	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			toolTip = "Move away from impact in meters.";
			text = "2222";
		};	
		class PG_13_ADD_M_TX : PG_13_LEFT_M_TX
		{
			idc = IDC_PG_13_ADD_M_TX;
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			text = "m";
		};			
		class PG_13_DROP_TX : PG_13_RIGHT_TX
		{
			idc = IDC_PG_13_DROP_TX;
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			text = "Drop:";
		};
		class PG_13_DROP_EDIT : PG_13_RIGHT_EDIT
		{
			idc = IDC_PG_13_DROP_EDIT;	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			toolTip = "Move closer from impact in meters.";
			text = "4444";
		};
		class PG_13_DROP_M_TX : PG_13_RIGHT_M_TX
		{
			idc = IDC_PG_13_DROP_M_TX;	
			y = __EVAL(_y + _h*3 + _ln_gap*3);
			text = "m";
		};	
		
		class PG_13_CANCEL_BUTTON : MAGIC_BOMB_BUTTON
		{
			idc = IDC_PG_13_CANCEL_BUTTON;
			x = __EVAL(_x);
			y = __EVAL(_y + _h*4 + _ln_gap*4);
			text = "Cancel";
			toolTip = "Cancel current operation.";
		};
		class PG_13_OK_BUTTON : PG_13_CANCEL_BUTTON
		{
			idc = IDC_PG_13_OK_BUTTON;
			x = __EVAL(_x + _btn_w*2 + _ctrl_gap*2);
			text = "OK";
			toolTip = "Apply these adjustments. Point of impact will change.";
		};	
	};
	
	class controlsBackground
	{	
		//2D map
		class MAIN_2D_MAP : RscMapControl
		{
			idc = IDC_MAIN_2D_MAP;
			x = safeZoneX;
			y = 0;
			w = safeZoneWAbs - .53 + .003;
			h = 1;
			colorBuildings[] = {0, 0, 0, 0.50};
			showCountourInterval = "true";
			moveOnEdges = false;
			onMouseButtonDblClick = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_map_DblClick.sqf'");
			onMouseButtonClick = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_map_click.sqf'");
			onMouseMoving = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_map_MouseMoving.sqf'");
			onMouseButtonDown = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_map_ButtonDown.sqf'");
			onMouseButtonUp = __EVAL("_this execVM '"+_projectDataFolder + "scripts\mef_magic_bomb_map_ButtonUp.sqf'");
		};
		
		__EXEC(_x=.65; _text_w = 0.29; _btn_w=.05;)		

		class MAIN_GUI_PANEL : MAGIC_BOMB_LABEL		//black panel behind GUI
		{
			idc = IDC_MAIN_GUI_PANEL;
			x = __EVAL(_x-.01);
			y = 0;
			w = __EVAL(_btn_w*4 + _text_w + _ctrl_gap*4 + .02);	
			h = 1;
			colorBackground[] = {0, 0, 0, 1};		
		};
	};
};



