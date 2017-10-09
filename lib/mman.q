.b2c.include,:"<sys/mman.h>";

{.b2c.defExtVar[;`c.i]each a:` sv/:`C,/:`PROT_READ`PROT_WRITE`PROT_EXEC`PROT_NONE`MAP_SHARED`MAP_PRIVATE`MAP_FIXED`MS_ASYNC`MS_SYNC`MS_INVALIDATE`MCL_CURRENT`MCL_FUTURE;
 .b2c.defExtConstFn[`mman;a];
 }[]

/ int mlock(const void *addr, size_t len);
.b2c.defExtFn[`mman;`munlock;`c.i`chk1;(enlist `c.ij`c.void_p;`c.size_t);()]; / int munlock(const void *addr, size_t len);
.b2c.defExtFn[`mman;`mlockall;`c.i`chk1;`c.i;()]; / int mlockall(int flags);
.b2c.defExtFn[`mman;`mlockall;`c.i`chk1;`c.void;()]; / int munlockall(void);
/ mmap returns (ptr;size)
.b2c.defExtFn[`mman;`mmap;(`c.void_p`c.ij;(`chk1`c.ij;`retVal));(enlist `c.ij`c.void_p;`c.size_t`in_out;`c.i;`c.i;`c.i;`c.off_t);()]; / void *mmap(void *addr, size_t len, int prot, int flags, int fildes, off_t off)
.b2c.defExtFn[`mman;`munmap;`c.i`chk1;(enlist `c.ij`c.void_p;`c.size_t);()]; / int munmap(void *addr, size_t length);
.b2c.defExtFn[`mman;`mprotect;`c.i`chk1;(enlist `c.ij`c.void_p;`c.size_t;`c.i);()]; / int mprotect(void *addr, size_t len, int prot);
.b2c.defExtFn[`mman;`msync;`c.i`chk1;(enlist `c.ij`c.void_p;`c.size_t;`c.i);()]; / int msync(void *addr, size_t len, int flags);
.b2c.defExtFn[`mman;`shm_open;`c.i`chk1;`c.S`c.i`c.mode_t;()]; / int shm_open(const char *name, int oflag, mode_t mode);
.b2c.defExtFn[`mman;`shm_unlink;`c.i`chk1;`c.S;()]; / int shm_unlink(const char *name);

.mman.tmap:(20#.Q.t)!0 1 0 0 1 2 4 8 4 8 1 0 8 4 4 8 8 4 4 4;
.mman.read:{[ptr;off;ty;sz]
  if[0=0^tsz:.mman.tmap ty; '".mman.read: type"];
  if[(sz<=0)|(off<0)|ptr[1]<=off+sz*tsz; '".mman.read: length"];
  r:C.ktn[`c.i$"i"$.Q.t?ty; `c.j$sz];
  C.memcpy[`c.void_p$(`c.unsafe_k$r)`G0; `c.void_p$`c.ij$.b2c.c ptr[0]+off; `c.size_t$.b2c.c sz*tsz];
  :$[sz=1;r 0;r];
 };
.mman.write:{[ptr;off;dt]
  dt:(),dt;
  if[0=tsz:0^value[.mman.tmap]type dt; '".mman.write: type"];
  if[0=sz:count dt; :()];
  if[(off<0)|ptr[1]<=off+sz*tsz; '".mman.write: length"];
  C.memcpy[`c.void_p$`c.ij$.b2c.c ptr[0]+off; `c.void_p$(`c.unsafe_k$dt)`G0; `c.size_t$.b2c.c sz*tsz];
  :();
 };
