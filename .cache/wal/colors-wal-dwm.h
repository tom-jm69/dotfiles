static const char norm_fg[] = "#c8e2de";
static const char norm_bg[] = "#1c2049";
static const char norm_border[] = "#8c9e9b";

static const char sel_fg[] = "#c8e2de";
static const char sel_bg[] = "#65CBC9";
static const char sel_border[] = "#c8e2de";

static const char urg_fg[] = "#c8e2de";
static const char urg_bg[] = "#5AB0C4";
static const char urg_border[] = "#5AB0C4";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
