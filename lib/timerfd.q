.b2c.include,:enlist"<sys/timerfd.h>";

{.b2c.defExtVar[;`c.i]each a:`C.TFD_CLOEXEC`C.TFD_NONBLOCK`C.TFD_TIMER_ABSTIME`C.TFD_TIMER_ABSTIME;
 .b2c.defExtConstFn[`timerfd;a];
 }[]

.b2c.defExtFn[`timerfd;`C.timerfd_create;`c.i`chk1;`c.clockid_t`c.i;()]; / timerfd_create(int clockid, int flags);
.b2c.defExtFn[`timerfd;`C.timerfd_settime;`c.i`chk1;(`c.i;`c.i;enlist`c.s_itimerspec`c.s_itimerspec_p;`c.s_itimerspec`out);()]; / int timerfd_settime(int fd, int flags, const struct itimerspec *new_value, struct itimerspec *old_value);
.b2c.defExtFn[`timerfd;`C.timerfd_gettime;`c.i`chk1;(`c.i;`c.s_itimerspec`out);()]; / int timerfd_gettime(int fd, struct itimerspec *curr_value);

/ .timerfd.read efd
.timerfd.read:{c.j.b:0; c.ij.r:`c.ij$C.read[`c.i$x;`c.void_p$(&)c.b;count`c.j]; if[-1=c.r;'".eventfd.read: ",.string.strerror[C.toK C.errno]]; C.toK c.b};

/ .timerfd.setCB[efd] - set a callback .timerfd.cb
.timerfd.cb:`tfd; / can be changed anytime
.timerfd.cbf:{"c)`K`c.i"; C.k[0i;`c.S$.timerfd.cb;.timerfd.read C.toK x]};
.timerfd.setCB:{C.sd1[`c.i$x;(&).timerfd.cbf]};
