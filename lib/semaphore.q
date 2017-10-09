.b2c.include,:enlist "<semaphore.h>";

.b2c.defExtType[`c.sem_t;()]; / we do not need to know what is it
.b2c.defCompCast`K,.b2c.it,`c.sem_t_p; / for convenience

.b2c.defExtVar[`C.SEM_FAILED;`c.sem_t_p];

.b2c.defExtFn[`semaphore;`C.sem_close;`c.i`chk1;`c.sem_t_p;()]; / int    sem_close(sem_t *);
.b2c.defExtFn[`semaphore;`C.sem_destroy;`c.i`chk1;`c.sem_t_p;()]; / int    sem_destroy(sem_t *);
.b2c.defExtFn[`semaphore;`C.sem_getvalue;`c.i`chk1;(`c.sem_t_p;`c.i`out);()]; / int    sem_getvalue(sem_t *restrict, int *restrict);
.b2c.defExtFn[`semaphore;`C.sem_init;`c.i`chk1;`c.sem_t_p`c.i`c.uint;()]; / int    sem_init(sem_t *, int, unsigned);
.b2c.defExtFn[`semaphore;`C.sem_open;(`c.sem_t_p,.b2c.it;enlist(`chkExp;"C.SEM_FAILED";.b2c.it));`c.S`c.i`c.mode_t`c.uint;()]; / sem_t *sem_open(const char *, int, ...);
.b2c.defExtFn[`semaphore;`C.sem_post;`c.i`chk1;`c.sem_t_p;()]; / int    sem_post(sem_t *);
.b2c.defExtFn[`semaphore;`C.sem_timedwait;`c.i`chk1;(`c.sem_t_p;enlist`c.s_timespec`c.s_timespec_p);()]; / int    sem_timedwait(sem_t *restrict, const struct timespec *restrict);
.b2c.defExtFn[`semaphore;`C.sem_trywait;`c.i;`c.sem_t_p;()]; / int    sem_trywait(sem_t *); No result check!
.b2c.defExtFn[`semaphore;`C.sem_unlink;`c.i`chk1;`c.S;()]; / int    sem_unlink(const char *);
.b2c.defExtFn[`semaphore;`C.sem_wait;`c.i`chk1;`c.sem_t_p;()]; / int    sem_wait(sem_t *);
