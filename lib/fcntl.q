.b2c.include,:"<fcntl.h>";

{.b2c.defExtVar[;`c.i]each a:` sv/:`C,/:`F_DUPFD`F_GETFD`F_SETFD`F_GETFL`F_SETFL`F_GETLK`F_SETLK`F_SETLKW`F_GETOWN`F_SETOWN`FD_CLOEXEC`F_RDLCK`F_UNLCK`F_WRLCK;
 .b2c.defExtVar[;`c.i]each b:` sv/:`C,/:`O_CREAT`O_EXCL`O_NOCTTY`O_TRUNC`O_APPEND`O_DSYNC`O_NONBLOCK`O_RSYNC`O_SYNC`O_ACCMODE`O_RDONLY`O_RDWR`O_WRONLY;
 / .b2c.defExtVar[;`c.i]each c:` sv/:`C,/:`AT_FDCWD`AT_EACCESS`AT_SYMLINK_NOFOLLOW`AT_SYMLINK_FOLLOW`AT_REMOVEDIR;
 .b2c.defExtConstFn[`fcntl;a,b];
 }[]

{.b2c.defExtStruct[`flock;x;x:`l_type`l_whence`l_start`l_len`l_pid!`c.h`c.h`c.off_t`c.off_t`c.pid_t;`l_type`l_whence`l_start`l_len`l_pid!`c.h`c.h,.b2c.it,.b2c.it,`c.i]}[];

.b2c.defExtFn[`fcntl;`C.creat;`c.i`chk1;`c.S`c.mode_t;()]; / int creat(const char *path, mode_t mode);
.b2c.defExtFn[`fcntl;`C.open;`c.i`chk1;`c.S`c.i;()]; / int open(const char *path, int oflag, ...);
.b2c.defExtFn[`fcntl;`C.openat;`c.i`chk1;`c.i`c.S`c.i;()]; / int openat(int fd, const char *path, int oflag, ...);
.b2c.defExtFn[`fcntl;`C.fcntl;`c.i`chk1;`c.i`c.i;()]; / int fcntl(int fildes, int cmd, ...);
.b2c.defExtFn[`fcntl;`C.fcntlSETX;`c.i`chk1;`c.i`c.i`c.i;()]; / SETFD, SETFL, SETOWN case
.b2c.defExtFn[`fcntl;`C.fcntlGETLK;`c.i`chk1;(`c.i;`c.i;`c.s_flock`out);()]; / GETLK
.b2c.defExtFn[`fcntl;`C.fcntlSETLK;`c.i`chk1;(`c.i;`c.i;`c.s_flock`c.s_flock_p);()]; / SETLK SETLKW
.b2c.overload[`fcntl;`C.fcntlSETX`C.fcntlGETLK`C.fcntlSETLK]; / overload fcntl
