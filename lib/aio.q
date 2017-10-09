.b2c.include,:enlist "<aio.h>";

{.b2c.defExtVar[;`c.i]each a:`C.AIO_ALLDONE`C.AIO_CANCELED`C.AIO_NOTCANCELED`C.LIO_NOP`C.LIO_NOWAIT`C.LIO_READ`C.LIO_WAIT`C.LIO_WRITE`C.O_DSYNC`C.O_SYNC;
 .b2c.defExtConstFn[`aio;a];
 }[]

/ you can't read this struct
{.b2c.defExtStruct[`aiocb;[x[`aio_buf]:`c.void_p;x];x:`aio_fildes`aio_offset`aio_buf`aio_nbytes`aio_reqprio`aio_sigevent`aio_lio_opcode!(`c.i;`c.off_t;`c.C`c.void_p;`c.size_t;`c.i;`c.s_sigevent;`c.i);()]}[];

/ helpers
/ get the control block struct - you must provide a descr and buff
.aio.defSigev:`sigev_notify`sigev_signo`sigev_value`sigev_notify_function`sigev_notify_attributes!(0i;0i;enlist[`sival_int]!enlist 0i;.b2c.c 0;.b2c.c 0);
.aio.defCB:`aio_offset`aio_reqprio`aio_sigevent`aio_lio_opcode!(.b2c.c 0;0i;();0i);
.aio.getCB:{ r:(C.toK `c.ij$count`c.s_aiocb)#0x00; c.s_aiocb_p.r:`c.s_aiocb_p$`c.void_p$`c.C$r;
  if[()~.aio.defCB[`aio_sigevent]; .aio.defSigev[`sigev_notify]:C.toK C.SIGEV_NONE; .aio.defCB[`aio_sigevent]:.aio.defSigev];
  if[not 99=type x;'".aio.getCB: type"]; if[not all `aio_fildes`aio_buf in key x;'".aio.getCB: buf"];
  .b2c.K2s_aiocb_cast[c.r;.aio.defCB,x,enlist[`aio_nbytes]!enlist .b2c.c count x`aio_buf];
  :r;
 };
/ returns an array of CBs and an array of pointers to them for lio_listio, `cbs field should not be touched.
.aio.getCBs:{
  if[not 98=type x;".aio.getCBs: type"];
  cbs:.aio.getCB each x;
  ccbs:{C.toK`c.ij$`c.void_p$`c.C$x}each cbs;
  :`cbs`ccbs!(cbs;ccbs);
 };


.b2c.defExtFn[`aio;`aio_cancel;`c.i`chk1;(`c.i;enlist`c.C`c.void_p`c.s_aiocb_p);()]; / int aio_cancel(int fildes, struct aiocb *aiocbp);
.b2c.defExtFn[`aio;`aio_error;`c.i`chk1;enlist enlist`c.C`c.void_p`c.s_aiocb_p;()]; / int aio_error(const struct aiocb *aiocbp);
.b2c.defType[`c.s_aiocb_p_p;(`p;`c.s_aiocb_p)];
.b2c.defCCast`c.void_p`c.s_aiocb_p_p;
/ .aio.lio_listio[mode;array_of_cb_pointers;s:.b2c.getSigevent ``!..] - sigev and aiocb must be stored until aio has completed
.b2c.defExtFn[`aio;`lio_listio;`c.i`chk1;(`c.i;enlist$[.b2c.is32;`c.I;`c.J],`c.void_p`c.s_aiocb_p_p;(`c.i;enlist(`length;2));enlist`c.C`c.void_p`c.s_sigevent_p);()]; / int lio_listio(int mode, struct aiocb *restrict const list[restrict], int nent, struct sigevent *restrict sig);
.b2c.defExtFn[`aio;`aio_fsync;`c.i`chk1;(`c.i;enlist`c.C`c.void_p`c.s_aiocb_p);()]; / int aio_fsync(int op, struct aiocb *aiocbp);
.b2c.defExtFn[`aio;`aio_read;`c.i`chk1;enlist enlist`c.C`c.void_p`c.s_aiocb_p;()]; / int aio_read(struct aiocb *aiocbp);
.b2c.defExtFn[`aio;`aio_return;(`c.ssize_t,.b2c.it;enlist`chk1,.b2c.it);enlist enlist`c.C`c.void_p`c.s_aiocb_p;()]; / ssize_t aio_return(struct aiocb *aiocbp);
.b2c.defExtFn[`aio;`aio_suspend;`c.i`chk1;(enlist`c.J`c.void_p`c.s_aiocb_p_p;(`c.i;enlist(`length;1));enlist`c.C`c.void_p`c.s_timespec_p);()]; / int aio_suspend(const struct aiocb *const list[], int nent, const struct timespec *timeout);
.b2c.defExtFn[`aio;`aio_write;`c.i`chk1;enlist enlist`c.C`c.void_p`c.s_aiocb_p;()]; / int aio_write(struct aiocb *aiocbp);
