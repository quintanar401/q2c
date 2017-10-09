/ Define an external fn.
.b2c.defExtFn0:{[qn;cn;ty;gf] `.b2c.defF2T upsert (qn;();ty;0b;$[(::)~gf;$[0=count cn;2_ string qn;cn];gf])};

/ C library
/ functions that can access globals
.b2c.kvalue:{if[-11=type x;if[not null f:.b2c.libFuncs x;:f]; if[not null f:.b2c.libGlobs x; :C.toK first`c.K$(`c.unsafe_k$f)`j]]; C.dot[value;C.knk x]};
.b2c.kwget:{if[-11=type x; if[not null f:.b2c.libGlobs x; r:C.toK first c.K.v:`c.K$(`c.unsafe_k$f)`j; if[y&x in .b2c.wglobals; C.r0 c.v 0; c.v[0]:C.r1`c.k$()]; :r]]; x}; / weak global get
.b2c.kapp1:{ C.dot[y;C.knk $[-11=type x;$[null g:.b2c.libGlobs x;x;C.toK first`c.K$(`c.unsafe_k$g)`j];x]]};
.b2c.kcols:{.b2c.kapp1[x;cols]};
.b2c.kupsert:{if[-11=type x; if[not null g:.b2c.libGlobs x; c.K.v:`c.K$(`c.unsafe_k$g)`j; C.kamend4[`c.k$(.);$[x in .b2c.wglobals;`c.i$0;`c.i$1];c.v;();,;y]; :x]]; C.dot[upsert;C.knk[x;y]]};
.b2c.kmeta:{.b2c.kapp1[x;meta]};
.b2c.kkey:{.b2c.kapp1[x;key]};
.b2c.kkeys:{.b2c.kapp1[x;keys]};
.b2c.kset:{if[-11=type x; if[not null g:.b2c.libGlobs x; c.K.v:`c.K$(`c.unsafe_k$g)`j; C.r0 c.v 0; c.v[0]:C.r1 `c.k$y; :x]]; C.dot[set;C.knk[x;y]]};
.b2c.kxsc:{g:0N; t:$[-11=type z;$[null g:.b2c.libGlobs z;z;C.toK first c.K.v:`c.K$(`c.unsafe_k$g)`j];z]; r:C.dot[x;C.knk[y;t]]; if[not null g; C.r0 c.v 0; c.v[0]:C.r1 `c.k$r; :z]; r};
.b2c.kxasc:{.b2c.kxsc[xasc;x;y]};
.b2c.kxdesc:{.b2c.kxsc[xdesc;x;y]};
.b2c.kapp3:{[f;a;b;c] if[-11=type a; if[not null g:.b2c.libGlobs a; c.K.v:`c.K$(`c.unsafe_k$g)`j; C.kamend3[`c.k$f;$[a in .b2c.wglobals;`c.i$0;`c.i$1];c.v;b;c]; :a]]; C.dot[f;C.knk[a;b;c]]};
.b2c.kapp4:{[f;a;b;c;d] if[-11=type a; if[not null g:.b2c.libGlobs a; c.K.v:`c.K$(`c.unsafe_k$g)`j; C.kamend4[`c.k$f;$[a in .b2c.wglobals;`c.i$0;`c.i$1];c.v;b;c;d]; :a]]; C.dot[f;C.knk[a;b;c;d]]};
if[.b2c.is32; {x set value ssr[string get x;"`j";"`i"]}each `.b2c.kvalue`.b2c.kwget`.b2c.kapp1`.b2c.kupsert`.b2c.kset`.b2c.kxsc`.b2c.kapp3`.b2c.kapp4];

.b2c.K2i_cast:{"c)`K`c.I`K"; if[0i>(`c.k$y)`t; if[4i=.b2c.intmap neg `c.i$(`c.k$y)`t; x[0]:(`c.unsafe_k$y)`i; :()]]; '"K2i_cast: type"};
.b2c.K2j_cast:{"c)`K`c.J`K"; if[0i>(`c.k$y)`t; if[8i=.b2c.intmap neg `c.i$(`c.k$y)`t; x[0]:(`c.unsafe_k$y)`j; :()]]; '"K2j_cast: type"};
.b2c.K2f_cast:{"c)`K`c.F`K"; if[-9i=(`c.k$y)`t; x[0]:(`c.unsafe_k$y)`f; :()]; '"K2f_cast: type"};
.b2c.K2h_cast:{"c)`K`c.H`K"; if[-5i=(`c.k$y)`t; x[0]:(`c.unsafe_k$y)`h; :()]; '"K2h_cast: type"};
/ .b2c.K2u_cast:{"c)`K`c.U`K"; if[-2i=(`c.k$y)`t; x[0]:`c.U$(`c.unsafe_k$y)`G0; :()]; '"K2u_cast: type"};
.b2c.K2K_cast:{"c)`K`c.K_p`K"; if[0i<>(`c.k$y)`t;'"K2K_cast: type"]; if[0i=(`c.k$y)`r; '"K2K_cast: no ref"]; x[0]:`c.K$(`c.unsafe_k$y)`G0;};
.b2c.K2I_cast:{"c)`K`c.I_p`K"; c.k.y:(`c.k$y); if[(20>c.y`t)&0i<c.y`t; if[4i=.b2c.intmap `c.i$c.y`t; if[0i=c.y`r; '"K2I_cast: no ref"]; x[0]:`c.I$(`c.unsafe_k$y)`G0; :()]]; '"K2I_cast: type"};
.b2c.K2J_cast:{"c)`K`c.J_p`K"; c.k.y:(`c.k$y); if[(20>c.y`t)&0i<c.y`t; if[8i=.b2c.intmap `c.i$c.y`t; if[0i=c.y`r; '"K2J_cast: no ref"]; x[0]:`c.J$(`c.unsafe_k$y)`G0; :()]]; '"K2J_cast: type"};
.b2c.K2F_cast:{"c)`K`c.F_p`K"; if[9i=(`c.k$y)`t; if[0i=(`c.k$y)`r; '"K2F_cast: no ref"]; x[0]:`c.F$(`c.unsafe_k$y)`G0; :()]; '"K2F_cast: type"};
.b2c.K2H_cast:{"c)`K`c.H_p`K"; if[5i=(`c.k$y)`t; if[0i=(`c.k$y)`r; '"K2H_cast: no ref"]; x[0]:`c.H$(`c.unsafe_k$y)`G0; :()]; '"K2H_cast: type"};
.b2c.K2S_cast:{"c)`K`c.S_p`K"; if[(-11i=(`c.k$y)`t)|10i=(`c.k$y)`t; if[0i=(`c.k$y)`r; '"K2S_cast: no ref"]; if[-11i=(`c.k$y)`t; x[0]:(`c.unsafe_k$y)`s; :()];
  if[any 0=y; x[0]:`c.S$(`c.unsafe_k$y)`G0;:()]; '"K2S_cast: no null terminator"]; '"K2S_cast: type"};
.b2c.K2C_cast:{"c)`K`c.C_p`K"; if[(4=(`c.k$y)`t)|10=(`c.k$y)`t; if[0i=(`c.k$y)`r; '"K2C_cast: no ref"]; x[0]:`c.C$(`c.unsafe_k$y)`G0; :()]; '"K2C_cast: type"};
.b2c.k2K_cast:{"c)`K`c.K_p`c.k"; if[0i<>y`t;'"k2K_cast: type"]; if[0i=y`r; '"k2K_cast: no ref"]; x[0]:`c.K$(`c.unsafe_k$y)`G0;};

/ K types
`.q2b.types upsert ((`c.k;(),"K";(`p;(`s;"k0";`n`t`r!`c.j`c.schar`c.i;1b));1b);(`c.K;"K*";`p`c.k;1b);(`c.K_p;"K**";`p`c.K;1b);(`c.unsafe_k;(),"K";(`p;(`s;`k0;`n`t`i`j`f`h`s`r`G0!`c.j`c.schar`c.i`c.j`c.f`c.h`c.S`c.i`c.G;1b));1b);
  (`c.u;(),"U";(`s;`U;enlist[`g]!enlist(`a;16;`c.g);1b);1b);(`c.U;"U*";`p`c.u;1b));
.b2c.defExtType:{[t;def] cn:$[t like "c.*";2_string t;'"ctype is not c.*"]; `.q2b.types upsert ((t;cn;def;1b);(`$string[t],"_p";cn,"*";(`p;t);1b)); .b2c.defPCast t; if[0=count def; .q2b.baseTypes,:t]};
.b2c.defStruct0:{[isEx;isSt;n;d;to;fr] ns:string n; $[n like "c.*";[sn:n;cn:2_ns];[if[not isEx;'"internal structs must look like c.name"]; sn:`$"c.s_",ns;cn:$[isSt;"struct ";"union "],ns]];
  .q2b.chkTy each d; `.q2b.types upsert ((sn;$[isEx;cn;()];(`s;cn;d;isSt);isEx);(p:`$string[sn],"_p";$[isEx;cn,"*";()];`p,sn;isEx)); .b2c.defPCast sn; ex:"\"`",string[sn],"$: type\"";
  k:{"k:`$(",(";"sv "(),\"",/:string[key x],\:"\""),"); "}; tf:{" "sv($[x;::;{(x,'y),\:"]"}"if[k[",/:string[t],\:"]in kk; "]{s:`s=first .q2b.unwindT l:last y;c:.b2c.mkCast/["v ",string z;(neg s)_(),y];v:"x[(),\"",x,"\"]";$[s;".b2c.K2",(2_string l),"_cast[(&)",v,";",c,"]";v,":",c]}'[string key y;value y;t:til count y]),\:";"}[isSt]; cto:`$".b2c.K2",(2_string sn),"_cast";
  if[count to; f:string[cto],":{\"c)`K`",string[p],"`K\"; ",k[to]," if[99<>type y;'",ex,"]; kk:C.dot[key;enlist y]; ",$[isSt;"if[not all k in kk;'",ex,"];";""]," v:y k; ",tf[to],"}"; value f; .b2c.intfns,:cto; `.q2b.castMap upsert(`K;sn;0b;::;cto)];
  cfr:`$".b2c.toK",2_string sn; ff:{";"sv{.b2c.mkCast/["x[(),\"",x,"\"]";y]}'[string key x;value x]}; fr:{$[last[x]like"C.toK*";x;x,`C.toK]}each fr;
  if[count fr; f:string[cfr],":{\"c)`K`",string[p],"\"; ",k[fr]," k!(",ff[fr],")}"; value f; .b2c.intfns,:cfr; .b2c.defExtFn0[`C.toK;n:.b2c.mkng cfr;`f`K,p;::];
    .b2c.defExtFn0[`C.toK;"";`f`K,sn;{[f;cc;i;n;a] f,"(&",a[0],")"}[n]]; .b2c.if2sym[p,sn]:cfr];
 };
.b2c.defStruct:{[n;d;to;fr].b2c.defStruct0[0b;1b;n;d;to;fr]};
.b2c.defExtStruct:{[n;d;to;fr].b2c.defStruct0[1b;1b;n;d;to;fr]};
.b2c.defUnion:{[n;d;to;fr].b2c.defStruct0[0b;0b;n;d;to;fr]};
.b2c.defExtUnion:{[n;d;to;fr].b2c.defStruct0[1b;0b;n;d;to;fr]};
.b2c.defType:{[t;def] if[not t like "c.*";'"ctype is not c.*"]; if[0=count def;'"no type def"]; `.q2b.types upsert ((t;();.q2b.crtType def;0b);(`$string[t],"_p";();(`p;t);0b)); .b2c.defPCast t};

/ casts
.b2c.defCCast:{[x] if[not 2=count x;'"length"]; if[not 11=type x;'"type"]; .q2b.chkTy each x; if[any .q2b.pureK each x;'"K cast"]; `.q2b.castMap upsert (x 0;x 1;1b;::;::)};
.b2c.defPCast:{[x] if[not -11=type x;'"type"]; .q2b.chkTy x; if[.q2b.pureK x;'"K cast"]; if[not (p:`$string[x],"_p")in .q2b.types`name; `.q2b.types upsert (p;();(`p;x);0b)];
  `.q2b.castMap upsert ((.b2c.it;p;1b;::;::);(p;.b2c.it;1b;::;::);(`c.ij;p;1b;::;::);(p;`c.ij;1b;::;::);(`c.void_p;p;1b;::;::);(p;`c.void_p;1b;::;::);(x;p;1b;::;{"&",y});(p;x;1b;::;{"(*",y,")"}))};
.b2c.defCompCast:{[x] n:{$[null j:exec first i from .q2b.castMap where tf=y, tt=x;'"No cast from ",string[y]," to ",string x;j]}':[x 0;1_x]; `.q2b.castMap upsert (x 0;last x;1b;::;n)};
.b2c.cnstF:{[t;w;pre;ps;x] $[null x;"n",t;w=x;"w",t;x=neg w;"-w",t;pre,string[x],ps]};
.q2b.cnstCast:`c.j`c.i`c.f!(.b2c.cnstF["j";0wj;"";"LL"];.b2c.cnstF["i";0wi;"";""];.b2c.cnstF["f";0wf;"(double)";""]);
`.q2b.castMap upsert ((`Kj;`c.j;1b;.q2b.cnstCast`c.j;::);(`Kj;`c.i;1b;.b2c.cnstF["i";0wj;"";""];::);(`Ki;`c.i;1b;.q2b.cnstCast`c.i;::);(`Ki;`c.j;1b;.b2c.cnstF["j";0wi;"";"LL"];::);
  (`Kj;`c.f;1b;.b2c.cnstF["f";0wf;"(double)";""];::);(`Kf;`c.f;1b;.q2b.cnstCast`c.f;::);(`KC;`c.S;1b;{"\"",ssr/[x;("\\";"\n";"\r");("\\\\";"\\n";"\\r")],"\""};::);
  (`c.j;`c.J;1b;::;{"&",y});(`c.i;`c.I;1b;::;{"&",y});
  / K/c.k
  (`K;`c.j;0b;::;`.b2c.K2j_cast);(`K;`c.i;0b;::;`.b2c.K2i_cast);(`K;`c.f;0b;::;`.b2c.K2f_cast);(`K;`c.K;0b;::;`.b2c.K2K_cast);(`K;`c.I;0b;::;`.b2c.K2I_cast);(`K;`c.J;0b;::;`.b2c.K2J_cast);(`K;`c.F;0b;::;`.b2c.K2F_cast);
  (`K;`c.S;0b;::;`.b2c.K2S_cast);(`K;`c.C;0b;::;`.b2c.K2C_cast);(`K;`c.H;0b;::;`.b2c.K2H_cast);(`K;`c.string;0b;::;`.b2c.K2S_cast);(`K;`c.h;0b;::;`.b2c.K2h_cast);(`c.k;`c.K;0b;::;`.b2c.k2K_cast);
  (`K;`c.k;1b;::;::);(`K;`c.unsafe_k;1b;::;::);(`c.k;`c.unsafe_k;1b;::;{y});(`c.k;`c.void_p;1b;::;::);(`c.G;`c.K;1b;::;::));
/ ctype vs ctype
.b2c.defExtType[;()]each `c.mode_t`c.size_t`c.pid_t`c.off_t`c.ssize_t`c.uid_t`c.gid_t;
.b2c.defExtType[`c.string;`c.S];
.b2c.defType[`c.ij;.b2c.it];
.b2c.defCCast each (`c.schar`c.i;`c.G`c.F;`c.G`c.J;`c.G`c.I;`c.G`c.H;`c.G`c.S;`c.G`c.C;`c.G`c.void_p;`c.H`c.ushort_p;`c.C`c.void_p;`c.void_p`c.C;`c.void_p`c.I;`c.I`c.void_p;`c.void_p`c.J;`c.J`c.void_p;`c.cvoid_p`c.void_p);
.b2c.defPCast each`c.void`c.void_p`c.I`c.J`c.H`c.G`c.F`c.K`c.S`c.C`c.ushort; / casts long vs a pointer
.b2c.defCCast each {(.b2c.it,/:x),x,\:.b2c.it}`c.I`c.J`c.H`c.G`c.F`c.K`c.S`c.C`c.off_t`c.size_t`c.ssize_t; / casts long vs type
.b2c.defCCast each {(`c.j,/:x),x,\:`c.j}`c.char`c.bool`c.ij;
.b2c.defCCast each {(`c.ij,/:x),x,\:`c.ij}`c.I`c.J`c.H`c.G`c.F`c.K`c.S`c.C`c.off_t`c.size_t`c.ssize_t;
.b2c.defCCast each {(`c.i,/:x),x,\:`c.i}`c.mode_t`c.pid_t`c.j`c.uint`c.char`c.ushort`c.short`c.long`c.uid_t`c.gid_t`c.bool`c.ij; / int vs type
.b2c.defCompCast each (`K`c.i`c.uint;`K`c.i`c.mode_t;`K,.b2c.it,`c.size_t;`K`c.i`c.pid_t;`K`c.i`c.long;`K,.b2c.it,`c.off_t;`K,.b2c.it,`c.ssize_t;`K`c.i`c.uid_t;`K`c.i`c.gid_t;`K,.b2c.it,`c.ij); / shortcuts

/ default functions
.b2c.defF2T:0#.q2b.f2t;
.b2c.opFn:{[f;cc;i;n;a] a[0],f,a 1};
.b2c.opFnA:{[f;cc;i;n;a] n,f,a};
.b2c.kFn:{[f;na;cc;i;n;a] aa:","sv a; $[na=count a;f,"__q(",aa,")";"kdot(r1(",f,"__k),knk(",string[count a],",",aa,"))"]}; / manually generate K call
.b2c.kApp:{[f;cc;i;n;a] aa:","sv a; an:string count a; f:"r1(__consts[",f,"])"; $[(count a)in 3 4;"__kapp",an,"__q(",f,",",aa,")";"kdot(",f,",knk(",an,",",aa,"))"]}; / manually generate K app call
`.b2c.defF2T upsert raze{f:.b2c.opFnA z,"=";f2:.b2c.opFn z;((x;y;`f`c.j`c.j`c.j;0b;f2);(x;y;`f`c.i`c.i`c.i;0b;f2);(x;y;`f`c.f`c.f`c.f;0b;f2);(x;y;`f`c.f`c.f`c.i;0b;f2);(x;y;`f`c.f`c.f`c.j;0b;f2);
  (x;y;`f`c.f`c.i`c.f;0b;f2);(x;y;`f`c.f`c.j`c.f;0b;f2);(x;y;`f`c.j`c.j`c.i;0b;f2);(x;y;`f`c.j`c.i`c.j;0b;f2);(x;y;`f`c.i`c.i`c.i;1b;f);(x;y;`f`c.j`c.j`c.j;1b;f);(x;y;`f`c.i`c.i`c.i;1b;f);(x;y;`f`c.f`c.f`c.f;1b;f);(x;y;`f`c.j`c.j`c.i;1b;f);
  (x;y;`f`c.f`c.f`c.i;1b;f);(x;y;`f`c.f`c.f`c.j;1b;f);(x;y;`K;0b;::);(x;y;`K;1b;::))}'[`..plus`..minus`..mult;(+;-;*);("+";"-";"*")];
`.b2c.defF2T upsert {f:.b2c.opFnA z,"=";f2:.b2c.opFn z;f3:.b2c.opFn z,"(double)";((x;y;`f`c.f`c.j`c.j;0b;f3);(x;y;`f`c.f`c.j`c.i;0b;f3);(x;y;`f`c.f`c.i`c.j;0b;f3);(x;y;`f`c.f`c.i`c.i;0b;f3);(x;y;`f`c.f`c.f`c.j;0b;f2);
  (x;y;`f`c.f`c.j`c.f;0b;f2);(x;y;`f`c.f`c.f`c.i;0b;f2);(x;y;`f`c.f`c.i`c.f;0b;f2);(x;y;`f`c.f`c.f`c.f;0b;f2);(x;y;`f`c.f`c.f`c.j;1b;f);(x;y;`f`c.f`c.f`c.i;1b;f);(x;y;`f`c.f`c.f`c.f;1b;f);(x;y;`K;0b;::);(x;y;`K;1b;::))}[`..div;%;"/"];
`.b2c.defF2T upsert {(`C.neg;neg;x;0b;{[cc;i;n;a] " -",a 0})}each (`f`c.j`c.j;`f`c.i`c.i;`f`c.f`c.f);
`.b2c.defF2T upsert {(`..bnot;not;`f,(x;x);0b;{[cc;i;n;a]"~(",a[0],")"})}each `c.i`c.j`c.long`c.uint;
`.b2c.defF2T upsert ((`C.neg;neg;`K;0b;::);(`C.not;not;`f`c.bool`c.bool;0b;{[cc;i;n;a]"!(",a[0],")"});(`C.not;not;`K;0b;::));
`.b2c.defF2T upsert {(`C.abs;abs;`f,x,x;0b;y)}'[`c.j`c.i`c.f;("llabs";"abs";"fabs")],((`C.abs;abs;`f`c.i`c.schar;0b;{[cc;i;n;a]"abs((int)",a[0],")"});(`C.abs;abs;`K;0b;::));
`.b2c.defF2T upsert (`C.isnan;();`f`c.bool`c.f;0b;::);
`.b2c.defF2T upsert raze {f:.b2c.opFn(`..eq`..gt`..lt`..gte`..lte`..ne!("==";">";"<";">=";"<=";"!="))x;: (distinct raze{[x;y;f;z]((x;y;`f`c.bool,z;0b;f);(x;y;`f`c.bool,reverse z;0b;f))}[x;y;f]each
  (`c.j`c.j;`c.i`c.j;`c.i`c.i;`c.schar`c.schar;`c.i`c.schar;`c.j`c.schar;`c.f`c.f;`c.f`c.i;`c.f`c.j;`c.long`c.long;`c.long`c.i;`c.long`c.j;`c.void_p`c.void_p;`c.j`c.k)),enlist[(x;y;`K;0b;::)];
  }'[`..eq`..gt`..lt`..gte`..lte`..ne;(=;>;<;>=;<=;<>)];
`.b2c.defF2T upsert raze{((`..and;&;`f,(x;x;x);0b;.b2c.opFn"&");(`..or;|;`f,(x;x;x);0b;.b2c.opFn"|");(`..xor;^;`f,(x;x;x);0b;.b2c.opFn"^"))}each `c.i`c.j`c.long`c.uint`c.bool;
`.b2c.defF2T upsert ((`..and;&;`K;0b;::);(`..or;|;`K;0b;::);(`..xor;^;`K;0b;::));
`.b2c.defF2T upsert ((`..value;value;`K;0b;.b2c.kFn["__kvalue";1]);(`..cols;cols;`K;0b;.b2c.kFn["__kcols";1]);(`..upsert;upsert;`K;0b;.b2c.kFn["__kupsert";2]);(`..meta;meta;`K;0b;.b2c.kFn["__kmeta";1]);
  (`..set;set;`K;0b;.b2c.kFn["__kset";2]);(`..xasc;xasc;`K;0b;.b2c.kFn["__kxasc";2]);(`..xdesc;xdesc;`K;0b;.b2c.kFn["__kxdesc";2]);(`..app;@;`K;0b;.b2c.kApp"57");(`..app;.;`K;0b;.b2c.kApp"58");
  (`..keys;keys;`K;0b;.b2c.kFn["__kkeys";1]);(`..key;key;`K;0b;.b2c.kFn["__kkey";1]));
/ c -> K casts
.b2c.defExtFn0[`C.toK;"";;{[cc;i;n;a] "r1(",a[0],")"}]each (`f`K`c.unsafe_k;`f`K`c.k);
.b2c.defExtFn0[`C.toK;;;::]'[("kj";"ki";"kf";"kh");(`f`K`c.j;`f`K`c.i;`f`K`c.f;`f`K`c.i)];
`.b2c.defF2T upsert {(`$"C.toK",x;();`f`K,y;0b;{[f;cc;i;n;a]f,a[0],")"}z)}'["bxhijefcptdnz";`c.i`c.i`c.i`c.i`c.j`c.f`c.f`c.i`c.j`c.i`c.i`c.j`c.f;("kb(";"kg(";"kh(";"ki(";"kj(";"ke(";"kf(";"kc(";"ktj(-KP,";"kt(";"kd(";"ktj(-KN,";"kz(")];
.b2c.defExtFn0[`C.toK;"__toKS";`f`K`c.S;::]; .b2c.defExtFn0[`C.toK;"__toKI";`f`K`c.I`c.j;::]; .b2c.defExtFn0[`C.toK;"__toKJ";`f`K`c.J`c.j;::];
.b2c.defExtFn0[`C.toK;"__toKF";`f`K`c.F`c.j;::]; .b2c.defExtFn0[`C.toK;"__toKH";`f`K`c.H`c.j;::]; .b2c.defExtFn0[`C.toK;"__toKC";`f`K`c.C`c.j;::];
.b2c.intfns,:`.b2c.toKS`.b2c.toKI`.b2c.toKJ`.b2c.toKF`.b2c.toKH`.b2c.toKC;
.b2c.defExtFn0[`C.toK;"";`f`K`c.long;{[cc;i;n;a] "ki((int)",a[0],")"}];
.b2c.defExtFn0[`C.toK;"";`f`K`c.uint;{[cc;i;n;a] "ki((int)",a[0],")"}];
.b2c.defExtFn0[`C.toK;"";`f`K`c.h;{[cc;i;n;a] "kh((int)",a[0],")"}];
.b2c.defExtFn0[`C.toK;"";`f`K`c.bool;{[cc;i;n;a] "kb((int)",a[0],")"}];
.b2c.toKS:{"c)`K`c.S"; c.j.l:0; while[0<>`c.i$x c.l;c.l+:1]; r:(C.toK c.l)#" "; c.S.r:`c.S$(`c.unsafe_k$r)`G0; do[c.l;c.r[c.do1]:x c.do1]; r}; / char* -> K string
.b2c.toKC:{"c)`K`c.C`c.j"; r:C.ktn[10i;y]; c.C.r:`c.C$(`c.unsafe_k$r)`G0; do[y;c.r[c.do1]:x c.do1]; r}; / char buff -> K
.b2c.toKI:{"c)`K`c.I`c.j"; r:C.ktn[6i;y]; c.I.r:`c.I$(`c.unsafe_k$r)`G0; do[y;c.r[c.do1]:x c.do1]; r}; / I* -> K
.b2c.toKJ:{"c)`K`c.J`c.j"; r:C.ktn[7i;y]; c.J.r:`c.J$(`c.unsafe_k$r)`G0; do[y;c.r[c.do1]:x c.do1]; r}; / J* -> K
.b2c.toKF:{"c)`K`c.F`c.j"; r:C.ktn[9i;y]; c.F.r:`c.F$(`c.unsafe_k$r)`G0; do[y;c.r[c.do1]:x c.do1]; r}; / F* -> K
.b2c.toKH:{"c)`K`c.H`c.j"; r:C.ktn[5i;y]; c.H.r:`c.H$(`c.unsafe_k$r)`G0; do[y;c.r[c.do1]:x c.do1]; r}; / H* -> K
/ C level functions
.b2c.defExtFn0[`C.knk2;"";`f`c.k`c.k`..;{[cc;i;n;a] "knk(",string[count a],",",(","sv a),")"}];
.b2c.defExtFn0[`C.knk;"";`f`K`K`..;{[cc;i;n;a] "knk(",string[count a],",",(","sv a),")"}];
.b2c.defExtFn0[`C.dot;"kdot";`f`K`K`K;::];
.b2c.defExtFn0[`C.dotk;"dot";`f`c.k`c.k`c.k;::];
.b2c.defExtFn0[`C.k;"";`f`K`c.i`c.S`K`..;{[cc;i;n;a] "k(",(","sv a),",(K)0)"}];
.b2c.defExtFn0[`C.unsafe_kj;"kj";`f`c.k`c.j;::];
.b2c.defType[`c.sd1_fn;`f`K`c.i];
(.b2c.defExtFn0[;"";;::]'). flip((`C.ku;`f`K`c.u);(`C.ktn;`f`K`c.i`c.j);(`C.kpn;`f`K`c.S`c.j);(`C.setm;`f`c.i`c.i);(`C.khpun;`f`c.i`c.S`c.i`c.S`c.i);(`C.khpu;`f`c.i`c.S`c.i`c.S);(`C.khp;`f`c.i`c.S`c.i);
  (`C.okx;`f`c.i`K);(`C.ymd;`f`c.i`c.i`c.i`c.i);(`C.dj;`f`c.i`c.i);(`C.sd0;`f`c.void`c.i);(`C.sd0x;`f`c.void`c.i`c.i);(`C.kclose;`f`c.void`c.i);(`C.sn;`f`c.S`c.S`c.i);(`C.ss;`f`c.S`c.S);
  (`C.ktj;`f`K`c.i`c.j);(`C.ka;`f`K`c.i);(`C.kb;`f`K`c.i);(`C.kg;`f`K`c.i);(`C.kh;`f`K`c.i);(`C.ki;`f`K`c.i);(`C.kj;`f`K`c.j);(`C.ke;`f`K`c.f);(`C.kf;`f`K`c.f);(`C.kc;`f`K`c.i);(`C.ks;`f`K`c.S);(`C.kd;`f`K`c.i);
  (`C.kz;`f`K`c.f);(`C.kt;`f`K`c.i);(`C.sd1;`f`K`c.i`c.sd1_fn_p);(`C.dl;`f`K`c.void_p`c.i);(`C.kp;`f`K`c.S);(`C.ja;`f`K`c.K`c.void_p);(`C.js;`f`K`c.K`c.S);(`C.jk;`f`K`c.K`K);(`C.kv;`f`K`c.K`K);
  (`C.xT;`f`K`K);(`C.xD;`f`K`K`K);(`C.ktd;`f`K`K);(`C.krr;`f`K`c.S);(`C.orr;`f`K`c.S);(`C.b9;`f`K`c.i`K);(`C.d9;`f`K`K);(`C.kamend4;`f`K`c.k`c.i`c.K`K`K`K);(`C.kamend3;`f`K`c.k`c.i`c.K`K`K);
  (`C.r1;`f`c.k`c.k);(`C.r0;`f`c.void`c.k)); / these 2 are special because they do not follow the ref count rule

.b2c.defExtCFn:{[nm;cty] if[not 11=type cty; '"defCFn: arg type"]; @[{.q2b.chkTy each x};cty;{'"defCFn: ",x}]; `.b2c.defF2T upsert (nm;();`f,cty;0b;::)};
.b2c.defExtVar:{[nm;cty] if[not -11=type cty; '"defCVar: arg type"]; @[{.q2b.chkTy x};cty;{'"defCVar: ",x}]; `.b2c.defF2T upsert (nm;();cty;0b;::)};
.b2c.overload:{[fn;names] update gf:(count i)#enlist string fn from `.b2c.defF2T where n in names};

/ in param: K->C casts, the last cast must be a valid C type name corresponding to the C fn prototype.
/ out param: C -> K casts, ending with the (implicit) default C.toK function or any other C.toKsomething function. The first cast type must be a C type from the fn prototype (it will be used to declare the fn proto).
/ ops:
/ `in - "`c.t2$`c.t1$xN", all args are `in by default. N - is the arg num starting with 1.
/ `out - "C.toK `c.t$c.var", this is the output arg, it will be passed in as &cvar and then casted to a K value. There may be several `out params.
/ `in_out - like in. The input Q value is returned. It is assumed that this Q value is used as a buffer where C func writes.
/ `retVal - "C.toK `c.t$c.var", this is a retVal. Similar to `out but without the automatic cast to a pointer. Return value is a retVal by default but it loses this status if any `retVal or `out arg exists (you need to mark it explicitly with retVal in this case)
/ `notRV - not a retVal. Can be used to supress the return value.
/ (`const;"str") - "`c.t2$`c.t1$str", some Q/QC expression. Can be used to pass in consts.
/ (`length;N) - "`c.t2$`c.t1$count xN" expression will be used, where xN is some other arg.
/ (`expr;"str") - "`c.t2$`c.t1$str [xN]" expression will be used, xN is the arg name in this position if available.
/ `notarg - to be used with `expr, means the value will be calculated from other args/consts.
/ (`chkLen;N) - "if[N>count xM;'exc]".
/ (`chkLenEq;N) - "if[N<>count xM;'exc]".
/ (`chk0;optCastsToRes) - "if[0=res; 'exc]", compare the result with 0, it can be optionally casted to = friendly type first.
/ (`chk1;optCastsToRes) - "if[-1=res; 'exc]", compare the result with -1, it can be optionally casted to = friendly type first.
/ (`chkNot0;optCastsToRes) - "if[0<>res; 'exc]", compare the result with 0, it can be optionally casted to = friendly type first.
/ (`chkExp;"exp";optCastsToRes) - "if[exp=res; 'exc]", compare the result with some expr, it can be optionally casted to = friendly type first.
/ free - add free attr to a pointer var - out or retVal. It will be automatically freed if it is not NULL.
/ opts: `nogen!1b - do not generate a Q func
.b2c.defExtFn:{[lib;nm;r;a;o] qn:` sv`,lib,`$$[nm like "C.*";2_;::]string nm; a:((),/:enlist[r],a),\:enlist`; if[not all 11=abs type each a0:a[;0]; '"defExtFn: type name not sym"]; o:(()!()),o;
  at:{$[any i:(v:`out`in_out`retVal`const`length`expr)in\:first each x;v where[i]0;`]}each a1:(),/:a[;1]; rn:$[count rn:where at in `out`retVal`in_out;rn;(),0]; / arg category/return args
  cty:{if[not any x like "c.*";'"defExtFn: ctype is not c.*"];x}@[last each a0;i;:;first each a0 i:0,rn where not`in_out=at rn]; .b2c.defExtCFn[nm;@[cty;where`out=at;{x^.b2c.typeAlias x:`$string[x],"_p"}]];
  if[`nogen in key o; :`]; if[.q2b.matchT[cty 0;`c.void];rn:rn except 0]; / C function
  qv:string @[`$"x",/:string til count a;0,where({any `notarg~/:x}each a1)|not at in ``expr`in_out;:;`]; snm:string nm; tbl:flip`a0`a1`at`cty`n`i!(a0;a1;at;cty;qv;til count a);
  qfn:string[qn],":{[",(";"sv string(`$qv) except `),"] ",(" "sv .b2c.defFnPre[snm]each tbl); qfn,:.b2c.defFnBody[snm;tbl 0],("; "sv .b2c.defFnBody[snm]each 1_tbl),"]; "; qfn,:" "sv .b2c.defFnPost[snm]each tbl;
  qfn,:$[0=count rn;"";1=count rn;.b2c.defFnRes tbl rn 0;"(",("; "sv .b2c.defFnRes each tbl rn),")"]," }";
  @[value;qfn;{'"defExtFn: failed to create Q fn with ",x}];
  : qn;
 };
.b2c.typeAlias:`c.i_p`c.j_p`c.f_p`c.g_p`c.h_p`c.c_p!`c.I`c.J`c.F`c.G`c.H`c.C;
.b2c.mkCast:{$[y=`getptr;"(&)",x;y=`unptr;"(*)",x;y in .q2b.castMap`tt;"`",string[y],"$",x;y in .b2c.defF2T`n;string[y]," ",x;'"defExtFn: unknown cast ",string y]};
.b2c.defFnPre:{[f;t] r:""; a1:first each t`a1; if[(`free in a1)&0=count t`n;r,:"\"attr)enlist[`",$[t`i;"c.c",string[t`i];"c.res"],"]!enlist `free\";"];
  if[(0<t`i)&any j:a1 in`chkLen`chkLenEq;r:"if[",string[last d],$[`chkLen=first d:t[`a1]where[j] 0;">";"<>"],"count ",t[`n],"; '\"",f,": length\"]; "]; r};
.b2c.defFnBody:{[f;t] isV:.q2b.matchT[t`cty;`c.void]; if[0=t`i;:$[isV;"";string[` sv t[`cty],`res],":"],f,"["]; if[isV;:"::"]; a1:t[`a1]first where t[`at]=first each t`a1; e:$[`const=c:t`at;a1 1;c in`out`retVal;
  : $[c=`out;"(&)";""],string[t`cty],".c",string t`i;`in_out=`c;string[t`n];`length=c;"`c.ij$`c.j$count x",string a1 1;`expr=c;a1[1],$[count t`n;" ",t`n;""];t`n]; .b2c.mkCast/[e;t`a0]};
.b2c.defFnPost:{[f;t] fo:first each t`a1; r:""; if[0=t`i; if[any i:any `chk0`chk1`chkExp`chkNot0=\:fo; c:t[`a1]first where i; e:$[(2+`chkExp=first c)<=count c;.b2c.mkCast/["";c 1+`chkExp=c 0];""],"c.res";
  r,:"if[",$[`chk1=c0:first c;"-1=";`chk0=c0;"0=";`chkNot0=c0;"0<>";"(",c[1],")="],e,";'\"",f,": \",.string.strerror[C.toK C.errno]]; "]; :r]; r};
.b2c.defFnRes:{[t] if[any`notRV~/:t`a1;:"(::)"]; if[`in_out=t`at;:t`n]; tk:1_$[last[t`a0]like"C.toK*";t`a0;t[`a0],`C.toK]; .b2c.mkCast/[$[0=t`i;"c.res";"c.c",string t`i];tk]};

.b2c.defExtConstFn:{r:".",string[x],".getConsts:{c:enlist[`]!enlist(::);"," "sv{("c:c,{(`$(",(";"sv"\"",/:x[;0],\:"\""),"))!("),(";"sv x[;1]),")}[]; "}each
  (0N 30)#{c:$[-11=type x;"C.toK ";.b2c.mkCast/["";$[last[x 1]like"toK*";x 1;x[1],`C.toK]]]; ($[s like"C.*";2_s;s]; c,s:string x)}each y; value r,"; c}"};

{.b2c.defExtStruct[`c.div_t;x;x;x]}`quot`rem!`c.i`c.i;
{.b2c.defExtStruct[`c.lldiv_t;x;x;x]}`quot`rem!`c.j`c.j;

.b2c.defExtVar[`C.NULL;`c.void_p];
.b2c.defExtVar[`C.errno;`c.i];

/ stdlib
.b2c.defExtFn[`std;`C.abort;`c.void;`c.void;()]; / void abort(void);
.b2c.defExtFn[`std;`C.calloc;`c.void_p;`c.size_t`c.size_t;enlist[`nogen]!(),1b]; / void *calloc(size_t nelem, size_t elsize);
.b2c.defExtFn[`std;`C.div;`c.div_t_p`free;`c.i`c.i;()]; / div_t div(int numer, int denom);
.b2c.defExtFn[`std;`C.drand48;`c.f;`c.void;()]; / double drand48(void)
.b2c.defExtFn[`std;`C.erand48;`c.f;enlist(`c.H`c.ushort_p;enlist(`chkLenEq;3));()]; / double erand48(unsigned short xsubi[3]);
.b2c.defExtFn[`std;`C.jrand48;`c.long;enlist(`c.H`c.ushort_p;enlist(`chkLenEq;3));()]; / long jrand48(unsigned short xsubi[3]);
.b2c.defExtFn[`std;`C.lcong48;`c.void;enlist(`c.H`c.ushort_p;enlist(`chkLenEq;7));()]; / void lcong48(unsigned short param[7]);
.b2c.defExtFn[`std;`C.lrand48;`c.long;`c.void;()]; / long lrand48(void);
.b2c.defExtFn[`std;`C.mrand48;`c.long;`c.void;()]; / long mrand48(void);
.b2c.defExtFn[`std;`C.nrand48;`c.long;enlist(`c.H`c.ushort_p;enlist(`chkLenEq;3));()]; / long nrand48(unsigned short xsubi[3]);
.b2c.defExtFn[`std;`C.seed48;enlist`c.ushort_p,.b2c.it;enlist(`c.H`c.ushort_p;enlist(`chkLenEq;3));()]; / unsigned short *seed48(unsigned short seed16v[3])
.b2c.defExtFn[`std;`C.srand48;`c.void;`c.long;()]; / void srand48(long seedval);
.b2c.defExtFn[`std;`C.free;`c.void;`c.void_p;enlist[`nogen]!(),1b]; / void free(void *ptr);
.b2c.defExtFn[`std;`C.initstate;(`c.S;((`chk0;.b2c.it);`notRV));(`c.uint;`c.S;(`c.size_t;enlist(`length;2)));()]; / char *initstate(unsigned seed, char *state, size_t size);
.b2c.defExtFn[`std;`C.random;`c.long;`c.void;()]; / long random(void);
.b2c.defExtFn[`std;`C.setstate;(`c.S;((`chk0;.b2c.it);`notRV));`c.S;()]; / char *setstate(char *state);
.b2c.defExtFn[`std;`C.srandom;`c.void;`c.uint;()]; / void srandom(unsigned seed);
.b2c.defExtFn[`std;`C.lldiv;`c.lldiv_t_p`free;`c.j`c.j;()]; / lldiv_t lldiv(long long numer, long long denom);
.b2c.defExtFn[`std;`C.malloc;`c.void_p;`c.size_t;enlist[`nogen]!(),1b]; / void *malloc(size_t size);
.std.kmalloc:{"c)`K`c.void_p_p`c.size_t"; c.void_p.res:C.malloc y; if[0=`c.ij$c.res;'"C.malloc"]; x[0]:c.res; }; / K exc safe malloc
.b2c.defExtFn[`std;`C.mkdtemp;(`c.S;((`chk0;.b2c.it);`notRV));`c.S;()]; / char *mkdtemp(char *template);
.b2c.defExtFn[`std;`C.mkstemp;`c.i`chk1;`c.S;()]; / int mkstemp(char *template);
.b2c.defExtFn[`std;`C.putenv;`c.i`chkNot0;`c.S;()]; / int putenv(char *string);
.b2c.defType[`c.cmp_func;`f`c.i`c.cvoid_p`c.cvoid_p];
.b2c.defExtFn[`std;`C.qsort;`c.void;`c.void_p`c.size_t`c.size_t`c.cmp_func_p;enlist[`nogen]!(),1b]; / void qsort(void *base, size_t nel, size_t width,  int (*compar)(const void *, const void *))
.b2c.defExtFn[`std;`C.realloc;`c.void_p;`c.void_p`c.size_t;enlist[`nogen]!(),1b]; / void *realloc(void *ptr, size_t size);
.b2c.defExtFn[`std;`C.realpath;`c.S;`c.S`c.C;enlist[`nogen]!(),1b]; / char *realpath(const char *restrict file_name, char *restrict resolved_name);
.std.realpath:{[x1;x2]  if[(C.toK C.PATH_MAX)>=count x2; '"C.realpath: length"]; c.S.res:C.realpath[`c.S$x1;`c.C$x2]; if[0=`c.ij$c.res;'"C.realpath: ",.string.strerror[C.toK C.errno]];};
.b2c.defExtFn[`std;`C.setkey;`c.void;enlist(`c.S;enlist(`chkLenEq;64));()]; / void setkey(const char *key);
.b2c.defExtFn[`std;`C.unsetenv;`c.i`chk1;`c.S;()]; / int unsetenv(const char *name);
/ stdio.h
.b2c.defExtType[;()]each `c.FILE`c.fpos_t; / unspecified
.b2c.defCompCast[`K,.b2c.it,`c.FILE_p];
.b2c.defExtVar[;`c.FILE_p]each`C.stdin`C.stdout`C.stderr;
.b2c.defExtVar[;`c.i]each`C.EOF`C._IOFBF`C._IOLBF`C._IONBF;

.b2c.defExtFn[`std;`C.clearerr;`c.void_p;`c.FILE_p;()]; / void clearerr(FILE *stream);
.b2c.defExtFn[`std;`C.ctermid;(`c.S;enlist(`chk0;.b2c.it));enlist(`c.S;((`expr;"`c.ij$`c.j$0");`notarg));()]; / char *ctermid(char *s);
.b2c.defExtFn[`std;`C.fclose;`c.i`chkNot0;`c.FILE_p;()]; / int fclose(FILE *stream);
.b2c.defExtFn[`std;`C.fdopen;(`c.FILE_p,.b2c.it;enlist(`chk0;.b2c.it));`c.i`c.S;()]; / FILE *fdopen(int fildes, const char *mode);
.b2c.defExtFn[`std;`C.feof;`c.i;`c.FILE_p;()]; / int feof(FILE *stream);
.b2c.defExtFn[`std;`C.ferror;`c.i;`c.FILE_p;()]; / int ferror(FILE *stream);
.b2c.defExtFn[`std;`C.fflush;`c.i`chkNot0;`c.FILE_p;()]; / int fflush(FILE *stream);
.b2c.defExtFn[`std;`C.fgetc;(`c.i;enlist(`chkExp;"C.EOF"));`c.FILE_p;()]; / int fgetc(FILE *stream);
.b2c.defExtFn[`std;`C.fgetpos;`c.i;`c.FILE_p`c.fpos_t_p;enlist[`nogen]!(),1b]; / int fgetpos(FILE *restrict stream, fpos_t *restrict pos);
.b2c.defExtFn[`std;`C.fgets;(`c.S;(`chk0,.b2c.it;`notRV));((`c.C;enlist(`chkLen;2));(`c.i;enlist(`length;1));`c.FILE_p);()]; / char *fgets(char *restrict s, int n, FILE *restrict stream);
.b2c.defExtFn[`std;`C.fileno;`c.i`chk1;`c.FILE_p;()]; / int fileno(FILE *stream);
.b2c.defExtFn[`std;`C.flockfile;`c.void;`c.FILE_p;()]; / void flockfile(FILE *file);
.b2c.defExtFn[`std;`C.ftrylockfile;`c.i;`c.FILE_p;()]; / int ftrylockfile(FILE *file);
.b2c.defExtFn[`std;`C.funlockfile;`c.void;`c.FILE_p;()]; / void funlockfile(FILE *file);
.b2c.defExtFn[`std;`C.fmemopen;(`c.FILE_p,.b2c.it;enlist(`chk0;.b2c.it));(enlist `c.C`c.void_p;(`c.size_t;enlist(`length;1));`c.S);()]; / FILE *fmemopen(void *restrict buf, size_t size, const char *restrict mode);
.b2c.defExtFn[`std;`C.fopen;(`c.FILE_p,.b2c.it;enlist(`chk0;.b2c.it));`c.S`c.S;()]; / FILE *fopen(const char *restrict pathname, const char *restrict mode);
.b2c.defExtFn[`std;`C.fputc;(`c.i;enlist(`chkExp;"C.EOF"));`c.i`c.FILE_p;()]; / int fputc(int c, FILE *stream);
.b2c.defExtFn[`std;`C.fputs;(`c.i;enlist(`chkExp;"C.EOF"));`c.S`c.FILE_p;()]; / int fputs(const char *restrict s, FILE *restrict stream);
.b2c.defExtFn[`std;`C.fread;enlist`c.size_t,.b2c.it;(enlist`c.C`c.void_p;(`c.size_t;enlist(`const;"`c.ij$`c.j$1"));(`c.size_t;enlist(`length;1));`c.FILE_p);()];  / size_t fread(void *restrict ptr, size_t size, size_t nitems, FILE *restrict stream);
.b2c.defExtFn[`std;`C.freopen;(`c.FILE_p,.b2c.it;enlist(`chk0;.b2c.it));`c.S`c.S`c.FILE_p;()]; / FILE *freopen(const char *restrict pathname, const char *restrict mode, FILE *restrict stream);
.b2c.defExtFn[`std;`C.fseek;`c.i`chk1;`c.FILE_p`c.long`c.i;()]; / int fseek(FILE *stream, long offset, int whence);
.b2c.defExtFn[`std;`C.fseeko;`c.i`chk1;`c.FILE_p`c.off_t`c.i;()]; / int fseeko(FILE *stream, off_t offset, int whence);
.b2c.defExtFn[`std;`C.fsetpos;`c.i;`c.FILE_p`c.fpos_t_p;enlist[`nogen]!(),1b]; / int fsetpos(FILE *stream, const fpos_t *pos);
.b2c.defExtFn[`std;`C.ftell;`c.long`chk1;`c.FILE_p;()]; / long ftell(FILE *stream);
.b2c.defExtFn[`std;`C.ftello;(`c.off_t,.b2c.it;enlist `chk1,.b2c.it);`c.FILE_p;()]; / off_t ftello(FILE *stream);
.b2c.defExtFn[`std;`C.fwrite;enlist`c.size_t,.b2c.it;(enlist`c.C`c.void_p;(`c.size_t;enlist(`const;"`c.ij$`c.j$1"));(`c.size_t;enlist(`length;1));`c.FILE_p);()]; / size_t fwrite(const void *restrict ptr, size_t size, size_t nitems,FILE *restrict stream);
.b2c.defExtFn[`std;`C.getc;(`c.i;enlist(`chkExp;"C.EOF"));`c.FILE_p;()]; / int getc(FILE *stream);
.b2c.defExtFn[`std;`C.getchar;(`c.i;enlist(`chkExp;"C.EOF"));`c.void;()]; / int getchar(void);
.b2c.defExtFn[`std;`C.getc_unlocked;(`c.i;enlist(`chkExp;"C.EOF"));`c.FILE_p;()]; / int getc_unlocked(FILE *stream);
.b2c.defExtFn[`std;`C.getchar_unlocked;(`c.i;enlist(`chkExp;"C.EOF"));`c.void;()]; / int getchar_unlocked(void);
.b2c.defExtFn[`std;`C.putc_unlocked;(`c.i;enlist(`chkExp;"C.EOF"));`c.i`c.FILE_p;()]; / int putc_unlocked(int c, FILE *stream);
.b2c.defExtFn[`std;`C.putchar_unlocked;(`c.i;enlist(`chkExp;"C.EOF"));`c.i;()]; / int putchar_unlocked(int c);
.b2c.defExtFn[`std;`C.getdelim;`c.ssize_t;`c.C_p`c.size_t_p`c.i`c.FILE_p;enlist[`nogen]!(),1b]; / ssize_t getdelim(char **restrict lineptr, size_t *restrict n, int delimiter, FILE *restrict stream);
.b2c.defExtFn[`std;`C.getline;`c.ssize_t;`c.C_p`c.size_t_p`c.FILE_p;enlist[`nogen]!(),1b]; / ssize_t getline(char **restrict lineptr, size_t *restrict n,FILE *restrict stream);
.b2c.defExtFn[`std;`C.open_memstream;`c.FILE_p;`c.C_p`c.size_t_p;enlist[`nogen]!(),1b]; / FILE *open_memstream(char **bufp, size_t *sizep);
.b2c.defExtFn[`std;`C.pclose;`c.i`chk1;`c.FILE_p;()]; / int pclose(FILE *stream);
.b2c.defExtFn[`std;`C.perror;`c.void;`c.S;()]; / void perror(const char *s);
.b2c.defExtFn[`std;`C.popen;(`c.FILE_p,.b2c.it;enlist`chk0,.b2c.it);`c.S`c.S;()]; / FILE *popen(const char *command, const char *mode);
.b2c.defExtFn[`std;`C.putc;(`c.i;enlist(`chkExp;"C.EOF"));`c.i`c.FILE_p;()]; / int putc(int c, FILE *stream);
.b2c.defExtFn[`std;`C.putchar;(`c.i;enlist(`chkExp;"C.EOF"));`c.i;()]; / int putchar(int c);
.b2c.defExtFn[`std;`C.puts;(`c.i;enlist(`chkExp;"C.EOF"));`c.S;()]; / int puts(const char *s);
.b2c.defExtFn[`std;`C.remove;`c.i`chk1;`c.S;()]; / int remove(const char *path);
.b2c.defExtFn[`std;`C.rename;`c.i`chk1;`c.S`c.S;()];  / int rename(const char *old, const char *new);
.b2c.defExtFn[`std;`C.rewind;`c.void;`c.FILE_p;()]; / void rewind(FILE *stream);
.b2c.defExtFn[`std;`C.setvbuf;`c.i`chkNot0;(`c.FILE_p;(`c.C;enlist(`const;"C.NULL"));`c.i;`c.size_t);()]; / int setvbuf(FILE *restrict stream, char *restrict buf, int type,size_t size);
.b2c.defExtFn[`std;`C.tempnam;(`c.C;(`chk0,.b2c.it;`free));`c.S`c.S;()]; / char *tempnam(const char *dir, const char *pfx);
.b2c.defExtFn[`std;`C.popen;(`c.FILE_p,.b2c.it;enlist`chk0,.b2c.it);`c.void;()]; / FILE *tmpfile(void);
.b2c.defExtFn[`std;`C.tempnam;(`c.C;(`chk0,.b2c.it;`free));`c.S;()]; / char *tmpnam(char *s);
.b2c.defExtFn[`std;`C.ungetc;(`c.i;enlist(`chkExp;"C.EOF"));`c.i`c.FILE_p;()]; / int ungetc(int c, FILE *stream);
