.q2b.fmap:()!();
.q2b.getc:(neg 1 5 .z.K>3.4)_4_;
.q2b.getg:{{$[`=x;y;y like ".*";y;` sv `,x,y]}[first x]each x}; / add ns to globals
.q2b.del:{[ii;t] delete from t where i in ii}; / delete a set of instrs
.q2b.kc:(();0;1;,;`;::;::); / key consts
.q2b.kc[6]:(value(1;))2; / empty value
.q2b.U:`::`flip`neg`first`reciprocal`where`reverse`null`group`hopen`hclose`string`enlist`count`floor`not`key`distinct`type`value`read0`read1`2::`avg`last`sum`prd`min`max`exit`getenv`abs;
.q2b.u:value each string .q2b.U;
.q2b.B:(`$(),/:":+-*%&|^=<>$,#_~!?@."),`0:`1:`2:`in`within`like`bin`ss`insert`wsum`wavg`div;
.q2b.b:value each string .q2b.B;
.q2b.a:(';/;\;':;/:;\:);
.q2b.vc:`l`g`p`lc`pc`gc`gk`fk; / variables
.q2b.rmap:(`b`r;`b`e;`b`b;(`s;0;0;0;`;0;0);(`s;1;0;0;`;0;0)),({(`b;`j`if`d1`d2`bj x)}each til 5),enlist[(`a;3;0;0)],({(`c;`k;x)}each til 7),(8#`),({(`a;2;1;x)}each til 6),
  ({(`a;"j"$i;i+1;x-0 32 i:x>31)}each til 64),enlist[(),`z],({(`p;x)}each til 8),({(`l;x)}each til 23),({(`g;x)}each til 32),({(`c;`c;x)}each til 96);
.q2b.c2t:{{$[(enlist)~x;`enlist;count n:(where x~/:.q)except`;first n;100=type x;1;0]}each x};
.q2b.gn3:{[f;c] $[9>c;(0;i;f[1]i:c-1);(1;i;f[2]i:c-9)]}; / name in a simple assign
.q2b.gn4:{[f;c] $[9>cc:c 1;(1;0;i;f[1]i:cc-1);127<cc;(2;2;i;f[3] i:cc-128);(2;2;i;f[3] i:cc-9)],c 2}; / complex assign
.q2b.defOpts:`simpleTypes`constTypes`opts!(`c`l`p`z;`c`z;`applyOpt`idCallOpt`foldConsts`singleConstOpt`optConsts`emptyBlockOpt);
.q2b.subst1:{[t;k;cc] .q2b.substn[t;(),k;cc]}; / insert app code - no jmps!
.q2b.substn:{[t;k;cc] r:(count cc)#enlist t k0:k 0; r[`c]:cc; : t:((1+k0-count k)#t),r,(k0+1)_t}; / insert app code - no jmps!
.q2b.getCVal:{[f;c] if[not `c=c 0;'"getCVal"]; $[`k=c1:c 1;.q2b.kc c 2;`q=c1;$[`enlist~c 2;enlist;.q c 2];c1 in`f`c;f[4]c 2;'"getCVal"]}; / resolve a constant
.q2b.getC:{[c;v] first where v~/:c}; / get const id
.q2b.addC:{[c;v] $[any v~/:c;c;c,enlist v]}; / add a const
.q2b.na:{neg$[(x 0)in`a`i;(3=x 1)+x 2;`s=x 0;1+0<x 1;1]}; / args num for apps/idx/assign
.q2b.cnsts:enlist(::);

/ @param o dict options
/ @param f func function (type 100)
/ @returns list func code representation (f 0;args 1;loc 2;globs 3;consts 4;code 5;cmap 6;qfns 7;var types 8;f type 9;local anon c variables 10)
/ Instr codes: c(onst),a(plic),(p)aram,l(ocal),g(lobal),b(lock),a(s)ssign, d - empty val const like in f[;x], extentions - (i)ndex C value index, (ca)st, (sp)ecial op, gc,lc,gk,fk - locals and globals<br>
/ c fmt: (`c;`type;idx | name | val) constant where type is `q - .q function, `f - function const, `c - other const, k - basic q const, C - typed const/not K
/ a fmt: (`a;type;nargs;opCode or idx or cast info) - application, type is 0 - unary, 1 - binary, 2 - adverb, 3 - general
/ l,p,g,z fmt: (`l `p `g;idx;q name), (),`z - z - self - always K
/ gc,lc,pc - C globals/locals (type extention) - they never have K type
/ fk,gk - K funcs/globals (b2c extention) - these are K globals but can be used from C directly
/ b fmt: (`b;`type) where type is `r - return, `e - exception, `b - end of stm, `if - if jmp, `j - branch jmp, `d1 - do start, `d2 - do cond, `bj = back jmp
/ s fmt: (`s;stype;vtype;idx;name;fnidx;noNeedRVal) stype is 0 - simple assign, 1 - complex to a local/arg, 2 - complex to a global. vtype: 0 arg, 1 local, 2 global + 3 kglob, 4 weakglob, idx - name idx, fn - func idx, needRVal - need to calc the ret val
/ i fmt: (`i;nargs) - c type only, index into a C value (type extention)
/ ca fmt: (`ca;cast idx) - C cast (type extention)
/ sp fmt: (`sp;`cmd) - special operators: `getptr, `unptr (type extention) + unsafe K casts `c.k$
.q2b.processFn:{[o;f] if[not 100=type f;'`type]; .q2b.processTFn[o;f;`f,(1+count value[f]1)#`K]};
.q2b.processTFn:{[o;f;ft] if[not 100=type f;'`type]; if[f in key .q2b.fmap; :.q2b.fmap f]; o:.q2b.defOpts,o; : .q2b.fmap[f]:.q2b.processFn2[o;f;ft]};
.q2b.processFn2:{[o;f;ft] r:(f;v 1;v 2;.q2b.getg v 3;(.q2b.getc v:value f),(::);()); r[5]:ungroup flip{x[`b]:til count x`c;x}`c`j!.q2b.procFn2 .q2b.procFn1/[(c;());til count c:-1_"j"$first v]1; r,:enlist .q2b.c2t r 4;
  r,:enlist r[6]where -11=type each r 6; r,:(.q2b.getFnVTy[o;ft;4#r];ft); r[5]:.q2b.recode r; r:{.q2b.optMap[z][x;y]}[o]/[r;o`opts]; r};

.q2b.procFn1:{[c;i] if[-1=b:c[0;i];:c]; j:i+til 1^(3 4 5 6 8 9 10!2 3 3 3 3 3 2)b; c[1],:enlist c[0]j; c[0;j]:-1; :c}; / group instr
.q2b.procFn2:{[c] s:0^prev sums count each c; cc:c -1_(asc distinct 0,(i0:1+where d=0),(w:1+w),w2:s?1+s[w]+(1 -1 d[w]=9)*{sum 1 256*-2#x} each c w:where (d:c[;0]) in 5 6 8 9)cut til count c;
  s:0^prev sums count each cc; (cc;@[@[next til count cc;-1+s?w;:;s?w2];-1+s?i0;:;-1])}; / split in blocks, add jumps
.q2b.recode:{[f] cc:f[5]; c:cc`c; cc[`c]:.q2b.recodeP[f] .q2b.recodeS[f;c] .q2b.recodeA[c] .q2b.recodeC[f] .q2b.rmap c[;0]; cc};
.q2b.recodeP:{[f;cc] {$[`p=n:y 0;y,x[1]y 1;`l=n;y,x[2]y 1;`g=n;y,x[3]y 1;y]}[f]each cc};
.q2b.recodeC:{[f;c] if[count i:where (`c~/:c[;1])&`c=c[;0];if[count j:i where -11=type each cc:f[6]c[;2]i;c[j;1]:`q;c[j;2]:f[6]c[j;2]]; c[i where 1~/:cc;1]:`f]; c}; / recode consts
.q2b.recodeA:{[cc;c] c[i;2]:cc[i:where 10=cc[;0];1]; c}; / recode general calls
.q2b.recodeS:{[f;cc;c] if[count i:where cc[;0]=3;c[i;2 3 4]:.q2b.gn3[f] each cc[i;1]; c[i;6]:cc[i+1;0]=2]; if[count i:where cc[;0]=4; c[i;1 2 3 4 5]:.q2b.gn4[f] each cc[i]; c[i;6]:((0<>cc[i;1])&ci=0)|2=ci:cc[i+1;0]]; c}; / recode assigns
/ Optimize "val;" where val is in opt[`simpleTypes], `c`l`p`z by default
.q2b.opt1:{[o;f] j:exec i from f[5] where (b=prev b)&(prev c[;0]in o`simpleTypes)&`b=c[;0], `b=c[;1]; f[5]:.q2b.del[j,j-1;f 5]; f};
/ Remove empty blocks. Should be run before any map except jmp is added.
.q2b.opt2:{[o;f] bb:exec distinct b from f[5]; f[5]:update j:{x x binr y}[bb]each j from f[5] where not j in bb, j>=0; f};
/ remove id calls and ret ret
.q2b.opt4:{[o;f] j:exec i from f[5] where `a=c[;0], 0=c[;1], 0=c[;3]; j2:exec i from f[5] where (b=prev b)&(`b`r~/:prev c)&`b=c[;0], `r=c[;1]; f[5]:.q2b.del[j,j2;f 5]; f};
/ convert @[f;a] to f[a]
.q2b.opt5:{[o;f] k:exec i from f[5] where `a=c[;0], 1=c[;1], 18=c[;3]; f[5]:update c:(count i)#enlist(`a;3;1;0) from f[5] where i in k; f};
/ const folding
.q2b.fcMap:{x!{(1b;.[x;y])}@/:x}(+;-;*;%;&;|;^;=;<;>;$;,;_;~;::;flip;neg;first;reciprocal;where;reverse;null;group;string;floor;not;distinct;type;avg;last;sum;prd;min;max;abs); / general funcs
.q2b.fcMap[!]:{$[2<>count x;0b;(type x 0)within(0;19);(1b;.[!;x]);0b]}; / key!val case only
.q2b.fcMap[til]:{$[(1=count x)&20>x 0;(1b;til x 0);0b]};
.q2b.fcMap[#]:{$[(type[x 0]in -6 -7h)&20>count x 0;(1b;x[0]#x 1);0b]};
.q2b.fcMap[count]:{$[-11=type x 0;0b;(1b;count x)]}; / do not do count sym - need for sizeof operator
.q2b.fcMap[']:{$[(all(type each x)in 101 102h)&2=count x;(1b;('). x);0b]};
.q2b.fcMap[enlist]:{(1b;x)};
.q2b.foldF:{[f;c;a;aa;ii] fn:$[0=c1:c 1;.q2b.u c 3;1=c1;.q2b.b c 3;2=c1;.q2b.a c 3;.q2b.getCVal[f;aa 0]]; if[any fn~/:key .q2b.fcMap;
  if[first v:@[.q2b.fcMap fn;.q2b.getCVal[f]each a _ aa;0b]; f[4]:.q2b.addC[f 4;v 1]; f[5]:.q2b.substn[f 5;ii;enlist(`c;`c;.q2b.getC[f 4;v 1])]]]; f};
.q2b.opt6:{[o;f] n:count f 5; f:{cc:x[5]`c;$[(1=count distinct x[5][`b]y,ii)&all`c=(aa:cc ii:y+neg 1+til n:(a:3=c 1)+(c:cc[y])2)[;0];.q2b.foldF[x;c;a;aa;y,ii];x]}/[f;desc exec i from f[5] where `a=c[;0]]; $[n=count f 5;f;.z.s[o;f]]};
/ const compact
.q2b.opt7:{[o;f] ii:exec i from f[5] where `c=c[;0], c[;1]in`c`f; if[count mm:{x!til count x}distinct f[5][ii;`c][;2]; f[5]:update c:{y[2]:x y 2;y}[mm]each c from f[5] where i in ii;
  f[4]:(f[4]key mm),(::); f[6]:.q2b.c2t f 4]; if[0=count mm; f[4 6]:(();())]; f};
/ calc stack state
.q2b.calcStk:{[cc;s;k] l:enlist k; $[(i:(c:cc[k;`c])0)in`a`i`s`ca`sp; s:(.q2b.na[c]_s),l; `b=i; $[c[1]in`d1`if`b`j;s:-1_s;s]; i in`ca`sp; s:(-1_s),l; s:s,l]};

.q2b.optMap:`singleConstOpt`emptyBlockOpt`idCallOpt`applyOpt`foldConsts`optConsts!(.q2b.opt1;.q2b.opt2;.q2b.opt4;.q2b.opt5;.q2b.opt6;.q2b.opt7);

/ typing extention: all fns/vars by default are K. Consts are either K or Ki KJ and etc to denote simple values to be used as indecies
/ type: `typename, (`p;type), (`s;`name;`n1..`nk!(type1;..;typek)), (`a;length;type), (`l;type1,..,typek), (`Kx;const),
/    (`f;res type;a1 type;..;an type) - `l for index, `l (list) and `Kx - for internal use only
/ assign result types to each code where `a => (`rtype;fn/obj type;arg/idx types), `s => (indexed variable type;var type;is it pure;index type;func/val type)
.q2b.types:([] name:`c.j`c.long_long`c.i`c.int`c.uint`c.f`c.double`c.e`c.void`c.cvoid`c.bool`c.schar`c.g`c.uchar`c.char`c.c`c.S`c.h`c.short`c.ushort`c.long`c.cchar;
  cname:((),"J";"long long";(),"I";"int";"unsigned int";(),"F";"double";"E";"void";"const void";"_Bool";"signed char";(),"G";"unsigned char";"char";"char";"char*";(),"H";"short";"unsigned short";"long";"const char");
  def:(`c.long_long;();`c.int;();();`c.double;();();();();();();`c.uchar;();();`c.char;`p`c.c;`c.short;();();();()); ex:1b);
`.q2b.types upsert {(`$"c.",upper -1#string x`name;x[`cname],"*";(`p;x`name);1b)}each select from .q2b.types where name in `c.i`c.j`c.f`c.e`c.g`c.c`c.h;
`.q2b.types upsert {(`$string[x`name],"_p";x[`cname],"*";(`p;x`name);1b)}each select from .q2b.types where name in `c.long_long`c.int`c.uint`c.double`c.void`c.uchar`c.I`c.J`c.F`c.E`c.G`c.C`c.H`c.S`c.short`c.ushort`c.long`c.cvoid`c.cchar;
.q2b.ktypes:`K`Ki`KI`Kj`KJ`Kf`Ks`KC`Kvoid; / general K obj and some K consts, Kvoid = ::
.q2b.constTypes:.q2b.ktypes except `K; / (Kx;const) types
.q2b.t2kt:(0 -6 6 -7 7 -9 -11 10h)!-1_.q2b.ktypes;
.q2b.baseTypes:.q2b.ktypes,exec name from .q2b.types where 0=count each def;
.q2b.f2t:([] n:0#`; f:(); t:(); d:0#0b; gf:()); / func types, allow overload of primitives, d - destructive app, gf - generation func if applicable
.q2b.castMap:([] tf:`$(); tt:`$(); inl:0#0b; constf:(); castf:()); / type from, type to, inlinable, const cast fn, castf
`.q2b.castMap upsert (`;`;1b;::;{y});
.q2b.getFnTy:{[f] n:1+count (v:value f)1; $[not 10=type t:v 4;`f,n#`K;t like"c)*";$[(not any tt~\:`..)&(11=type tt)&n=count tt:value 2_t;[.q2b.chkTy tt:`f,tt;tt];'"wrong type def: ",t];`f,n#`K]}; / fn decl
.q2b.extrAttr:{[f] r:()!(); if[count a:{x where x like "att","r)*"}v where 10=type each v:value f; r:@[{{(.q2b.getVName each key x)!value x}raze value each 5_/:x};a;{'"Bad attr) :",x}]]; r};
.q2b.chkTy:{$[-11=type x;$[x in `K`..,.q2b.types`name;::;'"unknown type: ",string x];`s=x0:x 0;$[99=type x 2;.z.s each x 1;'"bad struct: ",.Q[`s1]x];`p=x0;.z.s x 1;`a=x0;.z.s x 2;`f=x0;.z.s each 1_x;'"unknown type: ",.Q[`s1]x]}; / type validation
.q2b.crtType:{if[.q2b.pureK x;:`K]; if[-11=type x;:x]; if[first[x]in`f`p;x:x[0],.q2b.crtType each 1_x]; if[null n:exec first name from .q2b.types where def~\:x;`.q2b.types upsert (n:`$"c..anontype",string count .q2b.types;"";x;0b)]; n};
.q2b.getVTy:{[m;l] $[l in key m;m;l like "c.do[1-9]";m[l]:`c.j;l like "c.*";$[2=count nn:` vs l;m;[t:` sv`c,nn 1;sn:` sv nn 0 2;if[((t<>`c.j)&sn like"c.do[1-9]")|not any m[sn]~/:(::;t);'"local type redefined: ",string l];
  m[l,sn]:t;.q2b.chkTy t]];0<count t:exec t from .q2b.f2t where l=n;m[l]:last t;m[l]:`K];m}; / type from name
.q2b.getFnVTy:{[o;ft;v] m:.q2b.getVTy/[(`,v[1],v 2)!(::),(2_ft),(count v 2)#`K;n:v 3]; if[not all e:n in key m;'"type not found for: "," "sv string n where not e]; m:` _m; .q2b.crtType each m}; / map func vars to types
.q2b.resolveFT:{[des;fn] $[count r:$[-11=type fn;exec i from .q2b.f2t where n=fn, d=des;exec i from .q2b.f2t where fn~/:f, d=des];r;(),0N]}; / resolve fn type - K by default, returns idxs in f2t
.q2b.resolveFC:{[f;c] if[`c=first c;if[(c 1)in`f`c`q;:$[100>type fc:$[`q=c 1;.q;f 4]c 2;();null first t:.q2b.resolveFT[0b;fc];();t]]]; if[`g=first c; if[not null first t:.q2b.resolveFT[0b;c 2]; :t]]; ()}; / types for a func const
.q2b.pureK:{$[(f:first x)in `l`f; all .z.s each 1_x; f in .q2b.ktypes]}; / pure K value
.q2b.printT:{{$[-11=type x;$[x like "*anontype*";.z.s[.q2b.unwindT x;y];string[x],y];`s=f:first x;$[x 3;"struct ";"union "],x[1],y;`p=f;.z.s[x 1;" *",y];`a=f;.z.s[x 2;"(",y,")[",string[x 1],"]"];`l=f;"(",(";"sv .z.s[;""]each 1_x),")",y;
  f in .q2b.baseTypes;string[f],y;`f=f;.z.s[x 1;""],"(",(","sv .z.s[;""]each 2_x),")",y;.Q[`s1][x],y]}[x;""]};
.q2b.indexTF:{[t;i] if[`..=last t; if[count[t]>3+count i;:(::)]; t:t,((2+count i)-count t)#last t:-1_ t]; $[count[t]=2+count i;$[all .q2b.matchT'[2_t;i];t 1;::];::]}; / .. case!
.q2b.indexT:{[is0;t;i] $[0=count i;t;is0&.q2b.pureK[t]&all .q2b.pureK each i;`K;(`s=f:first t:.q2b.unwindT t)&(fi:first i 0)in`Ks`KC;$[(ix:$[fi=`Ks;::;`$]i[0;1])in key t 2;.z.s[0;t[2]ix;1_i];::];`f=f;.q2b.indexTF[t;i];
  {$[x=`p;`f=first .q2b.unwindT y 1;0b]}[f;t];.q2b.indexT[is0;t 1;i];(f in`p`a)&.q2b.matchT[`c.j;fi]|.q2b.matchT[`c.i;fi]|fi in`Ki`Kj;.z.s[0;last t;1_i];(`s=first t:.q2b.unwindT last t)&(`p=f)&fi in`Ks`KC;.z.s[is0;t;i];::]}; / calc type of an index strct[`field] arr[idx] p[idx]
.q2b.indexF:{[ft;isC;a] if[not(::)~v:.q2b.indexT[1;ft;a]; if[isC&`f=first ft; if[not count[ft]=2+count a;'"C-function: wrong num args"]]]; v}; /  for C-level pure K funcs
.q2b.unwindT:{[t] $[-11=type t;$[t in .q2b.baseTypes;t;null i:exec first i from .q2b.types where name=t;'"unknown type: ",string t;$[()~v:.q2b.types[i;`def];t;.q2b.unwindT v]];t]}; / resolve name->def
.q2b.matchT0:{[t1;t2;f] if[t1~t2;:1b]; t1:.q2b.unwindT t1; t2:.q2b.unwindT t2; $[t1~t2;1b;(t1~`c.void)&t2~`Kvoid;1b;(`p=f1:first t1)&`p=f2:first t2;f[t1 1;t2 1];(`a=f1)&`a=f2;f[t1 2;t2 2];(`s=f1)&(`s=f2);t1[1]~t2 1;0b]};
.q2b.matchT:{[t1;t2] if[.q2b.pureK[t1]&.q2b.pureK t2;:1b]; .q2b.matchT0[t1;t2;.z.s]}; / treat all K types as the same type
.q2b.matchTEx:{[t1;t2] if[.q2b.pureK[t1]&.q2b.pureK t2; :$[all t:(f1:first t1;f2:first t2)in .q2b.constTypes;f1=f2;not t 1]]; .q2b.matchT0[t1;t2;.z.s]}; / K and Kx are different
.q2b.matchFT:{[f;a] f:{$[-7=type x;$[null x;(`K;x);(.q2b.f2t[x;`t];x)];(x;0N)]}each f; if[(::)~r:{$[(::)~y;$[(::)~r:.q2b.indexF[z 0;.q2b.pureK[z 0]&not null z 1;x];r;(r;z 0;z 1;x)];y]}[a]/[::;f];
  '"fn type mismatch, arg type(s): (",(", "sv .q2b.printT each a),"), fn type: ","; "sv .q2b.printT each f[;0]]; r}; / match fn
.q2b.cast:{[at] if[`Ks=first a0:at 0; if[count t:?[.q2b.castMap;((=;`tt;(`a0;1));(>;`i;0);(each;.q2b.matchTEx[at 1];`tf));();`i];:(a0 1;t 0)]; if[a0[1]in .q2b.types`name; if[any at[1]~/:(.q2b.unwindT a0 1;a0 1);:(a0 1;0)]]]; $[all .q2b.pureK each at;`K`K;'"cast type mismatch: from ",.q2b.printT[at 1]," to ",.q2b.printT at 0]}; / `type$val
.q2b.matchSpec1:{[f;a] $[(`Ks=first a 0)&13=f;$[a[0;1] in .q2b.types`name;`c.size_t`c.void,a[0;1],`sizeof;`K`K];.q2b.pureK a 0;`K`K;5=f;((`p;$[`a=first b:.q2b.unwindT a 0;b 2;a 0]);`c.void;`getptr);13=f;`c.size_t`c.void`sizeof;
  `p=first a:.q2b.unwindT a 0;(a 1;`c.void;`unptr);'"can't do (*val) for type ",.q2b.printT a]};
.q2b.calcFCall:{[f;st;ty;c;k] ls:k; ft:$[0=c1:c 1;.q2b.resolveFT[0b] .q2b.u c 3;1=c1;.q2b.resolveFT[0b] .q2b.b c 3;2=c1;enlist`K;$[count t:.q2b.resolveFC[f;f[5;ls:last st k;`c]];t;1#ty ls]]; / calc fn type and args types
  at:(ty (c1=3)_reverse .q2b.na[c]#st k)[;0]; $[`c`q`enlist~3#f[5;ls;`c];$[.q2b.pureK l:`l,at;`K`K;{(not 0~x 1)&`s=x 0}f[5;k+1]`c;enlist l;'"C type in enlist: ",.q2b.printT l]; / ensure enlist + C is used in assign idx only
    (1=c1)&11=c 3;.q2b.cast[at];(0=c1)&c[3]in 3 5 13;.q2b.matchSpec1[c 3;at];.q2b.matchFT[ft;at]]}; / validate fn call
.q2b.calcA:{[f;st;ty;c;k] vt:f[8]c 4; at:(ty .q2b.na[c]#st k)[;0]; it:$[0=c 1;(),`l;(),at 1]; if[(::)~vit:.q2b.indexT[1;vt;$[`l=first it;1_it;it]];'"idx type mismatch in assign to ",string[c 4]," - var type: ",.q2b.printT[vt],", idx type: ",.q2b.printT[it]];
  ft:$[0<c 5;.q2b.matchFT[.q2b.resolveFT[1b;.q2b.b c 5];(vit;at 0)]2;$[.q2b.matchT[vit;at 0];at 0;'"type mismatch in assign to ",string[c 4]," - var type: ",.q2b.printT[vit],", val type: ",.q2b.printT[at 0]]];
  ($[c[6]&not .q2b.pureK vit;`c.void;vit];vt;.q2b.pureK  vt;it;ft)}; / assign
.q2b.calcC:{[f;c;isA] if[count t:.q2b.resolveFC[f;c]; :.q2b.f2t[last t;`t]]; v:$[`k=c 1;.q2b.kc 5&c 2;`c=c 1;f[4]c 2;(),::]; tf:{t:`K^.q2b.t2kt type x; $[(::)~x;`Kvoid;()~x;(),`l;`K=t;t;(t;x)]}; $[isA&type[v]within 0 19h;`l,tf each v;tf v]}; / map some consts to specific const types
.q2b.calcB:{[f;c;t] if[`r=c;if[not((rt~`c.void)&`Kvoid~first t)|.q2b.matchT[t;rt:f[9]1];'"return type mismatch: expected ",.q2b.printT[f[9]1],", calculated ",.q2b.printT t]]; if[(`e=c)&not .q2b.pureK t;'"exception type must be K not ",.q2b.printT t]};
.q2b.swapConsts:{[c;ty;st] if[count i:i where(first each first each ty i:(neg[$[`a=c 0;3=c 1;0<c 1]]_.q2b.na[c]#st))in`Ki`Kj`Kf; ty[i]:{((`Ki`Kj`Kf!`c.i`c.j`c.f)first x 0;x[0]1)}each ty i]; ty};
.q2b.calcT0:{[f;cc;st;ty;k] if[(j:first c:cc[k;`c])in`a`s; fn:(.q2b.calcFCall;.q2b.calcA)j=`s; if[10=type r:.[fn;(f;st;ty;c;k);::]; ty:.q2b.swapConsts[c;ty;st k]; r:.[fn;(f;st;ty;c;k);{y;'x}r]]; ty[k]:r; :ty];
  ty[k]:$[j in`p`l`g;enlist f[8]c 2;`z=j;enlist$[.q2b.pureK f 9;`K;f 9];`c=j;enlist .q2b.calcC[f;c;any((`s;1);(`s;2))~\:2#cc[k+1;`c]];`b=j;[t:ty last st k;.q2b.calcB[f;c 1;t 0];t];'"notimpl"];ty};
.q2b.calcTErr:{[o;f;c;i;msg] 'msg};
.q2b.calcT:{[o;f;cc;st;ty;k] .[.q2b.calcT0;(f;cc;st;ty;k);.q2b.calcTErr[o;f;cc;k]]}; / for more readable errors
.q2b.calcTypes:{[o;f] cc:f 5; cc[`st]:st:prev .q2b.calcStk[cc]\[();tc:til count cc]; cc[`ty]:.q2b.calcT[o;f;cc;st]/[count[cc]#(::);tc]; jmp:select idx:i,jend:-1+(exec first i by b from cc)j from cc where `b=c[;0], `j=c[;1];
  {if[not .q2b.matchT[t1:first x y`idx;t2:first x y`jend];'"branch type mismatch: first ",.q2b.printT[t1],", second: ",.q2b.printT t2]}[cc`ty]each jmp; cc[`pure]:.q2b.pureK each (cc`ty)[;0]; cc[distinct jmp`jend;`j]:-2; / mark lst branch
  / if[count k:k where{$[`b=(c:x`c)0;not .q2b.pureK[first x`ty]|c[1]in`r`e`d1`if;0b]}each cc 1+k:distinct jmp`jend; cc[`ty]:.[cc`ty;(distinct k,exec idx from jmp where jend in k;0);:;`c.void]]; / set c.void for $[;;];
  {c:x y;if[not any .q2b.matchT[v:c[`ty]0]each t:`K`c.i`c.j,$[f:`if=c[`c]1;`c.bool;()];'$[f;"if condition";"do counter"]," type mismatch, allowed types: ",(", "sv string t),"; calc type: ",.q2b.printT v]}[cc]
  each exec i from cc where `b=c[;0], c[;1]in`if`d1;f[5]:cc; f};
/ remap c consts
.q2b.remapConsts:{[f] cc:f 5; fn:{$[(first first x)in key .q2b.cnstCast;(`c;`C;.q2b.cnstCast[x 0]x 1);'"invalid const type"]}; cc:update c:fn each ty from cc where `c=c[;0], not `f=c[;1], not pure; f[5]:cc; f};
/ simplify casts, general app -> cast app or const
.q2b.transCast:{$[(::)~f:.q2b.castMap[n:x[y;`ty]1;`constf];[if[((x[y;`ty]0)in`c.k`c.unsafe_k)&(.q2b.pureK x[y-2;`ty]0)&not(x[y-2;`c]0)in `c,.q2b.vc;'"unsafe c.k cast, instr: ",.Q[`s1]x[y-2;`c]];(`ca;n)];
  (`c;`C;{if[not 10=type x;'"const cast: not a string: ",.Q[`s1]x];x}@[f;v 1;{'"const cast failed: ",(.Q[`s1].q2b.castMap[x]`tt`tf)," for ",.Q[`s1][y]," with ",z}[n;(v:x[y-2;`ty]0)1]])]};
.q2b.simpleCast:{[f] cc:f 5; if[0=count ii:exec i from cc where `a=c[;0], 1=c[;1], 11=c[;3], not ty[;0]~\:`K; :f]; cc[ii;`c]:v:.q2b.transCast[cc]each ii; f[5]:.q2b.del[(-2+ii where `c=v[;0]),ii-1;cc]; f};
.q2b.compCast:{[f] cc:f 5; if[0<count ii:{[x;y]exec i from x where `ca=c[;0], 7=type each y[`castf]c[;1]}[cc;.q2b.castMap]; f[5]:{x:.q2b.subst1[x;y;`ca,/:n:.q2b.castMap[`castf]x[y;`c]1];x[y+til count n;`ty]:.q2b.castMap[n;`tt],'n;x}/[cc;reverse ii]; :.z.s f]; f};
/ remap c vars to gc/lc
.q2b.remapCVars:{[f] cc:f 5; cc[`c]:{yy:y 8; $[`g=x 0;$[x[2]like"c.*";$[.q2b.pureK yy x 2;'"C-locals can't have K type: ",string x 2;(`lc;x 1;.q2b.getVName x 2)];(not x[2]in .q2b.f2t`n)&.q2b.pureK yy x 2;x;`gc,x 1 2];
  `s=x 0;[x[4]:.q2b.getVName x 4;x];`p=x 0; $[.q2b.pureK yy x 2;x;(`pc;x 1;x 2)];`z=x 0;$[.q2b.pureK y 9;x;(`gc;0),.q2b.f2t[`n]first where y[0]~/:.q2b.f2t`f];x]}[;f]each cc`c;
  f[3 8]:(f[3]where not f[3]like"c.*";(distinct .q2b.getVName each key f 8)#f 8); f[5]:cc; f};
.q2b.getVName:{$[x like"c.*";` sv(first;last)@\:` vs x;x]};
/ how a local/param/global changes(may change) along bytecode
.q2b.addVFlow:{[f] g:{x where not x like "c.*"}(k:key f 8)except f[1],f 2; cc:f 5; cc[`vf]:{@[prev x;0;:;x 0]}{$[`s=z 0;y[z 4]+:1;`a=z 0;y[x]+:1;::];y}[g]\[k!(count k)#0;cc`c]; f[5]:cc; f};
/ change cvar[..] to index, also &val and *val, ensure & is aplied to a lvalue, change `c.k$ to `sp`c.k
.q2b.remapCIdx:{[f] cc:f 5; fn:{$[.q2b.pureK[x]|`f=first t:.q2b.unwindT x;0b;`p=first t;not `f=first .q2b.unwindT t 1;1b]}; cc:update c:{$[any(l:last y)~/:`getptr`unptr`sizeof;(`sp;l);(`i;3;x 2)]}'[c;ty] from cc where `a=c[;0], fn each ty[;1];
  cc:update c:count[i]#enlist`sp`c.k from cc where `ca=c[;0], (first each ty[;0])in `c.k`c.unsafe_k; f[5]:cc;
  {if[not(f:first(x y)`c)in`lc`pc`gc;if[f=`ca;if[not .q2b.castMap[last(x y)`c]`inl;:()]];if[not(`i=f)&(`p=t:first .q2b.unwindT v[`ty]0)|(first(v:x y-1)`c)in`lc`pc`gc;'"& applied to a non-lvalue, type ",.q2b.printT v[`ty]0]]}[cc]each -1+exec i from cc where `sp=c[;0], `getptr=c[;1]; f};
/ f(Kvoid) -> f()
/ .q2b.remap0Args:{[f] cc:f 5; k:exec i from cc where `Kvoid=first each prev ty[;0], `a=c[;0], 1=c[;2]; cc:update {x[2]:0;x}each c from cc where i in k; f[5]:.q2b.del[k-1;cc]; f};
.q2b.simplifyCExpr:{[o;f] .q2b.addVFlow .q2b.remapCIdx .q2b.compCast .q2b.simpleCast .q2b.remapCVars .q2b.remapConsts f};
/ calc opcode status - 0 -inlined, 1 -val discarded, 2 -val used anon. For C assign make its index a trivial expression
.q2b.inlA:{[cc;c;v] v[i]:{[cc;c;v;i] p:(ck:cc i)`c; $[`g=o:p 0;2;o in .q2b.vc;2*not(ck[`vf]p 2)=c[`vf]p 2;o in`c`z`i`sp;0;`ca=o;2*not .q2b.castMap[p 1;`inl];null v i;2;v i]}[cc;c;v]each i:.q2b.na[c`c]#c`st; v};
/ .q2b.inlS:{[cc;c;v;k] v:.q2b.inlA[cc;c;v]; if[(0<c[`c;1])&2=v[k]:2-c[`c;6]; if[(not .q2b.pureK c[`ty;1])&`i=first(enl:cc last c`st)`c; v:.q2b.inlA[cc;enl;v;1]]]; v};
.q2b.calcSt1:{[cc;v;k] c:(ck:cc k)`c; w:$[-2=ck`j;2;v k]; v[k]:$[`b=o:c 0;[v[k-1]:2-c[1]in`d2`b`bj;1];`s=o;[v:.q2b.inlA[cc;ck;v];w|2-c 6];o in`a`i`ca`sp;[v:.q2b.inlA[cc;ck;v];2&(1+o=`ca)*1^w];`g=o;2;0^w]; v};
/ add C internal vars
.q2b.remapTy:{[cc;v] if[count first ds:exec (i;b;j) from cc where c[;0]=`b, c[;1]=`d2; v[-2+ds 0]:(`$"_c_do",/:string sum each ds[1]within\:ds 1 2),\:`c.j];
  if[count ds:exec i from cc where c[;0]=`b, c[;1]=`r, not pure; ids:ds where cc[ds;`b]=cc[-1+ds;`b]; v[ds]:(`$"__res"),/:v[-1+ds][;1]; v[-1+ids]:v ids]; v[k]:(count k:where`s=(cc`c)[;0])#enlist``;
  if[count ii:raze{ck:x y;if[not(enlist`l)~ck[`ty;3];:()];$[(ck[`b]=ckp`b)&(not`ca=x[i;`c]0)&2=(ckp:x i:first .q2b.na[ck`c]#ck`st)`inl;enlist(y;i);()]}[cc]each ii:exec i from cc where `s=c[;0], not pure, 0=c[;5];
    v[ii[;1]]:count[ii]#enlist``.s; v[ii[;0]]:count[ii]#enlist``.skip]; v};
.q2b.calcCVTy:{[f;cc] cc[`cty]:.q2b.remapTy[cc]{$[(x<>2)|.q2b.pureK z;``;(`$.b2c.mkln[0]`$"v",string[z],string y;z:.q2b.crtType z)]}'[cc`inl;0^next count each cc`st;cc[`ty][;0]];
  f[5]:cc; f:f,enlist{x where not null x[;0]}distinct cc`cty; if[not all(`$.b2c.mkln[0] each k where(k:key f 8)like"c.do[1-9]")in cc[`cty][;0];'"undefined c.doN"]; f};
.q2b.calcKVal:{[cc] cc[`sn]:{c:x z; y[z]:$[c[`c;0]in`ca`i`a`s;sum{c:x z;$[c[`pure]&c`inl;1;c`inl;0;y z]}[x;y]each(.q2b.na c`c)#c`st;0];y}[cc]/[(count cc)#0;til count cc]; cc}; / used K vals in 1 op
.q2b.calcVal:{[cc] cc:.q2b.calcKVal cc; cc[`v]:prev{$[`b=a:z[`c;0];(0<z`pure)&z[`c;1]in`r`e;$[z`sn;0b;y]|0<z[`pure]&(`s=a)<z`inl]}[cc]\[0b;cc]; cc}; / set value - after all opts
.q2b.removeDV:{[cc] update inl:0 from cc where inl=1, c[;0]in`lc`gc`gk}; / mark all C vars + sp with inl 1 as inl 0 - they will be ignored
.q2b.chkFnTy:{[f] if[any `f=first each .q2b.unwindT each(f[8]key[f 8]except f 3),f[5][`cty][;1]except``K`.s`.skip; '"cvars/exps with the function type are not allowed, use a pointer"]; f};
.q2b.calcOpStatus:{[o;f] cc:f 5; cc[`st]:prev .q2b.calcStk[cc]\[();tc:til count cc]; cc[`inl]:.q2b.calcSt1[cc]/[(count cc)#0N;reverse tc]; .q2b.chkFnTy .q2b.calcCVTy[f;.q2b.calcVal .q2b.removeDV cc]};
.q2b.optMap[`calcTypes`simplifyCExpr`calcOpStatus]:(.q2b.calcTypes;.q2b.simplifyCExpr;.q2b.calcOpStatus);
