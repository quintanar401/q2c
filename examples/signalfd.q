\l ../q2b.q
\l ../b2c.q
\l ../std.q
\l ../lib/time.q
\l ../lib/string.q
\l ../lib/signal.q
\l ../lib/signalfd.q
\l ../lib/unistd.q

.s.signal:{
  -1 "Create a sigset";
  .signal.sigemptyset s:.signal.getSigset[];
  -1 "Add SIGUSR1";
  .signal.sigaddset[s;.s.consts`SIGUSR1];
  -1 "Block the def handler";
  .signal.sigprocmask[.s.consts`SIG_BLOCK;s];
  -1 "Create a file descr";
  fd:.signalfd.signalfd[-1i;s;0i];
  -1 "Attach Q handler";
  .signalfd.setCB fd;
  -1 "Run system kill";
  system 0N!"kill -s USR1 ",string .z.i;
 };

sfd:{ -1 "Got a signal: ",.Q.s x; -1 "exiting..."; exit 0};

l:.b2c.compile[`.signal.getConsts`.s.signal;`libname`rec`goal`k!(`sigex;1b;`load;"..")];

.s.consts:l[`.signal.getConsts][];
l[`.s.signal][];
