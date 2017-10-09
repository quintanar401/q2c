.b2c.include,:("<sys/time.h>";"<sys/time.h>";"<sys/times.h>";"<time.h>");

/ Simple types
.b2c.defExtType[;()]each`c.time_t`c.suseconds_t`c.clock_t`c.clockid_t`c.timer_t`c.locale_t;
.b2c.defCCast each (`c.time_t`c.j;`c.j`c.time_t;`c.suseconds_t`c.j;`c.j`c.suseconds_t;`c.clock_t`c.j;`c.j`c.clock_t;`c.clockid_t`c.i;`c.i`c.clockid_t;`c.i`c.locale_t;`c.locale_t`c.i);
.b2c.defCompCast each (`K`c.j`c.time_t;`K`c.j`c.suseconds_t;`K`c.j`c.clock_t;`K`c.i`c.clockid_t;`K,.b2c.it,`c.timer_t_p;`K`c.i`c.locale_t); / for convenience
/ Vars
{.b2c.defExtVar[;`c.i]each a:`C.ITIMER_PROF`C.ITIMER_REAL`C.ITIMER_VIRTUAL`C.TIMER_ABSTIME`C.daylight`C.timezone;
 .b2c.defExtVar[`C.tzname;`c.C_p];
 .b2c.defExtVar[;`c.i]each b:`C.CLOCKS_PER_SEC`C.CLOCK_MONOTONIC`C.CLOCK_PROCESS_CPUTIME_ID`C.CLOCK_REALTIME`C.CLOCK_THREAD_CPUTIME_ID;
 .b2c.defExtConstFn[`time;a,b];
 }[]
/ Structs
.b2c.defExtStruct[`timeval;`tv_sec`tv_usec!`c.time_t`c.suseconds_t;`tv_sec`tv_usec!`c.time_t`c.suseconds_t;`tv_sec`tv_usec!`c.j`c.j];
.b2c.defExtStruct[`itimerval;`it_interval`it_value!`c.s_timeval`c.s_timeval;`it_interval`it_value!`c.s_timeval`c.s_timeval;`it_interval`it_value!`c.s_timeval`c.s_timeval];
{.b2c.defExtStruct[`tms;x;x;y]}[`tms_utime`tms_stime`tms_cutime`tms_cstime!4#`c.clock_t;`tms_utime`tms_stime`tms_cutime`tms_cstime!4#`c.j];
{.b2c.defExtStruct[`tm;x;x;x]}`tm_sec`tm_min`tm_hour`tm_mday`tm_mon`tm_year`tm_wday`tm_yday`tm_isdst!9#`c.i;
{.b2c.defExtStruct[`timespec;x;x;y]}[`tv_sec`tv_nsec!`c.time_t`c.j;`tv_sec`tv_nsec!`c.j`c.j];
{.b2c.defExtStruct[`itimerspec;x;x;x]}`it_interval`it_value!`c.s_timespec`c.s_timespec;
/ Functions
/ sys/time.h
.b2c.defExtFn[`time;`C.getitimer;`c.i`chk1;(`c.i;`c.s_itimerval`out);()]; / int getitimer(int which, struct itimerval *value);
.time.setitimer:{[x1;t]   c.i.res:C.setitimer[`c.i$x1; (&)`c.s_itimerval$t; (&)c.s_itimerval.rv]; if[-1=c.res;'"C.setitimer: ",.string.strerror[]];  C.toK c.rv };
.b2c.defExtFn[`time;`C.setitimer;`c.i`chk1;`c.i`c.s_itimerval_p`c.s_itimerval_p;enlist[`nogen]!(),1b]; / int   setitimer(int, const struct itimerval *restrict, struct itimerval *restrict);
.b2c.defExtFn[`time;`C.gettimeofday;`c.i;(`c.s_timeval`out;(`c.void_p;enlist(`const;"C.NULL")));()]; / int gettimeofday(struct timeval *restrict tp, void *restrict tzp);
/ sys/times.h
.b2c.defExtFn[`time;`C.times;(`c.clock_t`c.j;`retVal);enlist(`c.s_tms`out);()]; / clock_t times(struct tms *);
/ time.h
.b2c.defExtFn[`time;`C.asctime;(`c.S;enlist(`chk0;.b2c.it));enlist enlist`c.s_tm`c.s_tm_p;()]; / char *asctime(const struct tm *timeptr);
.b2c.defExtFn[`time;`C.asctime_r;(`c.S;enlist(`chk0;.b2c.it));(enlist`c.s_tm`c.s_tm_p;(`c.S;((`chkLen;26);`in_out)));()]; / char *asctime_r(const struct tm *restrict tm, char *restrict buf);
.b2c.defExtFn[`time;`C.clock;enlist `c.clock_t`c.j;`c.void;()]; / clock_t clock(void);
.b2c.defExtFn[`time;`C.clock_getcpuclockid;`c.i`chkNot0;(`c.pid_t;(`c.clockid_t`c.i;`out));()]; / int clock_getcpuclockid(pid_t pid, clockid_t *clock_id);
.b2c.defExtFn[`time;`C.clock_getres;`c.i`chk1;(`c.clockid_t;`c.s_timespec`out);()]; / int clock_getres(clockid_t clock_id, struct timespec *res);
.b2c.defExtFn[`time;`C.clock_gettime;`c.i`chk1;(`c.clockid_t;`c.s_timespec`out);()]; / int clock_gettime(clockid_t clock_id, struct timespec *tp);
.b2c.defExtFn[`time;`C.clock_settime;`c.i`chk1;(`c.clockid_t;enlist`c.s_timespec`c.s_timespec_p);()]; / int clock_settime(clockid_t clock_id, const struct timespec *tp);
.b2c.defExtFn[`time;`C.clock_nanosleep;`c.i`chkNot0;(`c.clockid_t;`c.i;enlist`c.s_timespec`c.s_timespec_p;`c.s_timespec`out);()]; / int clock_nanosleep(clockid_t clock_id, int flags, const struct timespec *rqtp, struct timespec *rmtp);
.b2c.defExtFn[`time;`C.ctime;(`c.S;enlist(`chk0;.b2c.it));enlist(`c.time_t_p;enlist(`expr;"`c.void_p$`c.J$`c.j$"));()]; / char *ctime(const time_t *clock);
.b2c.defExtFn[`time;`C.ctime_r;(`c.S;enlist(`chk0;.b2c.it));((`c.time_t_p;enlist(`expr;"`c.void_p$`c.J$`c.j$"));(`c.S;((`chkLen;26);`in_out)));()]; / char *ctime_r(const time_t *clock, char *buf);
.b2c.defExtFn[`time;`C.difftime;`c.f;`c.time_t`c.time_t;()]; / double difftime(time_t time1, time_t time0)
.b2c.defExtFn[`time;`C.getdate;`c.s_tm_p;`c.S;()]; / struct tm *getdate(const char *string);
.b2c.defExtFn[`time;`C.gmtime;(`c.s_tm_p;enlist(`chk0;.b2c.it));enlist(`c.time_t_p;enlist(`expr;"`c.void_p$`c.J$`c.j$"));()]; / struct tm *gmtime(const time_t *timer);
.b2c.defExtFn[`time;`C.gmtime_r;(`c.s_tm_p;enlist`chk0,.b2c.it);((`c.time_t_p;enlist(`expr;"`c.void_p$`c.J$`c.j$"));`c.s_tm`out);()]; / struct tm *gmtime_r(const time_t *restrict timer, struct tm *restrict result);
.b2c.defExtFn[`time;`C.localtime;(`c.s_tm_p;enlist(`chk0;.b2c.it));enlist(`c.time_t_p;enlist(`expr;"`c.void_p$`c.J$`c.j$"));()]; / struct tm *localtime(const time_t *timer);
.b2c.defExtFn[`time;`C.localtime_r;(`c.s_tm_p;enlist`chk0,.b2c.it);((`c.time_t_p;enlist(`expr;"`c.void_p$`c.J$`c.j$"));`c.s_tm`out);()]; / struct tm *localtime_r(const time_t *restrict timer, struct tm *restrict result);
.b2c.defExtFn[`time;`C.mktime;(`c.time_t`c.i;`chk1);enlist`c.s_tm`c.s_tm_p;()]; / time_t mktime(struct tm *timeptr);
.b2c.defExtFn[`time;`C.nanosleep;`c.i`chk1;(enlist`c.s_timespec`c.s_timespec_p;`c.s_timespec`out);()]; / int nanosleep(const struct timespec *rqtp, struct timespec *rmtp);
.b2c.defExtFn[`time;`C.strftime;enlist`c.size_t,.b2c.it;(`c.C;(`c.size_t;enlist(`length;1));`c.S;enlist`c.s_tm`c.s_tm_p);()]; / size_t strftime(char *restrict s, size_t maxsize, const char *restrict format, const struct tm *restrict timeptr);
.b2c.defExtFn[`time;`C.strftime_l;enlist`c.size_t,.b2c.it;(`c.C;(`c.size_t;enlist(`length;1));`c.S;enlist`c.s_tm`c.s_tm_p;`c.locale_t);()]; / size_t strftime_l(char *restrict s, size_t maxsize, const char *restrict format, const struct tm *restrict timeptr, locale_t locale);
.b2c.defExtFn[`time;`C.strptime;(`c.C;`notRV);(`c.S;`c.S;`c.s_tm`out);()]; / char *strptime(const char *restrict buf, const char *restrict format, struct tm *restrict tm);
.b2c.defExtFn[`time;`C.time;(`c.time_t`c.i;enlist(`chk1;`c.i));enlist(`c.time_t_p;enlist(`const;"C.NULL"));()]; / time_t time(time_t *tloc);
.b2c.defExtFn[`time;`C.timer_delete;`c.i`chk1;`c.timer_t;()]; / int timer_delete(timer_t timerid);
.b2c.defExtFn[`time;`C.timer_getoverrun;`c.i`chk1;`c.timer_t;()]; / int timer_getoverrun(timer_t timerid);
.b2c.defExtFn[`time;`C.timer_gettimer;`c.i`chk1;(`c.timer_t;`c.s_itimerspec`out);()]; / int timer_gettime(timer_t timerid, struct itimerspec *value);
.b2c.defExtFn[`time;`C.timer_settimer;`c.i`chk1;(`c.timer_t;`c.i;enlist`c.s_itimerspec`c.s_itimerspec_p;`c.s_itimerspec`out);()]; / int timer_settime(timer_t timerid, int flags, const struct itimerspec *restrict value,  struct itimerspec *restrict ovalue)
.b2c.defExtFn[`time;`C.tzset;`c.void;`c.void;()]; / void tzset(void);
