\l ../q2b.q
\l ../b2c.q
\l ../std.q
\l ../lib/time.q
\l ../lib/string.q


.te.gettime:{
  ci:.time.clock_getcpuclockid .z.i;
  -1 "Process clockid is ",string ci;
  s:.time.clock_gettime ci;
  -1 "Clock value is ",.Q.s1 s;
  s:.time.clock_gettime .te.consts`CLOCK_REALTIME; t:.z.P;
  -1 "REALTIME clock value is ",.Q.s1[s],", Q .z.P value is ",string t;
  -1 "REALTIME value splitted: ",.Q.s .time.gmtime s`tv_sec;
 };

l:.b2c.compile[`.time.getConsts`.te.gettime;`libname`rec`goal`k!(`timeex;1b;`load;"..")];

.te.consts:l[`.time.getConsts][];
l[`.te.gettime][];

exit 0;
