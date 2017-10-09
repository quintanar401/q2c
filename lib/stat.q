.b2c.include,:"<sys/stat.h>";

{.b2c.defExtVar[;`c.i]each a:` sv/:`C,/:`S_IFMT`S_IFBLK`S_IFCHR`S_IFIFO`S_IFREG`S_IFDIR`S_IFLNK`S_IFSOCK`S_IRWXU`S_IRUSR`S_IWUSR`S_IXUSR`S_IRWXG`S_IRGRP`S_IWGRP`S_IXGRP`S_IRWXO`S_IROTH`S_IWOTH`S_IXOTH`S_ISUID`S_ISGID`S_ISVTX;
 .b2c.defExtConstFn[`stat;a];
 }[]

/ types
.b2c.defExtType[;()]each`c.dev_t`c.blkcnt_t`c.blksize_t`c.ino_t`c.nlink_t;
.b2c.defCCast each (`c.j`c.dev_t;`c.dev_t`c.j;`c.i`c.nlink_t;`c.nlink_t`c.i);
.b2c.defCCast each {(`c.ij,/:x),x,\:`c.ij}`c.blkcnt_t`c.blksize_t`c.ino_t;
.b2c.defCCast each {(.b2c.it,/:x),x,\:.b2c.it}`c.blkcnt_t`c.blksize_t`c.ino_t;
.b2c.defCompCast each (`K`c.j`c.dev_t;`K,.b2c.it,`c.blkcnt_t;`K,.b2c.it,`c.blksize_t;`K,.b2c.it,`c.ino_t;`K`c.i`c.nlink_t);

/ read only
{.b2c.defExtStruct[`stat;`st_dev`st_ino`st_mode`st_nlink`st_uid`st_gid`st_rdev`st_size`st_atim`st_mtim`st_ctim`st_blksize`st_blocks!`c.dev_t`c.ino_t`c.mode_t`c.nlink_t`c.uid_t`c.gid_t`c.dev_t`c.off_t`c.s_timespec`c.s_timespec`c.s_timespec`c.blksize_t`c.blkcnt_t;();
  `st_dev`st_ino`st_mode`st_nlink`st_uid`st_gid`st_rdev`st_size`st_atim`st_mtim`st_ctim`st_blksize`st_blocks!(`c.dev_t`c.j;`c.ino_t`c.ij;`c.mode_t`c.i;`c.nlink_t`c.i;`c.uid_t`c.i;`c.gid_t`c.i;`c.dev_t`c.j;`c.off_t`c.ij;`c.s_timespec;`c.s_timespec;`c.s_timespec;`c.blksize_t`c.ij;`c.blkcnt_t`c.ij)];
 }[]

.b2c.defExtFn[`stat;`chmod;`c.i`chk1;`c.S`c.mode_t;()]; / int chmod(const char *path, mode_t mode);
.b2c.defExtFn[`stat;`fchmodat;`c.i`chk1;`c.i`c.S`c.mode_t`c.i;()]; / int fchmodat(int fd, const char *path, mode_t mode, int flag);
.b2c.defExtFn[`stat;`fchmod;`c.i`chk1;`c.i`c.mode_t;()]; / int fchmod(int fildes, mode_t mode);
.b2c.defExtFn[`stat;`fstat;`c.i`chk1;(`c.i;`c.s_stat`out);()]; / int fstat(int fildes, struct stat *buf);
.b2c.defExtFn[`stat;`fstatat;`c.i`chk1;(`c.i;`c.S;`c.s_stat`out;`c.i);()]; / int fstatat(int fd, const char *restrict path,  struct stat *restrict buf, int flag);
.b2c.defExtFn[`stat;`lstat;`c.i`chk1;(`c.S;`c.s_stat`out);()]; / int lstat(const char *restrict path, struct stat *restrict buf);
.b2c.defExtFn[`stat;`stat;`c.i`chk1;(`c.S;`c.s_stat`out);()]; / int stat(const char *restrict path, struct stat *restrict buf);
.b2c.defExtFn[`stat;`mkdir;`c.i`chk1;(`c.S;`c.mode_t);()]; / int mkdir(const char *path, mode_t mode);
.b2c.defExtFn[`stat;`mkdirat;`c.i`chk1;(`c.i;`c.S;`c.mode_t);()]; / int mkdirat(int fd, const char *path, mode_t mode);
.b2c.defExtFn[`stat;`mkfifo;`c.i`chk1;(`c.S;`c.mode_t);()]; / int mkfifo(const char *path, mode_t mode);
.b2c.defExtFn[`stat;`mkfifoat;`c.i`chk1;(`c.i;`c.S;`c.mode_t);()]; / int mkfifoat(int fd, const char *path, mode_t mode);
.b2c.defExtFn[`stat;`mknod;`c.i`chk1;(`c.S;`c.mode_t;`c.dev_t);()]; / int mknod(const char *path, mode_t mode, dev_t dev);
.b2c.defExtFn[`stat;`mknodoat;`c.i`chk1;(`c.i;`c.S;`c.mode_t;`c.dev_t);()]; / int mknodat(int fd, const char *path, mode_t mode, dev_t dev);
.b2c.defExtFn[`stat;`umask;enlist`c.mode_t`c.i;`c.mode_t;()]; / mode_t umask(mode_t cmask);
