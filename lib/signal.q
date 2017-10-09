.b2c.include,:enlist "<signal.h>";

{.b2c.defExtVar[;`c.i]each a:`C.SIGEV_NONE`C.SIGEV_SIGNAL`C.SIGEV_THREAD`C.SIG_BLOCK`C.SIG_UNBLOCK`C.SIG_SETMASK;
  .b2c.defExtVar[;`c.i]each b:` sv/:`C,/:`SIGABRT`SIGALRM`SIGBUS`SIGCHLD`SIGCONT`SIGFPE`SIGHUP`SIGILL`SIGINT`SIGKILL`SIGPIPE`SIGQUIT`SIGSEGV`SIGSTOP`SIGTERM`SIGTSTP`SIGTTIN`SIGTTOU`SIGUSR1`SIGUSR2`SIGPOLL,
    `SIGPROF`SIGSYS`SIGTRAP`SIGURG`SIGVTALRM`SIGXCPU`SIGXFSZ;
 .b2c.defExtConstFn[`signal;a,b];
 }[]

.b2c.defExtType[`c.sig_atomic_t;()];
.b2c.defExtType[`c.sigset_t;()];
.b2c.defExtType[`c.pthread_attr_t;()];

.b2c.defExtUnion[`sigval;`sival_int`sival_ptr!`c.i`c.void_p;`sival_int`sival_ptr!(`c.i;.b2c.it,`c.void_p);`sival_int`sival_ptr!`c.i,.b2c.it];

.b2c.defType[`c.sigevent_fn;`f`c.void`c.s_sigval];
/ Only K->C cast is defined. fn and pattr should be a long value (0 if none)
.b2c.defExtStruct[`sigevent;`sigev_notify`sigev_signo`sigev_value`sigev_notify_function`sigev_notify_attributes!`c.i`c.i`c.s_sigval`c.sigevent_fn_p`c.pthread_attr_t_p;`sigev_notify`sigev_signo`sigev_value`sigev_notify_function`sigev_notify_attributes!(`c.i;`c.i;`c.s_sigval;.b2c.it,`c.sigevent_fn_p;.b2c.it,`c.pthread_attr_t_p);()];

/ returns a byte vector representing s_sigevent structure
.signal.getSigevent:{ r:(C.toK `c.ij$count`c.s_sigevent)#0x00; c.s_sigevent_p.r:`c.s_sigevent_p$`c.void_p$`c.C$r; .b2c.K2s_sigevent_cast[c.r;x]; r};
/ returns a byte vector representing sigset_t
.signal.getSigset:{r:(C.toK `c.ij$count`c.sigset_t)#0x00; r};

.b2c.defExtFn[`signal;`sigemptyset;`c.i`chk1;enlist enlist`c.C`c.void_p`c.sigset_t_p;()];  / int sigemptyset(sigset_t *set);
.b2c.defExtFn[`signal;`sigfillset;`c.i`chk1;enlist enlist`c.C`c.void_p`c.sigset_t_p;()];  / int sigfillset(sigset_t *set);
.b2c.defExtFn[`signal;`sigaddset;`c.i`chk1;(enlist`c.C`c.void_p`c.sigset_t_p;`c.i);()];  / int sigaddset(sigset_t *set, int signum);
.b2c.defExtFn[`signal;`sigdelset;`c.i`chk1;(enlist`c.C`c.void_p`c.sigset_t_p;`c.i);()];  / int sigdelset(sigset_t *set, int signum);
.b2c.defExtFn[`signal;`sigismember;`c.i`chk1;(enlist`c.C`c.void_p`c.sigset_t_p;`c.i);()];  / int sigismember(const sigset_t *set, int signum);
.b2c.defExtFn[`signal;`sigprocmask;`c.i`chk1;(`c.i;enlist`c.C`c.void_p`c.sigset_t_p;(`c.sigset_t_p;enlist(`const;"C.NULL")));()];  / int sigprocmask(int how, const sigset_t *set, sigset_t *oldset);
