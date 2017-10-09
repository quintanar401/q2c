.b2c.include,:enlist"<sys/signalfd.h>";

{.b2c.defExtVar[;`c.i]each a:`C.SFD_CLOEXEC`C.SFD_NONBLOCK;
 .b2c.defExtConstFn[`signalfd;a];
 }[]

.b2c.defExtFn[`signalfd;`C.signalfd;`c.i`chk1;(`c.i;enlist`c.C`c.void_p`c.sigset_t_p;`c.i);()]; / int signalfd(int fd, const sigset_t *mask, int flags);
{
  f:`ssi_signo`ssi_errno`ssi_code`ssi_pid`ssi_uid`ssi_fd`ssi_tid`ssi_band`ssi_overrun`ssi_trapno`ssi_status`ssi_int`ssi_ptr`ssi_utime`ssi_stime`ssi_addr!(12#`c.i),4#`c.j;
  .b2c.defExtStruct[`signalfd_siginfo;f;();f]; /read only
 }[];

/ helper functions, require fcntl
/ .signalfd.read efd
.signalfd.read:{c.ij.r:`c.ij$C.read[`c.i$x;`c.void_p$(&)c.s_signalfd_siginfo.v;count`c.s_signalfd_siginfo]; if[-1=c.r;'".signalfd.read: ",.string.strerror[C.toK C.errno]]; C.toK c.v};
/ .eventfd.setCB[efd] - set a callback .eventfd.cb
.signalfd.cb:`sfd; / can be changed anytime
.signalfd.cbf:{"c)`K`c.i"; C.k[0i;`c.S$.signalfd.cb;.signalfd.read C.toK x]};
.signalfd.setCB:{C.sd1[`c.i$x;(&).signalfd.cbf]};
