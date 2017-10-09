\l ../q2b.q
\l ../b2c.q
\l ../std.q
\l ../lib/time.q
\l ../lib/string.q
\l ../lib/timerfd.q
\l ../lib/unistd.q

.te.setTimer:{
  -1 "Create a timer";
  fd:.timerfd.timerfd_create[.te.consts`CLOCK_REALTIME;0i];
  -1 "Setup Q handler";
  .timerfd.setCB fd;
  -1 "Setup the timer";
  s:.timerfd.timerfd_settime[fd;0i;`it_interval`it_value!(`tv_sec`tv_nsec!5 0;`tv_sec`tv_nsec!1 0)];
  -1 "Prev: ",.Q.s s;
  s:.timerfd.timerfd_gettime fd;
  -1 "Curr: ",.Q.s s;
 };

.te.z0:.te.z:.z.P;
tfd:{ -1 "Handler: ",string .z.P-.te.z; .te.z:.z.P; if[0D00:01<.z.P-.te.z0; exit 0];};

l:.b2c.compile[`.time.getConsts`.te.setTimer;`libname`rec`goal`k!(`timerex;1b;`load;"..")];

.te.consts:l[`.time.getConsts][];
l[`.te.setTimer][];
