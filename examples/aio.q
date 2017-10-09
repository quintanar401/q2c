\l ../q2b.q
\l ../b2c.q
\l ../std.q
\l ../lib/time.q
\l ../lib/string.q
\l ../lib/eventfd.q
\l ../lib/signal.q
\l ../lib/aio.q
\l ../lib/fcntl.q
\l ../lib/unistd.q

.aio.buff:1000#0x00;

.aio.sighandler:{"c)`c.void`c.s_sigval"; c.j.v:`c.j$x`sival_int; c.ssize_t.r:C.write[C.aio_fd;`c.void_p$(&)c.v;count`c.j];};

.aio.makeReq:{
  -1 "Open aio.q";
  fd:.fcntl.open[`aio.q;.aio.consts`O_RDONLY];
  -1 "Create an event descr";
  efd:.eventfd.eventfd[0i;0i]; C.aio_fd:`c.i$efd;
  -1 "Setup event handler";
  .eventfd.setCB efd;
  -1 "Create aio control block";
  se:`sigev_notify`sigev_notify_function`sigev_signo`sigev_value`sigev_notify_attributes!(.aio.consts`SIGEV_THREAD;C.toK`c.ij$(&).aio.sighandler;0i;enlist[`sival_int]!enlist fd;.b2c.c 0);
  .aio.cb:.aio.getCB `aio_buf`aio_fildes`aio_sigevent!(.aio.buff;fd;se);
  -1 "Start a req";
  .aio.aio_read .aio.cb;
  r:.aio.aio_error .aio.cb;
  -1 "Status: ",string r;
 };

.aio.makeReq2:{
  -1 "\n\nOpen N handles";
  fds:{-1 "  ",x; .fcntl.open[`$x;.aio.consts`O_RDONLY]}each f:"../lib/",/:string key `:../lib;
  .aio.buff:{y; x#0x00}[10000]each fds;
  -1 "Create lio CBs";
  cbs:{
    se:`sigev_notify`sigev_notify_function`sigev_signo`sigev_value`sigev_notify_attributes!(.aio.consts`SIGEV_THREAD;C.toK`c.ij$(&).aio.sighandler;0i;enlist[`sival_int]!enlist 1i;.b2c.c 0);
    : `aio_buf`aio_fildes`aio_sigevent`aio_lio_opcode!(.aio.buff x;y;se;.aio.consts`LIO_READ);
   }'[til count fds;fds];
  efd::l`efd2;
  .aio.se:.signal.getSigevent `sigev_notify`sigev_notify_function`sigev_signo`sigev_value`sigev_notify_attributes!(.aio.consts`SIGEV_THREAD;C.toK`c.ij$(&).aio.sighandler;0i;enlist[`sival_int]!enlist 2i;.b2c.c 0);
  cbs:.aio.getCBs cbs;
  .aio.ccbs:cbs`ccbs; .aio.cbs:flip`cb`s`f!(cbs`cbs;-1;f);
  -1 "Initiate a mass request";
  .aio.lio_listio[.aio.consts`LIO_NOWAIT;cbs`ccbs;.aio.se];
 };

efd1:{ -1 "Event handler"; r:.aio.aio_error .aio.cb; -1 "Status: ",string r; r:.aio.aio_return .aio.cb; -1 "Returned: ",string r; -1 "Sample: ","c"$50#.aio.buff; @[{l[`.aio.makeReq2][]};1;0N!];};
efd2:{
  -1 "Event handler: ",("1 req done";"all done")x-1;
  .aio.cbs[i;`s]:{r:.aio.aio_error x`cb; -1 "Status for ",x[`f],": ",string r; if[0=r; r2:.aio.aio_return x`cb; -1 "  returned: ",string r2]; r}each .aio.cbs i:where not 0=.aio.cbs`s;
  if[2=x;exit 0];
 };

l:.b2c.compile[`.signal.getConsts`.fcntl.getConsts`.aio.getConsts`.aio.makeReq`.aio.makeReq2`efd1`efd2;`libname`rec`goal`k`cglobals`debug!(`aioex;1b;`load;"..";enlist(`C.aio_fd;`c.i;"0");1)];

.aio.consts:(l[`.signal.getConsts][]),(l[`.fcntl.getConsts][]),l[`.aio.getConsts][];
efd:l`efd1;
l[`.aio.makeReq][];
