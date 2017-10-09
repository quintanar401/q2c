.b2c.include,:"<unistd.h>";

{.b2c.defExtVar[;`c.i]each a:`$"C._POSIX_",/:string`VERSION`ADVISORY_INFO`ASYNCHRONOUS_IO`BARRIERS`CHOWN_RESTRICTED`CPUTIME`FSYNC`IPV6`JOB_CONTROL`MAPPED_FILES`MEMLOCK`MEMLOCK_RANGE`MEMORY_PROTECTION`MESSAGE_PASSING,
  `MONOTONIC_CLOCK`NO_TRUNC`PRIORITIZED_IO`PRIORITY_SCHEDULING`RAW_SOCKETS`READER_WRITER_LOCKS`REALTIME_SIGNALS`REGEXP`SAVED_IDS`SEMAPHORES`SHARED_MEMORY_OBJECTS`SHELL`SPAWN`SPIN_LOCKS`SPORADIC_SERVER`SYNCHRONIZED_IO,
  `THREAD_ATTR_STACKADDR`THREAD_ATTR_STACKSIZE`THREAD_CPUTIME`THREAD_PRIO_INHERIT`THREAD_PRIO_PROTECT`THREAD_PRIORITY_SCHEDULING`THREAD_PROCESS_SHARED,
  `THREAD_SAFE_FUNCTIONS`THREAD_SPORADIC_SERVER`THREADS`TIMEOUTS`TIMERS`TRACE`TRACE_EVENT_FILTER`TRACE_INHERIT`TRACE_LOG`TYPED_MEMORY_OBJECTS`ASYNC_IO`VDISABLE;
  .b2c.defExtVar[;`c.i]each b:`$"C._POSIX2_",/:string`VERSION`C_BIND`C_DEV`CHAR_TERM`LOCALEDEF;
  .b2c.defExtVar[;`c.i]each c:`$"C._XOPEN_",/:string`VERSION`CRYPT`ENH_I18N`REALTIME`SHM`UNIX;
  / .b2c.defExtVar[;`c.i]each d:`$"C._CS_POSIX_V7_",/:string`ILP32_OFF32_CFLAGS`ILP32_OFF32_LDFLAGS`ILP32_OFF32_LIBS`ILP32_OFFBIG_CFLAGS`ILP32_OFFBIG_LDFLAGS`ILP32_OFFBIG_LIBS`LP64_OFF64_CFLAGS`LP64_OFF64_LDFLAGS,
  / `LP64_OFF64_LIBS`LPBIG_OFFBIG_CFLAGS`LPBIG_OFFBIG_LDFLAGS`LPBIG_OFFBIG_LIBS`WIDTH_RESTRICTED_ENVS;
  .b2c.defExtVar[;`c.i]each e:`$"C._PC_",/:string`ALLOC_SIZE_MIN`ASYNC_IO`CHOWN_RESTRICTED`FILESIZEBITS`LINK_MAX`MAX_CANON`MAX_INPUT`NAME_MAX`NO_TRUNC`PATH_MAX`PIPE_BUF`PRIO_IO`REC_INCR_XFER_SIZE,
  `REC_MAX_XFER_SIZE`REC_MIN_XFER_SIZE`REC_XFER_ALIGN`SYMLINK_MAX`SYNC_IO`VDISABLE,`$"2_SYMLINKS";
  .b2c.defExtVar[;`c.i]each f:`$"C._SC_2_",/:string`C_BIND`C_DEV`CHAR_TERM`FORT_DEV`FORT_RUN`LOCALEDEF`PBS`PBS_ACCOUNTING`PBS_CHECKPOINT`PBS_LOCATE`PBS_MESSAGE`PBS_TRACK`SW_DEV`UPE`VERSION;
  .b2c.defExtVar[;`c.i]each g:`$"C._SC_",/:string`ADVISORY_INFO`AIO_LISTIO_MAX`AIO_MAX`AIO_PRIO_DELTA_MAX`ARG_MAX`ASYNCHRONOUS_IO`ATEXIT_MAX`BARRIERS`BC_BASE_MAX`BC_DIM_MAX`BC_SCALE_MAX`BC_STRING_MAX`CHILD_MAX,
  `CLK_TCK`CLOCK_SELECTION`COLL_WEIGHTS_MAX`CPUTIME`DELAYTIMER_MAX`EXPR_NEST_MAX`FSYNC`GETGR_R_SIZE_MAX`GETPW_R_SIZE_MAX`HOST_NAME_MAX`IOV_MAX`IPV6`JOB_CONTROL`LINE_MAX`LOGIN_NAME_MAX`MAPPED_FILES`MEMLOCK,
  `MEMLOCK_RANGE`MEMORY_PROTECTION`MESSAGE_PASSING`MONOTONIC_CLOCK`MQ_OPEN_MAX`MQ_PRIO_MAX`NGROUPS_MAX`OPEN_MAX`PAGE_SIZE`PAGESIZE`PRIORITIZED_IO`PRIORITY_SCHEDULING`RAW_SOCKETS`RE_DUP_MAX`READER_WRITER_LOCKS,
  `REALTIME_SIGNALS`REGEXP`RTSIG_MAX`SAVED_IDS`SEM_NSEMS_MAX`SEM_VALUE_MAX`SEMAPHORES`SHARED_MEMORY_OBJECTS`SHELL`SIGQUEUE_MAX`SPAWN`SPIN_LOCKS`SPORADIC_SERVER`STREAM_MAX`SYMLOOP_MAX`SYNCHRONIZED_IO,
  `THREAD_ATTR_STACKADDR`THREAD_ATTR_STACKSIZE`THREAD_CPUTIME`THREAD_DESTRUCTOR_ITERATIONS`THREAD_KEYS_MAX`THREAD_PRIO_INHERIT`THREAD_PRIO_PROTECT`THREAD_PRIORITY_SCHEDULING`THREAD_PROCESS_SHARED,
  `THREAD_SAFE_FUNCTIONS`THREAD_SPORADIC_SERVER`THREAD_STACK_MIN`THREAD_THREADS_MAX`THREADS`TIMEOUTS`TIMER_MAX`TIMERS`TRACE`TTY_NAME_MAX`TYPED_MEMORY_OBJECTS`TZNAME_MAX,
  `VERSION`XOPEN_CRYPT`XOPEN_ENH_I18N`XOPEN_REALTIME`XOPEN_REALTIME_THREADS`XOPEN_SHM`XOPEN_UNIX`XOPEN_VERSION;
  .b2c.defExtVar[;`c.i]each h:` sv/:`C,/:`F_OK`R_OK`W_OK`X_OK`F_LOCK`F_TEST`F_TLOCK`F_ULOCK`STDERR_FILENO`STDIN_FILENO`STDOUT_FILENO,`$("_CS_PATH");
  .b2c.defExtVar[`C.environ;`c.S_p];
  .b2c.defExtConstFn[`unistd;a,b,c,e,f,g,h];
 }[];

.b2c.defExtFn[`unistd;`C.access;`c.i`chk1;`c.S`c.i;()]; / int access(const char *path, int amode);
.b2c.defExtFn[`unistd;`C.faccessat;`c.i`chk1;`c.i`c.S`c.i`c.i;()]; / int faccessat(int fd, const char *path, int amode, int flag);
.b2c.defExtFn[`unistd;`C.alarm;`c.i;`c.i;()]; / unsigned alarm(unsigned seconds);
.b2c.defExtFn[`unistd;`C.chown;`c.i`chk1;`c.S`c.uid_t`c.gid_t;()]; / int chown(const char *path, uid_t owner, gid_t group);
.b2c.defExtFn[`unistd;`C.fchownat;`c.i`chk1;`c.i`c.S`c.uid_t`c.gid_t`c.i;()]; / int fchownat(int fd, const char *path, uid_t owner, gid_t group,int flag);
.b2c.defExtFn[`unistd;`C.close;`c.i`chk1;`c.i;()]; / int close(int fildes);
.b2c.defExtFn[`unistd;`C.confstr;(`c.size_t,.b2c.it;enlist`chk0`c.i);(`c.i;`c.S;(`c.size_t;enlist(`length;2)));()]; / size_t confstr(int name, char *buf, size_t len);
.b2c.defExtFn[`unistd;`C.crypt;(`c.S;enlist`chk1,.b2c.it);`c.S`c.S;()]; / char *crypt(const char *key, const char *salt);
.b2c.defExtFn[`unistd;`C.dup;`c.i`chk1;`c.i;()]; / int dup(int fildes);
.b2c.defExtFn[`unistd;`C.dup2;`c.i`chk1;`c.i`c.i;()]; / int dup2(int fildes, int fildes2);
.b2c.defExtFn[`unistd;`C.encrypt;`c.void;((`c.C;enlist(`chkLenEq;64));`c.i);()]; / void encrypt(char block[64], int edflag);
.b2c.defExtFn[`unistd;`C.fchdir;`c.i`chk1;`c.i;()]; / int fchdir(int fildes);
.b2c.defExtFn[`unistd;`C.chdir;`c.i`chk1;`c.S;()]; / int chdir(const char *path);
/ no Q wrapper for execs !
.b2c.defExtFn[`unistd;`C.execl;`c.i`chk1;`c.S`..;enlist[`nogen]!(),1b]; / int execl(const char *path, const char *arg0, ... /*, (char *)0 */);
.b2c.defExtFn[`unistd;`C.execlp;`c.i`chk1;`c.S`..;enlist[`nogen]!(),1b]; / int execlp(const char *file, const char *arg0, ... /*, (char *)0 */);
.b2c.defExtFn[`unistd;`C.execv;`c.i`chk1;`c.S`c.S_p;enlist[`nogen]!(),1b]; / int execv(const char *path, char *const argv[]);
.b2c.defExtFn[`unistd;`C.execve;`c.i`chk1;`c.S`c.S_p`c.S_p;enlist[`nogen]!(),1b]; / int execve(const char *path, char *const argv[], char *const envp[]);
.b2c.defExtFn[`unistd;`C.execvp;`c.i`chk1;`c.S`c.S_p;enlist[`nogen]!(),1b]; / int execvp(const char *file, char *const argv[]);
.b2c.defExtFn[`unistd;`C.fexecve;`c.i`chk1;`c.i`c.S_p`c.S_p;enlist[`nogen]!(),1b]; / int fexecve(int fd, char *const argv[], char *const envp[]);
/ exec end
.b2c.defExtFn[`unistd;`C.fchown;`c.i`chk1;`c.i`c.uid_t`c.gid_t;()]; / int fchown(int fildes, uid_t owner, gid_t group);
.b2c.defExtFn[`unistd;`C.fchownat;`c.i`chk1;`c.i`c.S`c.uid_t`c.gid_t`c.i;()]; / int fchownat(int dirfd, const char *pathname, uid_t owner, gid_t group, int flags);
.b2c.defExtFn[`unistd;`C.fdatasync;`c.i`chk1;`c.i;()]; / int fdatasync(int fildes);
.b2c.defExtFn[`unistd;`C.fork;(`c.pid_t`c.i;enlist`chk1`c.i);`c.void;()]; / pid_t fork(void);
.b2c.defExtFn[`unistd;`C.fpathconf;`c.long;`c.i`c.i;()]; / long fpathconf(int fildes, int name);
.b2c.defExtFn[`unistd;`C.pathconf;`c.long;`c.S`c.i;()]; / long pathconf(const char *path, int name);
.b2c.defExtFn[`unistd;`C.fsync;`c.i`chk1;`c.i;()]; / int fsync(int fildes);
.b2c.defExtFn[`unistd;`C.ftruncate;`c.i`chk1;`c.i`c.off_t;()]; / int ftruncate(int fildes, off_t length);
.b2c.defExtFn[`unistd;`C.getcwd;(`c.S;(`chk0,.b2c.it;`notRV));(`c.C;(`c.size_t;enlist(`length;1)));()]; / char *getcwd(char *buf, size_t size);
.b2c.defExtFn[`unistd;`C.getegid;enlist`c.gid_t`c.i;`c.void;()]; / gid_t getegid(void);
.b2c.defExtFn[`unistd;`C.geteuid;enlist`c.uid_t`c.i;`c.void;()]; / uid_t geteuid(void);
.b2c.defExtFn[`unistd;`C.getgid;enlist`c.gid_t`c.i;`c.void;()]; / gid_t getgid(void);
.b2c.defExtFn[`unistd;`C.getgroups;`c.i`chk1;((`c.i;enlist(`length;2));`c.gid_t);()]; / int getgroups(int gidsetsize, gid_t grouplist[]);
.b2c.defExtFn[`unistd;`C.gethostid;`c.long;`c.void;()]; / long gethostid(void);
.b2c.defExtFn[`unistd;`C.gethostname;`c.i`chk1;(`c.S;(`c.size_t;enlist(`length;1)));()]; / int gethostname(char *name, size_t namelen);
.b2c.defExtFn[`unistd;`C.getlogin;(`c.S;enlist`chk0,.b2c.it);`c.void;()]; / char *getlogin(void);
.b2c.defExtFn[`unistd;`C.getlogin_r;`c.i`chkNot0;(`c.S;(`c.size_t;enlist(`length;1)));()]; / int getlogin_r(char *name, size_t namesize);
.b2c.defExtFn[`unistd;`C.getpgid;(`c.pid_t`c.i;enlist`chk1`c.i);`c.pid_t;()]; / pid_t getpgid(pid_t pid);
.b2c.defExtFn[`unistd;`C.getpgrp;enlist`c.pid_t`c.i;`c.void;()]; / pid_t getpgrp(void);
.b2c.defExtFn[`unistd;`C.getpid;enlist`c.pid_t`c.i;`c.void;()]; / pid_t getpid(void);
.b2c.defExtFn[`unistd;`C.getppid;enlist`c.pid_t`c.i;`c.void;()]; / pid_t getppid(void);
.b2c.defExtFn[`unistd;`C.getsid;(`c.pid_t`c.i;enlist`chk1`c.i);`c.pid_t;()]; / pid_t getsid(pid_t pid);
.b2c.defExtFn[`unistd;`C.getuid;enlist`c.uid_t`c.i;`c.void;()]; / uid_t getuid(void);
.b2c.defExtFn[`unistd;`C.isatty;`c.i;`c.i;()]; / int isatty(int fildes);
.b2c.defExtFn[`unistd;`C.lchown;`c.i`chk1;`c.S`c.uid_t`c.gid_t;()]; / int lchown(const char *path, uid_t owner, gid_t group);
.b2c.defExtFn[`unistd;`C.link;`c.i`chk1;`c.S`c.S;()]; / int link(const char *path1, const char *path2);
.b2c.defExtFn[`unistd;`C.linkat;`c.i`chk1;`c.i`c.S`c.i`c.S`c.i;()]; / int linkat(int fd1, const char *path1, int fd2, const char *path2, int flag);
.b2c.defExtFn[`unistd;`C.lockf;`c.i`chk1;`c.i`c.i`c.off_t;()]; / int lockf(int fildes, int function, off_t size);
.b2c.defExtFn[`unistd;`C.lseek;(`c.off_t,.b2c.it;enlist`chk1,.b2c.it);`c.i`c.i`c.off_t;()]; / off_t lseek(int fildes, off_t offset, int whence);
.b2c.defExtFn[`unistd;`C.nice;`c.i`chk1;`c.i;()]; / int nice(int incr);
.b2c.defExtFn[`unistd;`C.pause;`c.i`chk1;`c.void;()]; / int pause(void);
.b2c.defExtFn[`unistd;`C.pipe;`c.i`chk1;enlist(`c.I;enlist(`chkLenEq;2));()]; / int pipe(int fildes[2]);
.b2c.defExtFn[`unistd;`C.pread;(`c.ssize_t,.b2c.it;enlist`chk1,.b2c.it);(`c.i;enlist`c.C`c.void_p;(`c.size_t;enlist(`length;2));`c.off_t);()]; / ssize_t pread(int fildes, void *buf, size_t nbyte, off_t offset);
.b2c.defExtFn[`unistd;`C.read;(`c.ssize_t,.b2c.it;enlist`chk1,.b2c.it);(`c.i;enlist`c.C`c.void_p;(`c.size_t;enlist(`length;2)));()]; / ssize_t read(int fildes, void *buf, size_t nbyte);
.b2c.defExtFn[`unistd;`C.readlink;(`c.ssize_t,.b2c.it;enlist`chk1,.b2c.it);(`c.S;`c.C;(`c.size_t;enlist(`length;2)));()]; / ssize_t readlink(const char *restrict path, char *restrict buf, size_t bufsize);
.b2c.defExtFn[`unistd;`C.readlinkat;(`c.ssize_t,.b2c.it;enlist`chk1,.b2c.it);(`c.i;`c.S;`c.C;(`c.size_t;enlist(`length;3)));()]; / ssize_t readlinkat(int fd, const char *restrict path, char *restrict buf, size_t bufsize);
.b2c.defExtFn[`unistd;`C.rmdir;`c.i`chk1;`c.S;()]; / int rmdir(const char *path);
.b2c.defExtFn[`unistd;`C.setegid;`c.i`chk1;`c.gid_t;()]; / int setegid(gid_t gid);
.b2c.defExtFn[`unistd;`C.seteuid;`c.i`chk1;`c.uid_t;()]; / int seteuid(uid_t uid);
.b2c.defExtFn[`unistd;`C.setgid;`c.i`chk1;`c.gid_t;()]; / int setgid(gid_t gid);
.b2c.defExtFn[`unistd;`C.setpgid;`c.i`chk1;`c.pid_t`c.pid_t;()]; / int setpgid(pid_t pid, pid_t pgid);
.b2c.defExtFn[`unistd;`C.setpgrp;enlist`c.pid_t`c.i;`c.void;()]; / pid_t setpgrp(void);
.b2c.defExtFn[`unistd;`C.setregid;`c.i`chk1;`c.gid_t`c.gid_t;()]; / int setregid(gid_t rgid, gid_t egid);
.b2c.defExtFn[`unistd;`C.setreuid;`c.i`chk1;`c.uid_t`c.uid_t;()]; / int setreuid(uid_t ruid, uid_t euid);
.b2c.defExtFn[`unistd;`C.setsid;(`c.pid_t`c.i;enlist`chk1`c.i);`c.void;()]; / pid_t setsid(void);
.b2c.defExtFn[`unistd;`C.setuid;`c.i`chk1;`c.uid_t;()]; / int setuid(uid_t uid);
.b2c.defExtFn[`unistd;`C.sleep;`c.i;`c.i;()]; / unsigned sleep(unsigned seconds);
.b2c.defExtFn[`unistd;`C.swab;`c.void;(`c.C`c.void_p;(`c.C`c.void_p;enlist(`expr;"{$[count[x]=count y;y;'\"length\"]}[x1]"));(`c.ssize_t;enlist(`length;1)));()]; / void swab(const void *restrict src, void *restrict dest, ssize_t nbytes);
.b2c.defExtFn[`unistd;`C.symlink;`c.i`chk1;`c.S`c.S;()]; / int symlink(const char *path1, const char *path2);
.b2c.defExtFn[`unistd;`C.symlinkat;`c.i`chk1;`c.S`c.i`c.S;()]; / int symlinkat(const char *path1, int fd, const char *path2);
.b2c.defExtFn[`unistd;`C.sync;`c.void;`c.void;()]; / void sync(void);
.b2c.defExtFn[`unistd;`C.sysconf;`c.long`chk1;`c.i;()]; / long sysconf(int name);
.b2c.defExtFn[`unistd;`C.tcgetpgrp;(`c.pid_t`c.i;enlist`chk1`c.i);`c.i;()]; / pid_t tcgetpgrp(int fildes);
.b2c.defExtFn[`unistd;`C.tcsetpgrp;`c.i`chk1;`c.i`c.pid_t;()]; / int tcsetpgrp(int fildes, pid_t pgid_id);
.b2c.defExtFn[`unistd;`C.truncate;`c.i`chk1;`c.S`c.off_t;()]; / int truncate(const char *path, off_t length);
.b2c.defExtFn[`unistd;`C.ttyname;(`c.S;enlist`chk0,.b2c.it);`c.i;()]; / char *ttyname(int fildes);
.b2c.defExtFn[`unistd;`C.ttyname_r;`c.i`chkNot0;(`c.i;`c.S;(`c.size_t;enlist(`length;2)));()]; / int ttyname_r(int fildes, char *name, size_t namesize);
.b2c.defExtFn[`unistd;`C.unlink;`c.i`chk1;`c.S;()]; / int unlink(const char *path);
.b2c.defExtFn[`unistd;`C.unlinkat;`c.i`chk1;`c.i`c.S`c.i;()]; / int unlinkat(int fd, const char *path, int flag);
.b2c.defExtFn[`unistd;`C.pwrite;(`c.ssize_t,.b2c.it;enlist`chk1,.b2c.it);(`c.i;enlist`c.C`c.void_p;(`c.size_t;enlist(`length;2));`c.off_t);()]; / ssize_t pwrite(int fildes, const void *buf, size_t nbyte, off_t offset);
.b2c.defExtFn[`unistd;`C.write;(`c.ssize_t,.b2c.it;enlist`chk1,.b2c.it);(`c.i;enlist`c.C`c.void_p;(`c.size_t;enlist(`length;2)));()]; / ssize_t write(int fildes, const void *buf, size_t nbyte);
