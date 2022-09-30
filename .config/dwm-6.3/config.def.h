/* See LICENSE file for copyright and license details. */
#include <stddef.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;   	/* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 6;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
/* static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=12", "Symbols Nerd Font:size=14" }; */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=12" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:style=Bold:size=12";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";

/* USER DEFINED COLOR */
static const char main_color[]	    = "#114078";
static const char fg_black[]        = "#111111";
static const char fg_white[]        = "#dddddd";

static const char *colors[][3]      = {
	/*               fg           bg          border   */
	[SchemeNorm] = { col_gray3,   col_gray1,  col_gray2    },
	[SchemeSel]  = { fg_white,    main_color,  main_color  },
};



/* tagging (WORKSPACE) */
//static const char *tags[] = { " ", " ",   " ",    "ﭮ ",  " ",   " ",   " ",   " ",   "襁 "   };
static const char *tags[] = { "1",  "2",    "3",    "4",    "5",    "6",    "7",    "8",    "9"     };



/* WINDOW RULES */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};





/* LAYOUT(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]",      tile },    /* first entry is default */
	{ "[F]",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};




/* key definitions 
 * MOD1 = ALT key
 * MOD4 = Windows key
 * */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                           KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY | ControlMask,             KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY | ShiftMask,               KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY | ControlMask | ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }





/* COMMANDS 
 * note: every command arguments / options must be specified
 * as a new array element. NULL indicates the end of command.
 * */

/* Put dmenu in which monitor? default = 0 (primary display) */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */

/* DMENU Command */
static const char *dmenucmd[] = { 
  "dmenu_run", "-m", dmenumon, 
  "-fn", dmenufont, 
  "-nb", col_gray1, "-nf", col_gray3,   // NORMAL ITEM COLOR
  "-sb", main_color, "-sf", fg_black,   // SELECTED ITEM COLOR
  NULL 
};


/* KEYBINDINGS */
static Key keys[] = {
	/* modifier                       key         function        argument */

  /* QUIT DWM */
	{ MODKEY | ShiftMask,             XK_q,       quit,           {0} },

  /* PROGRAM LAUNCHER (mod + space)*/
	{ MODKEY,                         XK_space,   spawn,          { .v = dmenucmd } },

  /* TOGGLE STATUS BAR */
	{ MODKEY,                         XK_b,       togglebar,      {0} },

  /* KILL A WINDOW */
	{ MODKEY,                         XK_q,       killclient,     {0} },

  /* NAVIGATE THROUGH THE STACK 
   * DWM operates using a Master-Stack principle.
   * |------------------------------------|
   * |                 |                  |
   * |                 |        2         |
   * |                 |                  |
   * |                 |------------------|
   * |                 |                  |
   * |        1        |        3         |
   * |                 |                  |
   * |                 |------------------|
   * |                 |                  |
   * |                 |        4         |
   * |                 |                  |
   * |------------------------------------|
   *
   * 1    : master (top of stack)
   * 2,3  : windows
   * 4    : bottom of stack
   *
   * New window will always be inserted at top. (master first)
   * Navigate up & down through the stack using this keybind
   * */
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },

  /* CHANGE MASTER PROPORTION 
   * By default, DWM comes with 50% master proportion. Change it using this keybinding.
   * */
	{ MODKEY,                       XK_h,      setmfact,       { .f = -0.05 } },
	{ MODKEY,                       XK_l,      setmfact,       { .f = +0.05 } },

  /* SET LAYOUT 
   * t = Tiling
   * f = floating
   * m = monocle (full screen)
   *
   * *note: even thought the layout is changed, the basic working principle
   * of DWM stays the same (master-stack), so to navigate between windows, use the
   * described keybinding.
   * */
	{ MODKEY | ShiftMask,           XK_t,      setlayout,      { .v = &layouts[0] } },
	{ MODKEY | ShiftMask,           XK_f,      setlayout,      { .v = &layouts[1] } },
	{ MODKEY | ShiftMask,           XK_m,      setlayout,      { .v = &layouts[2] } },

  /* TOGGLE FLOATING FOR CURRENT WINDOW */
	{ MODKEY | ShiftMask,           XK_space,  togglefloating, { 0 } },

  /* CYCLE THROUGH LAST WINDOW */
	{ MODKEY,                       XK_Tab,    view,           { 0 } },

  /* PUT WINDOW ON TOP OF THE STACK */
	{ MODKEY,                       XK_Return, zoom,           { 0 } },

  /* CHANGE TO MONITOR */
	{ MODKEY,                       XK_comma,  focusmon,       { .i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       { .i = +1 } },

  /* MOVE WINDOW TO MONITOR */
	{ MODKEY | ShiftMask,           XK_comma,  tagmon,         { .i = -1 } },
	{ MODKEY | ShiftMask,           XK_period, tagmon,         { .i = +1 } },

	{ MODKEY,                       XK_i,      incnmaster,     { .i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     { .i = -1 } },

	{ MODKEY,                       XK_0,      view,           { .ui = ~0 } },
	{ MODKEY | ShiftMask,           XK_0,      tag,            { .ui = ~0 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
