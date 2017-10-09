\l ../q2b.q
\l ../b2c.q
\l ../std.q
\l ../lib/time.q
\l ../lib/string.q
\l ../lib/stat.q
\l ../lib/fcntl.q
\l ../lib/mman.q
\l ../lib/unistd.q

.sh.parent:{
  -1 "[P]Open shared mem fd(create+rw)";
  fd:.mman.shm_open[`shm_test;.sh.consts[`O_RDWR]+.sh.consts[`O_CREAT];.sh.consts[`S_IRUSR]+.sh.consts[`S_IWUSR]];
  -1 "[P]Set size to ",string sz:prd 25#2;
  .unistd.ftruncate[fd;.b2c.c sz];
  -1 "[P]Mmap fd";
  ptr:.mman.mmap[.b2c.c 0;.b2c.c sz;.sh.consts[`PROT_READ]+.sh.consts[`PROT_WRITE];.sh.consts`MAP_SHARED;fd;.b2c.c 0];
  -1 "[P]Ptr: ",.Q.s1 ptr;
  -1 "[P]Parent will wait for the child";
  .mman.write[ptr;0;0];
  while[0=ds:.mman.read[ptr;0;"j";1]; -1 "[P]Sleep for 5 sec"; .unistd.sleep 5i];
  -1 "[P]Got data, size ",string ds;
  dt:-9!.mman.read[ptr;8;"x";ds];
  -1 "[P]Result: ",.Q.s dt;
  .mman.shm_unlink`shm_test;
  -1 "[P]Exit";
 };

.sh.child:{
  -1 "[C]Child will sleep for 10 sec, hopefully the parent will be ready";
  .unistd.sleep[10i];
  -1 "[C]Open shared mem";
  fd:.mman.shm_open[`shm_test;.sh.consts[`O_RDWR];.sh.consts[`S_IRUSR]+.sh.consts[`S_IWUSR]];
  -1 "[C]Mmap fd";
  sz:prd 25#2;
  ptr:.mman.mmap[.b2c.c 0;.b2c.c sz;.sh.consts[`PROT_READ]+.sh.consts[`PROT_WRITE];.sh.consts`MAP_SHARED;fd;.b2c.c 0];
  -1 "[C]Ptr: ",.Q.s1 ptr;
  dt:([] a:20?20; s:20?`5);
  -1 "[C]Send data to the parent";
  dt:-8!dt;
  .mman.write[ptr;0;count dt];
  .mman.write[ptr;8;dt];
  -1 "[C]Exit";
 };

.sh.run:{
  -1 "[P]forking a child";
  $[.unistd.fork[];.sh.parent[];.sh.child[]];
 };

l:.b2c.compile[`.stat.getConsts`.fcntl.getConsts`.mman.getConsts`.sh.run;`libname`rec`goal`k!(`shmemex;1b;`load;"..")];

.sh.consts:(l[`.stat.getConsts][]),(l[`.mman.getConsts][]),l[`.fcntl.getConsts][];
l[`.sh.run][];

exit 0;
