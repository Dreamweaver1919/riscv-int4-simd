#include "xpulpnn_intrinsics.h"

volatile unsigned out[8];
volatile unsigned in1[4] = {0x12345678, 0x9ABCDEF0, 0x0F0F0F0F, 0xFFFFFFFF};
volatile unsigned in2[4] = {0x11111111, 0x01020304, 0x00FF00FF, 0x00000001};

int main(void) {
  out[0] = xp_add_n (in1[0], in2[0]);   /* 8xINT4 打包加 */
  out[1] = xp_sub_n (in1[1], in2[1]);   /* 8xINT4 打包减 */
  out[2] = xp_max_n (in1[2], in2[2]);   /* 8xINT4 逐元素 max */
  out[3] = xp_add_b (in1[0], in2[0]);   /* 4xINT8 打包加 */
  out[4] = xp_dotup_n (in1[1], in2[1]); /* INT4 点积 */
  out[5] = xp_sdotup_n(out[4], in1[2], in2[2]); /* 带累加点积 */
  return 0;
}
