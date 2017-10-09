\l ../q2b.q
\l ../b2c.q
\l ../std.q
\l ../lib/time.q
\l ../lib/string.q
\l ../lib/stat.q

.st.stat:{
  -1 "Stat stat.q";
  s:.stat.stat `stat.q;
  -1 "Result: ",.Q.s s;
 };

l:.b2c.compile[`.stat.getConsts`.st.stat;`libname`rec`goal`k!(`statex;1b;`load;"..")];

.st.consts:l[`.stat.getConsts][];
l[`.st.stat][];

exit 0;
