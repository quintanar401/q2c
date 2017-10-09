.b2c.include,:enlist"<sys/eventfd.h>";

{.b2c.defExtVar[;`c.i]each a:`C.EFD_CLOEXEC`C.EFD_NONBLOCK`C.EFD_SEMAPHORE;
 .b2c.defExtConstFn[`eventfd;a];
 }[]

.b2c.defExtFn[`eventfd;`C.eventfd;`c.i`chk1;`c.i`c.i;()]; / int eventfd(unsigned int initval, int flags);

/ helper functions, require fcntl
/ .eventfd.read efd
.eventfd.read:{c.j.b:0; c.ij.r:`c.ij$C.read[`c.i$x;`c.void_p$(&)c.b;count`c.j]; if[-1=c.r;'".eventfd.read: ",.string.strerror[C.toK C.errno]]; C.toK c.b};
/ .eventfd.write[efd;10]
.eventfd.write:{c.j.b:`c.j$y; c.ij.r:`c.ij$C.write[`c.i$x;`c.void_p$(&)c.b;count`c.j]; if[-1=c.r;'".eventfd.write: ",.string.strerror[C.toK C.errno]]; C.toK c.b};
/ .eventfd.setCB[efd] - set a callback .eventfd.cb
.eventfd.cb:`efd; / can be changed anytime
.eventfd.cbf:{"c)`K`c.i"; C.k[0i;`c.S$.eventfd.cb;.eventfd.read C.toK x]};
.eventfd.setCB:{C.sd1[`c.i$x;(&).eventfd.cbf]};
