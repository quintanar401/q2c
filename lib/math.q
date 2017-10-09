.b2c.include,:enlist "<math.h>";

/ consts
{.b2c.defExtVar[;`c.f]each a:`C.M_E`C.M_LOG2E`C.M_LOG10E`C.M_LN2`C.M_LN10`C.M_PI`C.M_PI_2`C.M_PI_4`C.M_1_PI`C.M_2_PI`C.M_2_SQRTPI`C.M_SQRT2`C.M_SQRT1_2`C.HUGE_VAL`C.INFINITY`C.NAN;
 .b2c.defExtVar[;`c.i]each b:` sv/:`C,/:`FP_INFINITE`FP_NAN`FP_NORMAL`FP_SUBNORMAL`FP_ZERO`FP_ILOGB0`FP_ILOGBNAN`MATH_ERRNO`MATH_ERREXCEPT`signgam;
 .b2c.defExtConstFn[`math;a,b];
 }[]

/ Exists in Q
`.b2c.defF2T upsert raze({((x;y;z;0b;::);(x;y;`K;0b;::))}'). flip ((`C.acos;acos;`f`c.f`c.f);(`C.asin;asin;`f`c.f`c.f);(`C.atan;atan;`f`c.f`c.f);(`C.cos;cos;`f`c.f`c.f);(`C.sin;sin;`f`c.f`c.f);(`C.exp;exp;`f`c.f`c.f);
  (`C.log;log;`f`c.f`c.f);(`C.sqrt;sqrt;`f`c.f`c.f);(`C.floor;floor;`f`c.f`c.f));
/ Not in Q
(.b2c.defExtFn[`math;;`c.f;;()]'). flip ((`C.atan2;`c.f`c.f);(`C.cosh;`c.f);(`C.sinh;`c.f);(`C.tanh;`c.f);(`C.ldexp;`c.f`c.i);(`C.log10;`c.f);(`C.pow;`c.f`c.f);(`C.ceil;`c.f);
  (`C.fabs;`c.f);(`C.fmod;`c.f);(`C.acosh;`c.f);(`C.asinh;`c.f);(`C.atanh;`c.f);(`C.cbrt;`c.f);(`C.copysign;`c.f`c.f);(`C.erf;`c.f);(`C.erfc;`c.f);(`C.exp2;`c.f);(`C.expm1;`c.f);(`C.fdim;`c.f`c.f);(`C.fma;`c.f`c.f`c.f);
  (`C.fmax;`c.f`c.f);(`C.fmin;`c.f`c.f);(`C.fmod;`c.f`c.f);(`C.hypot;`c.f`c.f);(`C.j0;`c.f);(`C.j1;`c.f);(`C.jn;`c.i`c.f);(`C.lgamma;`c.f);(`C.log1p;`c.f);(`C.log2;`c.f);(`C.logb;`c.f);(`C.nan;`c.S);(`C.nearbyint;`c.f);
  (`C.nextafter;`c.f`c.f);(`C.remainder;`c.f`c.f);(`C.rint;`c.f);(`C.round;`c.f);(`C.scalbln;`c.f`c.j);(`C.scalbn;`c.f`c.i);(`C.tgamma;`c.f);(`C.trunc;`c.f);(`C.y0;`c.f);(`C.y1;`c.f);(`C.yn;`c.i`c.f));
(.b2c.defExtFn[`math;;`c.i;;()]'). flip ((`C.fpclassify;`c.f);(`C.isfinite;`c.f);(`C.isgreater;`c.f`c.f);(`C.isgreaterequal;`c.f`c.f);(`C.isinf;`c.f);(`C.isless;`c.f`c.f);(`C.islessequal;`c.f`c.f);
  (`C.islessgreater;`c.f`c.f);(`C.isnan;`c.f);(`C.isnormal;`c.f);(`C.isunordered;`c.f`c.f);(`C.signbit;`c.f);(`C.ilogb;`c.f));
(.b2c.defExtFn[`math;;`c.j;;()]'). flip ((`C.llrint;`c.f);(`C.llround;`c.f);(`C.lrint;`c.f);(`C.lround;`c.f));
.b2c.defExtFn[`math;`C.frexp;`c.f`retVal;(`c.f;`c.i`out);()];
.b2c.defExtFn[`math;`C.modf;`c.f`retVal;(`c.f;`c.f`out);()];
.b2c.defExtFn[`math;`C.remquo;`c.f`retVal;(`c.f;`c.f;`c.i`out);()];
