\l ../q2b.q
\l ../b2c.q
\l ../std.q

.tt.global1:10; / init now
.tt.wglobal1:10;
.tt.global2:10; / on load
.tt.wglobal2:10;
.tt.global3:10; / default
.tt.wglobal3:10;


.t.block:{
  v:10; s:0;
  while[v>0;s+:1; v-:1]; v:11; c.i.a:11i; while[c.a>0; s+:C.toK c.a; c.a-:1i]; c.j.b:12; while[c.b>0; s+:C.toK c.b; c.b-:1];
  do[13; s+:1]; c.a:14i; do[c.a; s+:C.toK c.a]; c.b:15; do[c.b; s+:C.toK c.b]; c.b:-1; do[c.b; s-:1000]; do[`c.i$-1i; s-:1000]; v:-1; do[`c.j$v; s-:1000];
  c.b:0; do[c.b; s-:1000]; do[`c.i$0i; s-:1000]; v:0; do[`c.j$v; s-:1000];
  a:sum 588=s;
  s:0;
  do[16;s+:C.toK c.do1]; do[3;do[4;s+:C.toK c.do1*c.do2]];
  a:a&s=120+18;
  :a;
 };

.t.ops:{
  c.i.a:2i; c.j.b:3; c.ij.b2:`c.ij$`c.j$3; c.f.c:4.0; c.schar.d:(`c.k$7i)`t; c.long.e:`c.long$8i; aa:5; bb:6;
  a:(4i;5;5;6;8f;6f;6f;7f;7f;11)~(C.ki c.a+c.a;C.kj c.a+c.b;C.kj c.b+c.a;C.kj c.b+c.b;C.kf c.c+c.c;C.kf c.a+c.c;C.kf c.c+c.a;C.kf c.b+c.c;C.kf c.c+c.b; aa+bb); / +
  a:a&(0i;-1;1;0;0f;-2f;2f;-1f;1f;-1)~(C.ki c.a-c.a;C.kj c.a-c.b;C.kj c.b-c.a;C.kj c.b-c.b;C.kf c.c-c.c;C.kf c.a-c.c;C.kf c.c-c.a;C.kf c.b-c.c;C.kf c.c-c.b; aa-bb); / -
  a:a&(4i;6;6;9;16f;8f;8f;12f;12f;30)~(C.ki c.a*c.a;C.kj c.a*c.b;C.kj c.b*c.a;C.kj c.b*c.b;C.kf c.c*c.c;C.kf c.a*c.c;C.kf c.c*c.a;C.kf c.b*c.c;C.kf c.c*c.b; aa*bb); / *
  a:a&(1f;2%3;3%2;1f;1f;1%2;2f;3%4;4%3;5%6)~(C.kf c.a%c.a;C.kf c.a%c.b;C.kf c.b%c.a;C.kf c.b%c.b;C.kf c.c%c.c;C.kf c.a%c.c;C.kf c.c%c.a;C.kf c.b%c.c;C.kf c.c%c.b; aa%bb); / %
  a:a&(-2i;-3;-4f;-5;2i;3;4f;5;1b;0b)~(C.ki neg c.a;C.kj neg c.b;C.kf neg c.c;neg aa;C.ki abs c.a;C.kj abs c.b;C.kf abs c.c;abs aa;C.kb `c.i$not c.a>c.b;not aa);
  a:a&00101001010100010100b~(C.kb`c.i$c.a>c.a;C.kb`c.i$c.a>c.b;C.kb`c.i$c.b>c.a;C.kb`c.i$c.b>c.b;C.kb`c.i$c.c>c.b;C.kb`c.i$c.b>c.c;C.kb`c.i$c.a>c.c;C.kb`c.i$c.c>c.a;C.kb`c.i$c.c>c.c;
    C.kb`c.i$c.a>c.d;C.kb`c.i$c.d>c.a;C.kb`c.i$c.b>c.d;C.kb`c.i$c.d>c.b;C.kb`c.i$c.d>c.d;C.kb`c.i$c.a>c.e;C.kb`c.i$c.e>c.a;C.kb`c.i$c.b>c.e;C.kb`c.i$c.e>c.b;C.kb`c.i$c.e>c.e;aa>bb);
  a:a&01000110001010101001b~(C.kb`c.i$c.a<c.a;C.kb`c.i$c.a<c.b;C.kb`c.i$c.b<c.a;C.kb`c.i$c.b<c.b;C.kb`c.i$c.c<c.b;C.kb`c.i$c.b<c.c;C.kb`c.i$c.a<c.c;C.kb`c.i$c.c<c.a;C.kb`c.i$c.c<c.c;
    C.kb`c.i$c.a<c.d;C.kb`c.i$c.d<c.a;C.kb`c.i$c.b<c.d;C.kb`c.i$c.d<c.b;C.kb`c.i$c.d<c.d;C.kb`c.i$c.a<c.e;C.kb`c.i$c.e<c.a;C.kb`c.i$c.b<c.e;C.kb`c.i$c.e<c.b;C.kb`c.i$c.e<c.e;aa<bb);
  a:a&10010000100001000010b~(C.kb`c.i$c.a=c.a;C.kb`c.i$c.a=c.b;C.kb`c.i$c.b=c.a;C.kb`c.i$c.b=c.b;C.kb`c.i$c.c=c.b;C.kb`c.i$c.b=c.c;C.kb`c.i$c.a=c.c;C.kb`c.i$c.c=c.a;C.kb`c.i$c.c=c.c;
    C.kb`c.i$c.a=c.d;C.kb`c.i$c.d=c.a;C.kb`c.i$c.b=c.d;C.kb`c.i$c.d=c.b;C.kb`c.i$c.d=c.d;C.kb`c.i$c.a=c.e;C.kb`c.i$c.e=c.a;C.kb`c.i$c.b=c.e;C.kb`c.i$c.e=c.b;C.kb`c.i$c.e=c.e;aa=bb);
  a:a&01101111011110111101b~(C.kb`c.i$c.a<>c.a;C.kb`c.i$c.a<>c.b;C.kb`c.i$c.b<>c.a;C.kb`c.i$c.b<>c.b;C.kb`c.i$c.c<>c.b;C.kb`c.i$c.b<>c.c;C.kb`c.i$c.a<>c.c;C.kb`c.i$c.c<>c.a;C.kb`c.i$c.c<>c.c;
    C.kb`c.i$c.a<>c.d;C.kb`c.i$c.d<>c.a;C.kb`c.i$c.b<>c.d;C.kb`c.i$c.d<>c.b;C.kb`c.i$c.d<>c.d;C.kb`c.i$c.a<>c.e;C.kb`c.i$c.e<>c.a;C.kb`c.i$c.b<>c.e;C.kb`c.i$c.e<>c.b;C.kb`c.i$c.e<>c.e;aa<>bb);
  a:a&10111001110101010110b~(C.kb`c.i$c.a>=c.a;C.kb`c.i$c.a>=c.b;C.kb`c.i$c.b>=c.a;C.kb`c.i$c.b>=c.b;C.kb`c.i$c.c>=c.b;C.kb`c.i$c.b>=c.c;C.kb`c.i$c.a>=c.c;C.kb`c.i$c.c>=c.a;C.kb`c.i$c.c>=c.c;
    C.kb`c.i$c.a>=c.d;C.kb`c.i$c.d>=c.a;C.kb`c.i$c.b>=c.d;C.kb`c.i$c.d>=c.b;C.kb`c.i$c.d>=c.d;C.kb`c.i$c.a>=c.e;C.kb`c.i$c.e>=c.a;C.kb`c.i$c.b>=c.e;C.kb`c.i$c.e>=c.b;C.kb`c.i$c.e>=c.e;aa>=bb);
  a:a&11010110101011101011b~(C.kb`c.i$c.a<=c.a;C.kb`c.i$c.a<=c.b;C.kb`c.i$c.b<=c.a;C.kb`c.i$c.b<=c.b;C.kb`c.i$c.c<=c.b;C.kb`c.i$c.b<=c.c;C.kb`c.i$c.a<=c.c;C.kb`c.i$c.c<=c.a;C.kb`c.i$c.c<=c.c;
    C.kb`c.i$c.a<=c.d;C.kb`c.i$c.d<=c.a;C.kb`c.i$c.b<=c.d;C.kb`c.i$c.d<=c.b;C.kb`c.i$c.d<=c.d;C.kb`c.i$c.a<=c.e;C.kb`c.i$c.e<=c.a;C.kb`c.i$c.b<=c.e;C.kb`c.i$c.e<=c.b;C.kb`c.i$c.e<=c.e;aa<=bb);
  a:a&100110b~(C.kb`c.i$(`c.void_p$c.b2)=`c.void_p$c.b2;C.kb`c.i$(`c.void_p$c.b2)<`c.void_p$c.b2;C.kb`c.i$(`c.void_p$c.b2)>`c.void_p$c.b2;C.kb`c.i$(`c.void_p$c.b2)>=`c.void_p$c.b2;
    C.kb`c.i$(`c.void_p$c.b2)<=`c.void_p$c.b2;C.kb`c.i$(`c.void_p$c.b2)<>`c.void_p$c.b2);
  a:a&(1b;0b;5;6)~(C.kb`c.i$(c.a=c.a)|(c.a=c.b);C.kb`c.i$(c.a=c.a)&(c.a=c.b);aa&bb;aa|bb);
  :a;
 };

.t.ops2:{
  c.i.a:2i; c.j.b:4; c.long.c:`c.long$8i; c.uint.d:`c.uint$16i; b:6;
  a:(2i;4;8i;16i;2)~(C.toK c.a&6i;C.toK c.b&12;C.toK c.c&`c.long$12i;C.toK c.d&`c.uint$20i;b&2); / bin &
  a:a&(6i;12;24i;48i;10)~(C.toK c.a|4i;C.toK c.b|8;C.toK c.c|`c.long$16i;C.toK c.d|`c.uint$32i;b|10); / bin |
  a:a&(4i;8;4i;4i;6)~(C.toK c.a^6i;C.toK c.b^12;C.toK c.c^`c.long$12i;C.toK c.d^`c.uint$20i;2^b); / bin ^
  a:a&(-3i;-5;-9i;-17i)~(C.toK not c.a;C.toK not c.b;C.toK not c.c;C.toK not c.d);
  :a;
 };

.t.ifuncs:{
  v1:10; v2:20;
  a:01b~(C.kb `c.i$C.isnan 1f;C.kb `c.i$C.isnan 0nf);
  a:a&((::),enlist[v1])~(::),C.knk v1;
  a:a&(::;v1;v2)~(::),C.knk[v1;v2];
  a:a&(::;v1;v2;v1;v2;v1;v2;v1;v2;v1;v2)~(::),C.knk[v1;v2;v1;v2;v1;v2;v1;v2;v1;v2];
  a:a&{x+y}[1;2]~C.dot[{x+y};(1;2)];
  a:a&3~C.dot[+;(1;2)];
  a:a&200~C.k[`c.i$0i;`c.S$"{x*y}";10;20];
  a:a&{(10=count x)&7=type x}C.ktn[7i;10];
  a:a&all("abc"~C.kpn[`c.S$"abcde";3];-6=type C.ka -6i;1b~C.kb 1i;0x10~C.kg 16i;10h=C.kh 10i;10i=C.ki 10i;10=C.kj 10;10e=C.ke 10f;10f=C.kf 10f;"a"~C.kc 97i;`sym~C.ks`c.C$"sym\000";`sym~C.ks`c.S$"sym";`sym~C.ks`c.S$`sym);
  tp:.z.P; tn:0D10:00; tt:.z.T; td:.z.D; dd:.z.Z;
  a:a&all(tp=C.ktj[-12i;`c.j$tp];tt=C.kt `c.i$tt;td=C.kd `c.i$td;tn=C.ktj[-16i;`c.j$tn];dd=C.kz`c.f$"f"$dd);
  :a;
 };

.t.toK:{
  a:10; b:C.toK `c.unsafe_k$a; c:C.toK `c.k$a; s:`1234;
  d:all(b~10;c~10;10i~C.toK `c.i$10i;10~C.toK `c.j$10;10f~C.toK `c.f$10f;10h~C.toK `c.h$10h;1b~C.toK 1i<`c.i$10;9i~C.toK`c.long$9i;8i~C.toK`c.uint$8i); / basic casts
  d:d&all(1b~C.toKb `c.i$1i;0x10~C.toKx `c.i$16i;3h~C.toKh`c.i$3i;4i~C.toKi`c.i$4i;5~C.toKj `c.j$5;6e~C.toKe `c.f$6f;7f~C.toKf `c.f$7f;"a"~C.toKc`c.i$97i;2001.01.01D00:00:01~C.toKp `c.j$31622401000000000;
    10:00:00.0~C.toKt`c.i$36000000i;2001.01.01~C.toKd`c.i$366i; 0D00:00:01~C.toKn`c.j$1000000000); / extended casts
  d:d&string[s]~C.toK `c.S$s; / string copycast
  :d;
 };

.t.casts:{
  i:10i; j:20; f:30f; h:40h; tp:.z.P; tn:.z.N; tt:.z.T; td:.z.D;
  a:all(i=C.toK `c.i$i;tt=C.toKt `c.i$tt;td=C.toKd `c.i$td;j=C.toK `c.j$j;tp=C.toKp `c.j$tp;tn=C.toKn `c.j$tn;f=C.toK `c.f$f;h=C.toK `c.h$h);
  i:3#i; j:3#j; f:3#f; h:3#h; s:`sym; str:"str\000"; str2:"str";
  a:a&all(i~C.toK[`c.I$i;3];j~C.toK[`c.J$j;3];f~C.toK[`c.F$f;3];h~C.toK[`c.H$h;3];"sym"~C.toK `c.S$s;"str"~C.toK `c.S$str;"str"~C.toK[`c.C$str2;3]);
  :a;
 };

.tt.p0:({""};{"a+1;"};{"2+"};{"(a+1)+"});
.tt.p1:({""};{("+";"-")x mod 2});
.tt.p2:({""};{"[",string[x mod 10],"]"};{"[{0 1+x}",string[0|-1+x mod 10],"]"});
.tt.p3:({string x mod 10};{"a+1"});
.tt.p4:({""};{";",string x mod 10};{";a+1"});
.tt.mktst:{[v1;v2] r:" "sv{r:(-1_value z)@\:z`idx; v:r[0],$[count r 2;y;x],r[2],r[1],":",r[3],r[4]; $[(last[r 0]=";")|count r 4;"acc+:sum raze//[(",v,")]";count r 0;"acc+:sum raze//[",v,"]";v],"; acc+:",
   $[count r 2;"sum ",y;x],";"}[v1;v2]each update idx:i from flip `p0`p1`p2`p3`p4!flip cross/[(.tt.p0;.tt.p1;.tt.p2;.tt.p3;.tt.p4)]; : v1,":0; ",v2,":til 10; acc:0; a:3; ",r," : acc+",v1,"+sum ",v2,"}"};
.tt.atstloc:value "{",.tt.mktst["atm";"lst"];
.tt.atstarg:value "{[atm;lst]",.tt.mktst["atm";"lst"];
.tt.atstqglob:value "{",.tt.mktst[".tt.atm";".tt.lst"];
.tt.atstglob:value "{",.tt.mktst[".tt.global1";".tt.global2"];
.tt.atstwglob:value "{",.tt.mktst[".tt.wglobal1";".tt.wglobal2"];
.t.assign:{
  a:all 6107=(.tt.atstloc[];.tt.atstarg[1;2];.tt.atstqglob[];.tt.atstglob[];.tt.atstwglob[]);
  :a;
 };

.tt.getc:{enlist[til 100],til 100};
.tt.globsQ:{
  @[`.tt.qglobal;10;+;1]; @[`.tt.qglobal;10;neg]; .[`.tt.qglobal;0 10;*;20]; .[`.tt.qglobal;0 10;neg];
  : all(all .tt.qglobal[10]=-10;.tt.qglobal[0;10]=-200);
 };
.tt.upsQ:{`.tt.qglobal upsert 1};
.tt.globsG:{
  @[`.tt.global1;10;+;1]; @[`.tt.global1;10;neg]; .[`.tt.global1;0 10;*;20]; .[`.tt.global1;0 10;neg];
  : all(all .tt.global1[10]=-10;.tt.global1[0;10]=-200);
 };
.tt.upsG:{`.tt.global1 upsert 1};
.tt.globsW:{
  @[`.tt.wglobal1;10;+;1]; @[`.tt.wglobal1;10;neg]; .[`.tt.wglobal1;0 10;*;20]; .[`.tt.wglobal1;0 10;neg];
  : all(all .tt.wglobal1[10]=-10;.tt.wglobal1[0;10]=-200);
 };
.tt.upsW:{`.tt.wglobal1 upsert 1};
.t.qglobs:{
  .tt.qglobal:10;
  a:all(10=.[get;(),`.tt.qglobal];"type"~@[{.tt.qglobal+:`a};1;::];10=.[get;(),`.tt.qglobal];10=value `.tt.qglobal);
  `.tt.qglobal set 20;
  a:a&20=.[get;(),`.tt.qglobal];
  .tt.qglobal:([] a:til 100);
  `a xdesc `.tt.qglobal; a:a&99=.tt.qglobal[0;`a]; `a xasc `.tt.qglobal; a:a&0=.tt.qglobal[0;`a];
  a:a&all(meta[.tt.qglobal]~meta `.tt.qglobal;cols[.tt.qglobal]~cols `.tt.qglobal);
  .tt.upsQ[];
  a:a&101=count .tt.qglobal;
  .tt.runf:.tt.upsQ;
  a:a&500>last system "ts .tt.runf[]"; / memory consumption
  .tt.qglobal:`a`b!1 2;
  a:a&key[.tt.qglobal]~key `.tt.qglobal;
  .tt.runf:.tt.globsQ;
  .tt.qglobal:.tt.getc[];
  a:a&.tt.globsQ[];
  .tt.qglobal:.tt.getc[];
  a:a&500>last system "ts .tt.runf[]";
  :a;
 };
.t.globs:{
  .tt.global1:10;
  a:0=@[{.[get;(),`.tt.global1]};1;0];  / should not exist
  a:a&all(10=value`.tt.global1;"type"~@[{.tt.global1+:`a};1;::];10=value `.tt.global1);
  `.tt.global1 set 20;
  a:a&0=@[{.[get;(),`.tt.global1]};1;0];  / should not exist
  a:a&20=value `.tt.global1;
  .tt.global1:([] a:til 100);
  `a xdesc `.tt.global1; a:a&99=.tt.global1[0;`a]; `a xasc `.tt.global1; a:a&0=.tt.global1[0;`a];
  a:a&all(meta[.tt.global1]~meta `.tt.global1;cols[.tt.global1]~cols `.tt.global1);
  .tt.upsG[];
  a:a&101=count .tt.global1;
  .tt.runf:.tt.upsG;
  a:a&500<last system "ts .tt.runf[]"; / memory consumption
  .tt.global1:`a`b!1 2;
  a:a&key[.tt.global1]~key `.tt.global1;
  .tt.runf:.tt.globsG;
  .tt.global1:.tt.getc[];
  a:a&.tt.globsG[];
  .tt.global1:.tt.getc[];
  a:a& (2000 1700 .b2c.is32)<last system "ts .tt.runf[]";
  .tt.global1:v:([]a:1 2 3);
  @[{`.tt.global1 upsert `h};1;::];
  a:a&v~.tt.global1; / value not deleted
  .tt.global1:v:1 2 3;
  @[{@[`.tt.global1;0;+;`a]};1;::];
  a:a&v~.tt.global1; / value not deleted
  .tt.global1:v:(1 2 3;1 2 3);
  @[{.[`.tt.global1;0 1;+;`a]};1;::];
  a:a&v~.tt.global1; / value not deleted
  .tt.global1:v:1 2 3;
  @[{@[`.tt.global1;0;{`a+x}]};1;::];
  a:a&v~.tt.global1; / value not deleted
  .tt.global1:v:(1 2 3;1 2 3);
  @[{.[`.tt.global1;0 1;{`a+x}]};1;::];
  a:a&v~.tt.global1; / value not deleted
  :a;
 };
.t.wglobs:{
  .tt.wglobal1:10;
  a:0=@[{.[get;(),`.tt.wglobal1]};1;0];  / should not exist
  a:a&all(()~value`.tt.wglobal1;"type"~@[{.tt.wglobal1+:`a};1;::];10=value `.tt.wglobal1);
  `.tt.wglobal1 set 20;
  a:a&0=@[{.[get;(),`.tt.wglobal1]};1;0];  / should not exist
  a:a&20=value `.tt.wglobal1;
  .tt.wglobal1:([] a:til 100);
  `a xdesc `.tt.wglobal1; a:a&99=.tt.wglobal1[0;`a]; `a xasc `.tt.wglobal1; a:a&0=.tt.wglobal1[0;`a];
  a:a&all(meta[.tt.wglobal1]~meta `.tt.wglobal1;cols[.tt.wglobal1]~cols `.tt.wglobal1);
  .tt.upsW[];
  a:a&101=count .tt.wglobal1;
  .tt.runf:.tt.upsW;
  a:a&500>last system "ts .tt.runf[]"; / memory consumption
  .tt.wglobal1:`a`b!1 2;
  a:a&key[.tt.wglobal1]~key `.tt.wglobal1;
  .tt.runf:.tt.globsW;
  .tt.wglobal1:.tt.getc[];
  a:a&.tt.globsW[];
  .tt.wglobal1:.tt.getc[];
  a:a&500>last system "ts .tt.runf[]";
  .tt.wglobal1:([]a:1 2 3);
  @[{`.tt.wglobal1 upsert `h};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  .tt.wglobal1:1 2 3;
  @[{@[`.tt.wglobal1;0;+;`a]};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  .tt.wglobal1:(1 2 3;1 2 3);
  @[{.[`.tt.wglobal1;0 1;+;`a]};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  .tt.wglobal1:1 2 3;
  @[{@[`.tt.wglobal1;0;{`a+x}]};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  .tt.wglobal1:(1 2 3;1 2 3);
  @[{.[`.tt.wglobal1;0 1;{`a+x}]};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  / now the same with 0 refs
  .tt.wglobal1:flip enlist[`a]!enlist{1 2 3}[];
  @[{`.tt.wglobal1 upsert `h};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  .tt.wglobal1:{1 2}[],3;
  @[{@[`.tt.wglobal1;0;+;`a]};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  .tt.wglobal1:({1 2 3}[];{1 2 3}[]);
  @[{.[`.tt.wglobal1;0 1;+;`a]};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  .tt.wglobal1:1,{2 3}[];
  @[{@[`.tt.wglobal1;0;{`a+x}]};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  .tt.wglobal1:({1 2 3}[];{1 2 3}[]);
  @[{.[`.tt.wglobal1;0 1;{`a+x}]};1;::];
  a:a&()~.tt.wglobal1; / value deleted
  :a;
 };

.tt.fnvar11:{"c)`c.f`c.f`c.f"; x+y+1};
.tt.fnvar12:{"c)`c.f`c.f`c.f"; x+y+2};
.tt.fnvar2:{"c)`K`c.j`c.j"; C.toK y+x+2};
.b2c.defType[`c.fnvar;`f`c.f`c.f`c.f];
.b2c.defType[`c.fnarr;(`a;2;`c.fnvar_p)];
.tt.fnvar:{
  "c)`K`c.j`c.j";
  if[x;:C.toK x+y];
  v:10;
  a:30=$[v;(&).z.s;(&).tt.fnvar2][10;20]; / call .z.s by ref is ok
  a:a&32=$[not v;(&).z.s;(&).tt.fnvar2][10;20]; / call another c func by ref is ok
  c.fnarr.a[0]:(&).tt.fnvar11;
  c.a[1]:(&).tt.fnvar12;
  a:a&25f~C.toK c.a[0][5f;5f]+c.a[1][6f;6f]; / save fn in an arr and call it
  :a;
 };
.t.fnvar:{.tt.fnvar[0;0]};

.tt.fnqvarf:{x+1};
.tt.fnqvarg:{x+2};
.t.fnqvar:{
  a:11=1+$[1;10;11];
  f:{x+1}; g:{x+2};
  a:a&11=$[1;f;g]10;
  a:a&11=$[1;.tt.fnqvarf;.tt.fnqvarg]10;
  :a;
 };

.t.cfncall:{20i=C.toK {"c)`c.i`c.i`c.i";x+y}[10i;10i]};

.t.sizeof:{8=C.toK `c.ij$count `c.j};

.t.globs2:{all(.tt.global1=10;.tt.wglobal1=10;.tt.global2=100;.tt.wglobal2=100;.tt.global3~();.tt.wglobal3~())};

.t.cassign:{r:C.toK c.i.r:$[1;`c.i$1i;`c.i$0i]; r2:C.toK c.i.r2:$[1;c.r+`c.i$0i;c.r+`c.i$1i]; all(C.toK c.r=`c.i$1i; C.toK c.r2=`c.i$1i; r=1i; r2=1i)};

.t.crval:{a:1=C.toK{"c)`c.j`c.void"; $[1;`c.j$1;`c.j$0]}[]; a:a&11=C.toK{"c)`c.j`c.void"; c.j.v:10; $[1;c.v+`c.j$1;c.v+`c.j$0]}[]; a};

.t.takeref:{ c.i.a:10i; c.I.b:(&)c.a; c.I_p.bb:(&)c.b; c.I.c:(&)c.I.b 0; c.I.cc:(&)c.bb[0;0]; c.j.i:0; c.I.d:(&)c.I.b c.i; c.I.dd:(&)c.bb[c.i;c.i];
  all(C.toK c.a=(*)c.c;C.toK c.a=(*)c.cc;C.toK c.a=(*)c.d;C.toK c.a=(*)c.dd)};

.b2c.defStruct[`c.stest;`a`b!`c.j`c.j;`a`b!`c.j`c.j;`a`b!`c.j`c.j];
.b2c.defStruct[`c.stest2;`c`d!`c.j`c.stest;`c`d!`c.j`c.stest;`c`d!`c.j`c.stest];
.b2c.defStruct[`c.stest3;`a`b!`c.j`c.i;`a`b!`c.j`c.i;`a`b!`c.j`c.i];
.t.cstructs:{
  a:3=C.toK {"c)`c.j`c.stest_p"; x[`a]+x`b} (&)`c.stest$`a`b!1 2;
  a:a&3=C.toK {"c)`c.j`c.stest"; x[`a]+x`b} `c.stest$`a`b!1 2;
  .b2c.K2stest_cast[(&)c.stest.v;`a`b!1 2];
  a:a&C.toK 2=c.v`b;
  a:a&(`a`b!1 2)~C.toK c.v;
  a:a&(`a`b!1 2)~C.toK (&)c.v;
  a:a&5=C.toK {"c)`c.j`c.stest2"; x[`d;`a]+x[`d;`b]}`c.stest2$`c`d!(1;`a`b!2 3);
  c.stest2.v2:`c.stest2$`c`d!(1;`a`b!2 3);
  a:a&(`c`d!(1;`a`b!2 3))~C.toK c.stest2.v2;
  a:a&(`a`b!(2;1i))~C.toK `c.stest3$`b`a!(1i;2);
  :a;
 };

.t.vfn:{{"c)`c.void`c.void";}[];{"c)`c.void`c.j";}[1];1b};

.b2c.defType[`c.atst;(`a;10;`c.j)];
.t.aptr:{c.J.a:(&)c.atst.b; C.toK (`c.void_p$(&)c.b 0)=`c.void_p$c.a};

.tt.run:{
  if[not lib[x][]; '"test failed"];
  do[10; lib[x][]];
  w:.Q.w[];
  do[500; lib[x][]];
  if[1<(m:.Q.w[][`used]-w`used)%500; '"suspected memleak ",string m];
  : 1b;
 };

-1"Func tests";
-1"Compiling funcs";
lpath:.b2c.compile[fns:` sv/:``t,/:1_key .t;`libname`rec`goal`globals`weakglobals`initNow`initOnLoad`k!(`test;1b;`compile;`.tt.global1`.tt.global2`.tt.global3;`.tt.wglobal1`.tt.wglobal2`.tt.wglobal3;`.tt.global1`.tt.wglobal1;`.tt.global2`.tt.wglobal2;"..")];

{
  .tt.global1:.tt.global2:.tt.global3:.tt.wglobal1:.tt.wglobal2:.tt.wglobal3:100;
  ini:lpath 2:(`test__init;1);
  lib::ini[];
  .tt.global1:.tt.global2:.tt.global3:.tt.wglobal1:.tt.wglobal2:.tt.wglobal3:200;
  delete global1, wglobal1 from `.tt;
  {$[not@[.tt.run;x;0b]; -1"\nERROR: ",string x;1"."]}each distinct `.t.globs2,fns;
  -1" ";
 }[]

exit 0;
