\l ../q2b.q
\l ../b2c.q
\l ../std.q
\l ../lib/time.q
\l ../lib/string.q

.se.qsortf:{"c)`c.i`c.cvoid_p`c.cvoid_p"; c.j.a:(*)`c.J$`c.void_p$x; c.j.b:(*)`c.J$`c.void_p$y; $[c.a>c.b;`c.i$1i;c.a<c.b;`c.i$-1i;`c.i$0i]};
.se.qsort:{
  a:$[(::)~x;100?1000;x];
  C.qsort[`c.void_p$`c.J$a;`c.size_t$`c.ij$`c.j$count a;count`c.j;(&).se.qsortf];
  -1 "QSORT: ",$[a~asc a;"SUCCESS";"FAIL"];
  :a;
 };

.se.file:{
  f:.std.fopen[`std.q;`r];
  -1 "Read 100 chars"; buf:100#" ";
  r:.std.fread[buf;f];
  -1 "Res size: ",string[r],", res: ",buf; / can't contain \000
  -1 "Read a string"; buf:200#" ";
  .std.fgets[buf;f];
  -1 "Res: ",(buf?"\000")#buf; / only valid part
  -1 "Open xxx.q";
  @[{.std.fopen[`xxx.q;`r]};1;{-1 "Exc: ",x}];
  -1 "Close";
  .std.fclose f;
 };

l:.b2c.compile[`.se.qsort`.se.file;`libname`rec`goal`k!(`stdex;1b;`load;"..")];

l[`.se.qsort][];
l[`.se.file][];

exit 0;
