const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#1c2049", /* black   */
  [1] = "#5AB0C4", /* red     */
  [2] = "#65CBC9", /* green   */
  [3] = "#A495B3", /* yellow  */
  [4] = "#D99BB2", /* blue    */
  [5] = "#A7B7C3", /* magenta */
  [6] = "#D2AEC6", /* cyan    */
  [7] = "#c8e2de", /* white   */

  /* 8 bright colors */
  [8]  = "#8c9e9b",  /* black   */
  [9]  = "#5AB0C4",  /* red     */
  [10] = "#65CBC9", /* green   */
  [11] = "#A495B3", /* yellow  */
  [12] = "#D99BB2", /* blue    */
  [13] = "#A7B7C3", /* magenta */
  [14] = "#D2AEC6", /* cyan    */
  [15] = "#c8e2de", /* white   */

  /* special colors */
  [256] = "#1c2049", /* background */
  [257] = "#c8e2de", /* foreground */
  [258] = "#c8e2de",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
