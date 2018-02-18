.b2c.J:0;
.b2c.LC:"__consts";
.b2c.Q:"__q";
.b2c.G:"__glob";
.b2c.psh:"__st[__stc++]=";
.b2c.pshv:"__st[__stc++]=__v; ";
.b2c.popv:"__v=__st[--__stc]; ";
.b2c.krr:" if(0==__v) goto __return; ";
.b2c.ub:.q2b.u,.q2b.b,.q2b.a;
.b2c.is32:.z.o like "*32";
.b2c.P:"JI".b2c.is32;
.b2c.it:`c.j`c.i .b2c.is32;
.b2c.c:({"j"$x};{"i"$x}).b2c.is32;
.b2c.intfns:`.b2c.K2i_cast`.b2c.K2j_cast`.b2c.K2f_cast`.b2c.K2h_cast`.b2c.K2c_cast`.b2c.K2I_cast`.b2c.K2J_cast`.b2c.K2H_cast`.b2c.K2F_cast`.b2c.K2E_cast`.b2c.K2S_cast`.b2c.K2C_cast`.b2c.K2K_cast`.b2c.k2K_cast,
  `.b2c.kvalue`.b2c.kcols`.b2c.kupsert`.b2c.kmeta`.b2c.kset`.b2c.kxasc`.b2c.kxdesc`.b2c.kxsc`.b2c.kapp3`.b2c.kapp4`.b2c.kwget`.b2c.kapp1`.b2c.kkey`.b2c.kkeys;
.b2c.intused:`$();
.b2c.intglobs:`.b2c.consts`.b2c.intmap`.b2c.libFuncs`.b2c.libGlobs`.b2c.wglobals`.b2c.Kerr;
.b2c.q2bOpts:`simpleTypes`opts!(`c`l`p`z`gk`fk`lc`pc`gc;`applyOpt`idCallOpt`emptyBlockOpt`foldConsts`calcTypes`simplifyCExpr`substCGlob`singleConstOpt`substSel`emptyBlockOpt`calcOpStatus`remapIdxConsts`optConsts);
.b2c.gcc:{[o;n] cmd: "gcc -DKXVER=3 ",$[.b2c.is32;"-m32 ";""],"-fPIC -shared ",$[o`O;"-O",string o`O;""]," -o ",((-1_ n),"so "),n:1_ string n; system 0N!cmd;};
.b2c.libs:(`$())!();
.b2c.include:("<errno.h>";"<stdio.h>";"<stdlib.h>";"<math.h>");
/ .b2c.defF2T:([] n:0#`; f:(); t:(); d:0#0b; idx:0#0);
/ make C name
.b2c.mkan:{"_anon",string(.b2c.J+:1)+`long$.z.P};
.b2c.mkn:{if[y in .b2c.intfns,.b2c.intglobs; :"__",5_string y]; string[x`libname],$[`=y;.b2c.mkan[];ssr[string y;".";"_"]]};
.b2c.mkln:{$[x;string .b2c.g2n y;"_",ssr[string y;".";"_"]]}; / c vars
.b2c.mkng:{if[x in .b2c.intfns,.b2c.intglobs; :"__",5_string x]; if[x like "C.*"; :2_string x]; ssr[string x;".";"_"]};
.b2c.a2n:()!`$();
.b2c.mkcn:{if[y=`; if[null n:.b2c.a2n z; n:`$.b2c.mkn[x;y]; .b2c.a2n[z]:n]; :string n]; .b2c.mkn[x;y]};
.b2c.r1:{"r1(",x,")"};
.b2c.GET:.b2c.r1 .b2c.LC,"[26]";
/ change `c and `g to `k if they are compiled globals
.b2c.substCGlob:{[o;f] cc:f[5]; cc[`c]:{[o;f;c] $[null n:$[`g=i:first c;o[`globals]c 2;`c=i;$[`f=c 1;{$[count i:where key[x]~\:y;value[x]i 0;0N]}[o`funcs;f[4]c 2];0N];`z=i;o[`fi][`f]?f 0;0N];c;{(`gk`fk `f=x 1),0,x}$[`g=i;c 2;`],o[`fi][n]`t`cn`na`pure]}[o;f]each cc`c;
  cc:update c:{$[null i:x[`globals]y 4;::;((x:x[`fi]i)`t)in`g`gl;y[2 4]:(3+x[`t]=`gl;`$x`cn);'"c-assign: ",string y 4];y}[o]each c from cc where `s=c[;0], 2=c[;2], pure;f[5]:cc; f};
/ wrap selects/updates and etc to allow locals
.b2c.substSel:{[o;f] cc:f[5]; if[not count k:exec i from cc where (`a=c[;0])&prev{$[`c`c~2#y;(x y 2)~(?);`c`q`lsq~y]}[f 4]each c, 4=c[;2], pure; :f]; / find ?|![a1;a2;a3;a4]
  f[4],:value "{[",string[f[1;0]],";b_q2b0;b_q2b1;b_q2b2;b_q2b3;b_q2b4;b_q2b5] ",(" "sv{y,'(":",string[x],"["),/:(string til count y),\:"];"}[f[1;0]]string reverse f[1],f[2]),
    " $[b_q2b1~(?);?[b_q2b0[1][b_q2b2;0];b_q2b3;b_q2b4;b_q2b5];[r:![[b_q2b3:b_q2b0[1][b_q2b2;1];$[b_q2b4:(-11=type b_q2b2)&(not -11=type b_q2b3);(b_q2b3:();b_q2b3);(b_q2b3:b_q2b2:();b_q2b2)]1];b_q2b3;b_q2b4;b_q2b5];",
      "$[b_q2b4;b_q2b0[0][b_q2b2;r];r]]]}"; / proxy fn, complexity is to ensure 0 references for weakglobals
  gg:((`fk;0;`.b2c.kwget;`f;"__kwget";2;1b);(`fk;0;`.b2c.kset;`f;"__kset";2;1b);(`c`q`enlist);(`a;3;2;0)); / pass get/set for C globals
  d:gg,(`p,/:(til count f 1),'f 1),(`l,/:(til count f 2),'f 2),((`c`q`enlist);(`a;3;count[f 1]+count[f 2];0);(`c;`c;-1+count f 4);(`a;3;7;0)); / ?[a;b;c;d] -> f[(p1;..;l1;..);getset,?;a;b;c;d]
  f[5]:{.q2b.subst1[y;z;x]}[d]/[f 5;desc k]; f};
.b2c.if2sym:`..value`..cols`..meta`..key`..keys`..app`..upsert`..set`..xasc`..xdesc`c.S`c.C`c.I`c.J`c.F`c.H!((),`.b2c.kvalue;`.b2c.kcols`.b2c.kapp1;`.b2c.kmeta`.b2c.kapp1;`.b2c.kkey`.b2c.kapp1;`.b2c.kkeys`.b2c.kapp1;
  `.b2c.kapp3`.b2c.kapp4;`.b2c.kupsert;`.b2c.kset;`.b2c.kxasc`.b2c.kxsc;`.b2c.kxdesc`.b2c.kxsc;`.b2c.toKS;`.b2c.toKC;`.b2c.toKI;`.b2c.toKJ;`.b2c.toKF;`.b2c.toKH);
.b2c.findIntFns2:{[f] r:f[3],{x where -11=type each x}.q2b.castMap[`castf]exec c[;1] from f[5] where `ca=c[;0]; r,:$[count exec i from f[5] where `fk=c[;0], c[;2]=`.b2c.kwget;`.b2c.kwget`.b2c.kset;()];
  r,:distinct raze {.b2c.if2sym$[`C.toK=n:.q2b.f2t[`n] x;.q2b.f2t[`t][x;2];n]}each exec distinct ty[;2] from f[5] where `a=c[;0], 2<count each ty, not null ty[;2]; .b2c.intused,:.b2c.intfns inter distinct r; f};
.b2c.findIntFns:{[fi] ifn:.b2c.intfns; {.b2c.findIntFns2 .q2b.fmap x}each exec f from fi where `f=t, not n in ifn; {p:count .b2c.intused; {.b2c.findIntFns2 .q2b.fmap value x}each x _ .b2c.intused; p}/[0]};
.b2c.remapIdxConsts:{[o;f] cc:f 5; ii:(); if[count c:cc exec i from cc where `i=c[;0]; ii:raze -1_'(1+c[`c][;2])#'c`st]; ii,:-1+exec i from cc where `s=c[;0], 0<c[;1], not ty[;2];
  ii,:-1+exec i from cc where `a=c[;0], `f=first each ty[;1]; ii:ii where `cc~/:2#'cc[ii;`c]; if[count ii; cc[ii;`c]:`c`D,/:enlist each f[4]cc[ii;`c][;2]]; f[5]:cc; f};
.b2c.mapGlobCnst:{[f] ii:exec i from f[5] where `c=c[;0], c[;1]in`c`f; mm:(!). flip{y,$[count i:where(x y)~/:.q2b.cnsts;first i;[.q2b.cnsts:.q2b.cnsts,enlist x y;-1+count .q2b.cnsts]]}[f 4]each distinct f[5][ii;`c][;2];
    f[5]:update c:{y[2]:x y 2;y}[mm]each c from f[5] where i in ii; f};
.q2b.optMap[`substCGlob`substSel`remapIdxConsts]:(.b2c.substCGlob;.b2c.substSel;.b2c.remapIdxConsts);
/ opts:
/ rec - 0b/1b recursive
/ libname - `myLib, prefix for all funcs and lib
/ libpath - where to put myLib.c and myLib.so
/ goal - `generate - generate C file, `compile - compile it, `load - load and call myLib__init[]
/ globals - global C-level variables
/ weakglobals - global C-level variables that behave like locals
/ cglobals - global vars with C type
/ initOnLoad - list of globals to be inited when the lib is loaded
/ initNow - list of globals that should be inited with the value at compile time
/ O - long, opt level for gcc
/ k - path to k.h
/ debug - 0 - none, 1 - add comments, 2 - print comments
.b2c.compile:{[fns;opts]
  opts:(`rec`libname`libpath`goal`lpath`ipath`debug`O`globals`weakglobals`cglobals`initOnLoad`initNow`k!(0b;`q2b;`:.;`load;();();1;3;();();();();();"..")),opts;
  .b2c.intused:((),fns) inter .b2c.intfns;
  fns:.b2c.intfns,fns; / add predefined fns
  .q2b.cnsts:.q2b.kc,.b2c.ub; / reset consts
  .b2c.wglobals:opts[`weakglobals]; opts[`globals],:`.b2c.wglobals; opts[`initNow],:`.b2c.wglobals;
  opts[`cglobals]:((`.b2c.consts;`p`c.k);(`.b2c.intmap;(`a;20;`c.i);"{0,1,0,0,1,2,4,8,0,0,1,0,8,4,4,0,8,4,4,4}");(`.b2c.libFuncs;`K);(`.b2c.libGlobs;`K);(`.b2c.Kerr;`K;"(K)0")),opts[`cglobals];
  fi:![;();0b;`cn`pure!(((';.b2c.mkcn[opts]);`n;`f);(each;.q2b.pureK;`ty))].b2c.preprocG[opts].b2c.preproc[opts]/[([] n:0#`; t:0#`; f:(); ty:(); att:());fns]; / name (`=anon), type (g, fn), body, c name
  fi:update na:{$[x=`f;count value[y]1;0]}'[t;f] from fi; / num args
  .b2c.q2bOpts[`globals`funcs`fi]:(exec first i by n from fi where n<>`;exec first i by f from fi where t=`f;fi); / compiled globals, funcs
  .b2c.setupF2T[fi];
  opts[`qfns`globals]:(distinct raze@)each flip {($[count x 7;x 7;`$()];x 3)}each {@[.q2b.processTFn[.b2c.q2bOpts;x`f];x`ty;{'sublist[180;y],", func ",40 sublist string $[null x`n;x`f;x`n]}[x]]} each select from fi where t=`f; / transform into instr blocks, extract globals and qfuncs
  opts[`qfns]:distinct `set`show,opts[`qfns];

  .b2c.findIntFns fi;
  .b2c.t2n:.q2b.types[`name]!{$[count y`cname;y`cname;.b2c.mkn[x;y`name]]}[opts]each .q2b.types; / type to its c name
  .b2c.g2n:(!). flip{(x`n;$[10=type x`cn;`$x`cn;x`n])}each select from .q2b.f2t where not null n, not n like "..*"; / c global names
  fi:![fi;((=;(),`f;`t);(in;`n;enlist .b2c.intfns);(not;(in;`n;enlist distinct .b2c.intused)));0b;`$()];
  l:.b2c.addGPref[fi;opts],raze .b2c.compileDecl[fi;opts] each fi;
  l,:raze .b2c.compileFn[fi;opts] each select from fi where t=`f;
  .q2b.cnsts:.q2b.cnsts,exec last each f from fi where t in `g`gl, 2=count each f; / add global consts
  l: l,.b2c.addGPost[fi;opts];
  (n:` sv hsym[opts`libpath],`$string[opts`libname],".c") 0: l;
  if[`generate=opts`goal;:n]; / c file
  .b2c.gcc[opts;n];
  n:`$-2_string n;
  if[`compile=opts`goal;:n]; / lib path
  lini:n 2: (`$string[opts`libname],"__init";1); / library
  : .b2c.libs[n]: lini[];
 };
.b2c.setupF2T:{[fi] pk:.q2b.pureK; fn:{$[10=type x;x;.b2c.mkng y]}; .q2b.f2t:(update cn:fn'[gf;n], idx:0N from .b2c.defF2T),select n,f,t:ty,d:0b,gf:(::),cn,idx:i from fi where not pk each ty};
.b2c.preproc:{[o;fi;n] .b2c.preprocA[o;fi;get n;n]};
.b2c.preprocA:{[o;fi;v;n]
   if[(not`=n)&n in fi`n;:fi]; if[(`=n)&any v~/:fi`f;:fi]; / avoid duplicates
   if[not 100=type v;'"not a func: ",string n];
   fi:.b2c.preprocA[o;;;`]/[fi upsert (n;`f;v;.q2b.getFnTy v;.q2b.extrAttr v);c where{$[100=type x;null .q?x;0b]}each c:.q2b.getc v2:value v]; / functions in consts except .q and internal funcs
   : $[o`rec;.b2c.preproc[o]/[fi;g where{@[{$[100=type x:get x;null .q?x;0b]};x;0b]}each g:.q2b.getg v2 3];fi]; / global functions
  };
.b2c.preprocG:{[o;fi]
  ini:{[o;n] $[n in o`initOnLoad;();n in o`initNow;(`;get n);::]};
  if[count c:(),o`globals; fi,:([] n:c; t:`g; f:ini[o]each c; ty:`K; att:(::))];
  if[count c:(),o`weakglobals; fi,:([] n:c; t:`gl; f:ini[o]each c; ty:`K; att:(::))];
  if[count c:o`cglobals; .q2b.chkTy each c[;1]; fi,:([] n:c[;0]; t:`gc; f:{$[3=count x;x 2;()]}each c; ty:c[;1]; att:(::))];
  :fi;
 };
.b2c.addGPref:{[fi;o]
  ll:string[o`libname];
  l:{"#include ",/:x}[.b2c.include],("#include \"",$[count o`k;o[`k],"/";""],"k.h\"";"";"static inline K kdot(K x,K y) { K res=dot(x,y); r0(x); r0(y); return res;};";"";"#define PE(x) fprintf(stderr,x)";
    "#define QSHOW(x) { K __r=kdot(r1(__q[1]),knk(1,r1(x))); if(__r) r0(__r);}";"#define QSET(x,y) { K __r=kdot(r1(__q[0]),knk(2,ks(x),r1(y))); if(__r) r0(__r);}";"";"extern J llabs(J x);");
  l,:("static K kif(K x);";"static inline K __enlist(K l);";"static K kamend(K ff,K a,K i,K f,K v);";"static K kamend3(K ff,int isG,K* a,K i,K f);";"static K kamend4(K ff,int isG,K* a,K i,K f,K v);";"static K ",ll,"__getLib(K x);";"K ",ll,"__init(K x);";"");
  l,:enlist["static int __ginited=0;"],{"static K* ",(get x),"=(K*)0;"}each`.b2c.Q`.b2c.G`.b2c.LC;
  nn:(distinct raze{(x[8]key[x 8]except x 3),(1_x 9),x[5;`cty][;1]}each value .q2b.fmap)except``K; nn:distinct nn,raze .q2b.castMap`tf`tt;
  qfn:.q2b.crtType; nn,:exec distinct qfn each ty from fi where t=`gc;
  nn:{v:raze exec def from .q2b.types where not ex, name in x; v:v where -11=type each v; distinct x,v}/[nn];
  :l,{"typedef ",.b2c.getCDecl[x`def;.b2c.t2n x`name],";"}each select from .q2b.types where not ex, name in nn;
 };
.b2c.addGPost:{[fi;o]
   ifns:.b2c.intfns; igl:.b2c.intglobs except `.b2c.wglobals;
   f:select from fi where t=`f,n<>`,pure,not n in ifns;
   g:select from fi where t in`g`gl,n<>`,pure,not n in igl;
   ll:string[o`libname];
   l:("";"K kif(K x) { static int tmap[20]={0,1,0,0,1,2,4,8,0,0,1,0,8,4,4,0,8,4,4,4}; J r=0; if((x->t>=0)||(x->t<-19)) { r0(x); return krr(\"type\");}; SW(tmap[-(x->t)]){CS(1,r=x->g)CS(2,r=x->h)CS(4,r=x->i)CS(8,r=x->j)CD:r0(x);return krr(\"type\");}; r0(x); return kj(r); };";"");
   l,:enlist("static inline K __enlist(K l) { if(0==l->n) return l; J t=kK(l)[0]->t; if((t>=0)&&(t!=99)) return l; DO(l->n,if(kK(l)[i]->t!=t) return l;); if(l->n>8) return kdot(r1(__consts[57]),knk(3,l,r1(__consts[1]),r1(__consts[5]))); return kdot(r1(__consts[19]),l);};");
   l,:("static K kamend(K ff,K a,K i,K f,K v){ K res=(K)0, lst=knk(4,a,i,f,v); I r = a->r; if(0==r) a->r-=1; res=dot(ff,lst); if(0==r) {if(a==res) a->r+=1; else kK(lst)[0]=kj(0);}; r0(lst); return res;};"; / hack
     "static K kamend3(K ff,int isG,K* a,K i,K f){if(isG)r1(*a); I r=(*a)->r; K lst=knk(3,(*a),i,f); if(0==r) (*a)->r-=1; K res=dot(ff,lst); if(0==r) {if((*a)==res) (*a)->r+=1; else kK(lst)[0]=kj(0);}; r0(lst); if((!isG)&&(0==res))a[0]=r1(__consts[0]); if(0!=res){if(isG)r0(*a); a[0]=r1(res);}; return res;};";
     "static K kamend4(K ff,int isG,K* a,K i,K f,K v){if(isG)r1(*a); K res=kamend(ff,(*a),i,f,v); if((!isG)&&(0==res))a[0]=r1(__consts[0]); if(0!=res){if(isG)r0(*a); a[0]=r1(res);}; return res;};");
   / consts init
   l,:(enlist "static unsigned char __cnstArr[] = "),"  ",/:{x:x,'((-1+count x)#","),enlist"};";@[x;0;{"{",x}]}","sv/: string (0N 200)#"i"$-8!.q2b.cnsts;
   l,:("static K ",ll,"__cnstInit() {";"  K v = ktn(KG,sizeof(__cnstArr)); DO(v->n,kG(v)[i]=__cnstArr[i]);";
     "  K res=d9(v); r0(v); if((0==res)||(-128==res->t)) { __ginited=0; return res;}; ",.b2c.LC,"=(K*)res->G0;");
   l,:{{"  ",y[`cn],"=",.b2c.LC,"[",string[count[.q2b.cnsts]-x],"];"}'[reverse 1+til count x;x]}select from fi where t in `g`gl, 2=count each f; / initNow
   l,:{"  res=k(0,\"",string[x`n],"\",(K)0); if((0==res)||(-128==res->t)) { __ginited=0; return res;}; ",x[`cn],"=res;"}each select from fi where t in `g`gl, ()~/:f; / initOnLoad
   l,:{"  ",x[`cn],"=r1(",.b2c.LC,"[0]);"}each select from fi where t in `g`gl, (::)~/:f; / init with ()
   l,:("  return (K)1;";" };";"");
   / lib dict init
   l,:("static K ",ll,"__getLib(K x) {";"  K k=(K)0, v=(K)0, k1=(K)0, v1=(K)0;";"  if(0==__ginited) { K res=",ll,"__init((K)0); if((0==res)||(-128==res->t)) return res; r0(res); };";
     "  k=ktn(KS,",string[c],"); v=ktn(0,",string[c:count f],");";"  k1=ktn(KS,",string[c],"); v1=ktn(K",.b2c.P,",",string[c:count g],");");
   l,:{"  kS(k)[",string[y],"]=ss(\"",string[x[y;`n]],"\"); kK(v)[",string[y],"]=r1(",x[y;`cn],"__k);"}[f]each til count f;
   l,:{"  kS(k1)[",string[y],"]=ss(\"",string[x[y;`n]],"\"); k",.b2c.P,"(v1)[",string[y],"]=(",.b2c.P,")&",x[y;`cn],";"}[g]each til count g;
   l,:("  __libFuncs=xD(k,v); __libGlobs=xD(k1,v1);";"  return r1(__libFuncs);";" };";"");
   / lib init
   l,:("";"K ",ll,"__init(K x) {";"  K res=(K)0;";"";"  if(__ginited>0) return ",ll,"__getLib((K)0);";"  __ginited=1; K lst;";"");
   l,:("  res=k(0,\".q",(raze"`",/:string o`qfns),"\",(K)0); if((0==res)||(-128==res->t)) { __ginited=0; return res;}; ",.b2c.Q,"=(K*)res->G0;");
   l,:("  res=k(0,\"",(raze"`",/:string o`globals),",1\",(K)0); if((0==res)||(-128==res->t)) { __ginited=0; return res;}; ",.b2c.G,"=(K*)res->G0;");
   l,:{"  ",x[`cn],"__k=dl(",x[`cn],",",string[x`na],");"}each select from fi where t=`f, pure;
   l,:("  res=",ll,"__cnstInit(); if(!(res==(K)1)) { __ginited=0; return res;};";"";"  return ",ll,"__getLib((K)0);";" };");
   :l;
  };
.b2c.getCDecl:{[t;n] $[-11=type t;$[t in key .b2c.t2n;.b2c.t2n[t]," ",n;string[t]," ",n];`p=f:first t;.b2c.getCDecl[t 1;"* ",n];`a=f;.b2c.getCDecl[t 2;$[" "in n;"(",n,")";n],"[",string["j"$t 1],"]"];
  `s=f;$[t 3;"struct ";"union "],$[0=count t 1;"";t 1]," {",(" "sv .b2c.getCDecl'[value t 2;string key t 2],\:";"),"} ",n;`f=f;.b2c.getCDecl[t 1;" "],n,"(",(","sv .b2c.getCDecl[;""]each 2_t),")";'"cdecl unsupported for type ",.q2b.printT t]};
.b2c.compileDecl:{[fi;o;r] if[r[`t]in`g`gl;:enlist["K ",r[`cn]," = ","(K)0;"]]; $[`gc=r`t;.b2c.compileGC;.b2c.compileFDecl][fi;o;r]};
.b2c.compileGC:{[fi;o;r] enlist $[r[`n]in .b2c.intglobs;"static ";""],.b2c.getCDecl[r`ty;r`cn],$[count r`f;" = ",r`f;""],";"};
.b2c.compileFDecl:{[fi;o;r] a:(null r`n)|r[`n]in .b2c.intfns; p:$[(3=count r`ty)&`c.void~last r`ty;"";","sv .b2c.getCDecl'[2_r`ty;"x",/:string til r`na]]; l:enlist $[a;"static ";""],.b2c.getCDecl[r[`ty]1;""]," ",r[`cn],$[r`pure;"__q";""],"(",p,");";
  if[r`pure; l,:("static K ",r[`cn],"__k=(K)0;"; $[a;"static ";""],"K ",r[`cn],"(",p,") { return ",r[`cn],"__q(",(","sv .b2c.r1 each"x",/:string til r`na),");};")]; l};
.b2c.compileFn:{[fi;o;r] f:.q2b.processTFn[.b2c.q2bOpts;r`f;r`ty]; cc:f 5; r[`stc]:max(cc[`pure]*cc[`v]*0=cc`sn)+{c:x y;0|-1+sum c[`pure]*c[`inl]>0}[f 5]each f[5]`st;
  r[`free]:distinct`$.b2c.mkln[0]each fr where {`p=first .q2b.unwindT x y}[f 8]each fr:where{any`free~/:x}each r`att; if[count f 4;f:.b2c.mapGlobCnst f];
  .b2c.addFnPrefix[r;f],$[2<=o`debug;enlist"  PE(\"",r[`cn],": start\\n\");";()],.b2c.genB1[o;f;r;f 5]/[();til count f 5],.b2c.addFnPostfix[r;f]};
.b2c.addFnPrefix:{[r;v]
  aa:$[.q2b.matchT[`c.void;rt:r[`ty;2]]&1=count v 1;""; ","sv .b2c.getCDecl'[2_r`ty;"_",/:string v 1]];
  cv:"  ",{$[count x;x,";";x]}"; "sv{t:.b2c.t2n[y 1];t," ",string[y 0],$[y[0]in x;"=(",t,")0";""]}[r`free]each {$[count k:k where(not k like "c.do[0-9]")&(k:key x)like"c.*";flip(`$.b2c.mkln[0]each k;x k);()]}[v 8],v 10; / C locals
  :($[ng:(null r`n)|r[`n]in .b2c.intfns;"static ";""],.b2c.getCDecl[r[`ty;1];""],r[`cn],$[r`pure;"__q";""],"(",aa,"){";$[r`stc;"  K __st[",(string r`stc),"]; int __stc=0; ";""],"K __v=(K)1;";cv;
  "  ",raze("K ",/:("_",/:string v 2),\:"=r1(",.b2c.LC,"[0]); "));};
.b2c.addFnPostfix:{[r;v] vv:v[2],v[1]where .q2b.pureK each v[8]v 1; l:("";" __return:"),$[count vv;enlist"  ",raze("r0(",/:("_",/:string vv),\:"); ");()],$[r`stc;enlist"  while(__stc>0) r0(__st[--__stc]); ";()],
  $[count r`free;enlist "  "," "sv{"if(NULL!=(void*)",n,")free(",(n:string x),");"}each r`free;()],
  ($[.q2b.pureK t:v[9]1;"  return __v;";"  if(0==__v){ ",$[any t~/:`c.k`c.unsafe_k;"return __v;";"PE(\"exception in ",r[`cn],"\"); exit(1);"],"}; return ",$[`c.void=r[`ty;1];"";"__res"],";"];" };");l};
.b2c.genB1:{[o;f;r;c;l;i] l:l,$[(g in c`j)&c[i-1;`b]<g:c[i;`b];("";" __l",string[g],":");()]; if[0=c[i;`inl];:l]; l,{$[()~y;x;"P"=y 2;enlist[y],x;(-1_x),enlist last[x],y]}[.b2c.genMap[first c[i;`c]][o;f;r;c;i];
  $[0<d:o`debug;[dv:.b2c.genDbg[o;f;c;1;i];$[2=d;"  PE(\"",(r[`cn],":",string[i],": ",{x[where x in"\"\\"]:"_";x}[dv],"\\n"),"\");";"  // ",dv]];()]]};
.b2c.genKL:{[hasV;e;hasR;stk] enlist "  ",$[hasV;.b2c.pshv;""],"__v=",e,";",$[0<stk;"__stc-=",string[stk],"; ";""],$[hasR;.b2c.krr;""]}; / K line - save __v, check res
.b2c.genCL:{[c;e;stk] enlist "  ",$[null n:first c`cty;"";string[n],"="],e,";",$[0<stk;" __stc-=",string[stk],";";""]};
.b2c.genXL:{[e;stk] enlist "  ",e,$[0<stk;" __stc-=",string[stk],";";""]};
/ k - simple const, c/f - K const, C - c const, q - qfunc
.b2c.genC:{[o;f;r;c;i] c:c i; v:.b2c.genExpC[o;r;c`c]; $[c`pure;.b2c.genKL[c`v;v;0;0];.b2c.genCL[c;v;0]]};
.b2c.genExpC:{[o;r;c] n:$[`q=t:c 1;$[`enlist~c 2;.b2c.LC,"[19]";.b2c.Q,"[",(string o[`qfns]?c 2),"]"]; `k=t;.b2c.LC,"[",string[c 2],"]"; `C=t; :c 2; .b2c.LC,"[",string[c 2],"]"]; .b2c.r1 n};
/ application
.b2c.genExpAF:{[cc;i;a] if[-7=type n:cc[i;`ty]2; if[not null n; if[not(::)~f:.q2b.f2t[n;`gf]; :$[10=type f;f,"(",(","sv a),")";f[cc;i;n;a]]]]]; :(::)}; / for f2t gen
.b2c.genExpA:{[o;f;r;cc;i;stk] c:(ck:cc i)`c; na:.q2b.na c; a:.b2c.genExp[o;f;r;cc]'[ai;sums stk,-1_{?[0<x`inl;`int$x`pure;x`sn]}cc ai:reverse na#ck`st]; if[3=count ty:ck[`ty;1];if[`c.void~ty 2;a:-1_a]]; isP:(-2=cc[ai 0;`j])|any(`c;`k;6)~/:cc[ai;`c];
  isK:$[(`fk=first fk:cc[ai 0;`c])&not[isP]&isG:3=c 1;fk[5]=c 2;0b]; isL:not[isP]&isG&`c`q`enlist~fk; fn:$[isK;.b2c.genExpV[o;fk;0];isL;"__enlist";isG;a 0;.b2c.r1 .b2c.LC,"[",(string 7+(64*2=c 1)+(32*1=c 1)+c 3),"]"];
  if[not (::)~v:.b2c.genExpAF[cc;i;isG _ a]; :v]; isNK:not first[ck[`ty;1]]in .q2b.baseTypes; a:$[isK|isNK;"(";"knk(",string[abs[na]-isG],","],(","sv $[isG;1_a;a]),")"; : $[isK|isNK;fn,;isL;{x,"(",y,")"}fn;{"kdot(",x,",",y,")"}fn] a};
.b2c.genA:{[o;f;r;cc;i] ck:cc i; if[``.s~ck`cty;ck[`cty]:2#`$.b2c.genAName[o;f;r;cc;i+2-`s=first cc[i+1;`c]]]; v:.b2c.genExpA[o;f;r;cc;i;1-ck`v]; $[ck`pure;.b2c.genKL[ck[`v]&0=ck`sn;v;1;ck[`sn]-ck`v];.b2c.genCL[ck;v;ck[`sn]-ck`v]]};
/ l,p,g,gk - always r1(Kval) z,fk - can be __k or __q, gc/lc/pc - always C
.b2c.genV:{[o;f;r;c;i] c:c i; v:.b2c.genExpV[o;c`c;1b]; $[c`pure;.b2c.genKL[c`v;$[g;"kdot(",.b2c.GET,",knk(1,",v,"))";v];g:`g=c[`c;0];0];.b2c.genCL[c;v;0]]};
.b2c.genExpV:{[o;c;isK] $[(t:c 0)in`l`p;.b2c.r1"_",string c 2;`gk=t;.b2c.r1 c 4;`fk=t;$[not c 6;c 4;isK;.b2c.r1 c[4],"__k";c[4],"__q"];t in`gc`lc`pc;.b2c.mkln[`gc=t;c 2];`g=t;.b2c.r1 .b2c.G,"[",(string o[`globals]?c 2),"]";'"genExpV: unexpected ",.Q[`s1]c]};
/ assign atype 0 - res type, 1 - var type, 2 - var is pure
.b2c.genAName:{[o;f;r;cc;i] c:(ck:cc i)`c; n:c 4; if[ck[`ty;2]; :$[2=c 2;.b2c.genExpV[o;(`g;0;n);1];(("";"_")2>c 2),string n]]; n:.b2c.mkln[n in f 3;n]; if[0=c 1; :n]; ix:cc last ck`st;
  $[(`c;`k;0)~c:ix`c;n;.b2c.genIdx[n;ck[`ty;1]] $[`c~c 0;{$[10=type x;`$x;x]}each $[`D=c 1;::;.q2b.cnsts]c 2;.b2c.genIdxV[(o;f;r);cc] each reverse -1_.q2b.na[c]#ix`st]]};
.b2c.genS:{[o;f;r;cc;i] c:(ck:cc i)`c; if[``.skip~ck`cty;:()]; n:.b2c.genAName[o;f;r;cc;i]; na:.q2b.na[c]#ck`st; vn:1-ck`v; v:idx:$[(isG:1<count na)&isC:not ck[`ty;2];();.b2c.genExp[o;f;r;cc;last na;vn]];
  if[isG; c1:cc na 1; v:.b2c.genExp[o;f;r;cc;na 0;$[c1`inl;c1`pure;c1`sn]+vn]]; fn:c 5; isI:not[isC]&isG&not(`c;`k;0)~cc[last na;`c]; stk:ck[`sn]-ck`v; if[not ck`pure; :.b2c.genXL[$[fn;(.q2b.f2t ck[`ty;4])[`gf][cc;i;n;v];n,"=",v],";";stk]]; / all non-K assigns
  pv:$[(not ck`v)|ck`sn;"";.b2c.pshv]; rn:$[isC;"if(",n,")";""],"r0(",n,"); "; c6:$[2=ck`inl;"__v=r1(",.b2c.LC,"[5]);";""]; if[((fn=0)&not[isI]&isC|2<c 2)|0=c 1; :.b2c.genXL[pv,rn,n,"=",v,";",$[2=ck`inl;"__v=r1(",n,"); ";""];stk]]; / cval.kval=kval, loc/par=val, gk=val
  if[(fn=0)&not[isI]&2=c 2; :.b2c.genXL[;stk]$[(not[c 6]|0=ck`sn)&ck`v;"__st[__stc++]=",$[ck`sn;"r1(__v); ";"__v; "];""],"__v = kdot(r1(",.b2c.Q,"[0]),knk(2,",n,",",v,")); ",.b2c.krr, / `glob set val
    "r0(__v); ",$[c 6;c6;ck`sn;.b2c.popv;"__v=",v,";"]];
  / remember the old v if exists, pop idx and val, remember idx if ret val is needed, exec upd, exec idx apply/get if ret val is needed
  res:"  ",pv,"{ K __v1=",idx,"; K __v2=",v,";",$[0<stk;" __stc-=",string[stk],"; ";""],$[(c 6)|not isI;"";" __st[__stc++]=r1(__v1);"]," __v = kamend(__consts[58],",$[3=c 2;"r1(",n,")";n],",__v1,r1(",.b2c.LC,"[",string[39+fn],"]),__v2);};";
  if[2=c 2; res,:.b2c.krr,"r0(__v);"; if[c 6;:enlist res,c6]; if[isI;:enlist res,"__v=kdot(r1(",.b2c.LC,"[58]),knk(2,",n,",__st[--__stc]));",.b2c.krr]; / no val needed & .[`glob;idx]
    :enlist res,"__v = kdot(",.b2c.GET,",knk(1,",n,"));",.b2c.krr]; / get glob
  res,:" if(0==__v){",$[3=c 2;"";n,"=r1(__consts[0]);"],"goto __return;}; ",$[3=c 2;"r0(",n,"); ";""],n,"=__v;"; if[not[isI]|c 6; :enlist res,$[c 6;c6;"r1(__v);"]];
  : enlist res,"__v=kdot(r1(",.b2c.LC,"[58]),knk(2,r1(",n,"),__st[--__stc]));",.b2c.krr; / .[loc;idx]
 };
/ index
.b2c.genIdxV:{c:y z;$[not null f:first c[`cty;0];string f;(f:first t:c[`ty;0]) in`Ki`Kj`Ks;t 1;f=`KC;`$t 1;`c`C~2#c`c;c[`c;2];(a:c[`c;0])in`lc`gc`pc;.b2c.genExpV[::;c`c;0];a=`ca;(.b2c.genExpCa . x,(y;z;0))1;a=`s;.b2c.genAName . x,(y;z);'"idx: unexp"]};
.b2c.genIdx:{[n;t;idx] first{if[0=count j:x 2; :x]; x1:.q2b.unwindT x 1; $[-11=t:type i:j 0;(x[0],$[s;".";"->"],string i;($[s:`s=first x1;x1;.q2b.unwindT last x1]2)i;1_j);(x[0],"[",$[10=t;i;string "j"$i],"]";last x1;1_j)]}/[(n;t;idx)]}; / gen name->field[idx].name
.b2c.genExpI:{[o;f;r;cc;i] ck:cc i; t:first cc[`ty]first a:reverse .q2b.na[ck`c]#ck`st; n:.b2c.genExp[o;f;r;cc;a 0;0]; n:.b2c.genIdx[$[(cc[a 0;`c]0)in .q2b.vc;n;"(",n,")"];t;.b2c.genIdxV[(o;f;r);cc] each 1_a]; $[ck`pure;"kr1(",n,")";n]};
.b2c.genI:{[o;f;r;c;i] ck:c i; ix:.b2c.genExpI[o;f;r;c;i]; $[ck`pure;.b2c.genKL[ck`v;ix;0;0];.b2c.genCL[ck;ix;0]]};
/ cast - (ctype)cval, kval = kcast(c val), kerr = ccast(&cres,c/k val)
.b2c.genExpCa:{[o;f;r;cc;i;stk] ck:cc i; ca:.q2b.castMap ck[`c;1]; v:.b2c.genExp[o;f;r;cc;i-1;stk]; if[ca`inl; if["r1("~3#v; v:-1_3_v]]; a:$[(ca`inl)|ck`pure;(ca;v);(ca;first ck`cty;v)];
  (ca;$[-11=type fn:ca`castf;.b2c.mkn[o;fn],"(",$[2=count a;v;"&",string a 1],",",v,")";(2=count a)&(::)~fn;"(",.b2c.t2n[ca`tt],")",v;fn . a])};
.b2c.genCa:{[o;f;r;c;i] ck:c i; ca:first v:.b2c.genExpCa[o;f;r;c;i;1-ck`v]; $[ca`inl;.b2c.genCL[ck;v 1;0];.b2c.genKL[hv;v 1;1;ck[`sn]-ck`v],\:$[ck`pure;"";"r0(__v); "],$[not[ck`pure]&hv:ck[`v]&0=ck`sn;.b2c.popv;""]]};
/ spec: &cval (*cval) (ctype)K
.b2c.genExpSp:{[o;f;r;c;i;stk] if["r1("~3#v:.b2c.genExp[o;f;r;c;i-1;stk];v:-1_3_v]; $[`getptr=cm:c[i;`c]1;"&",v;`unptr=cm;"(*",v,")";`sizeof=cm;"sizeof(",$[4=count t:c[i;`ty];.b2c.t2n t 2;.b2c.genExp[o;f;r;c;i-1;stk]],")";`c.k=cm;v;'"genExpSp: unexp"]};
.b2c.genSp:{[o;f;r;c;i] v:.b2c.genExpSp[o;f;r;c;i;1-(ck:c i)`v]; .b2c.genCL[ck;v;0]};
/ block instr
.b2c.genB:{[o;f;r;cc;i] ck:cc i; ll:"goto __l",string[ck`j],";"; cv:string first cc[i-1;`cty]; vv:$[ck`v;"";.b2c.popv]; nv:$[ck`v;$[ck`pure;"r0(__v); ";.b2c.pshv];""];
  enlist"  ",$[`e=t:ck[`c;1];$[ck`v;.b2c.pshv;"__v=__st[__stc-1];"]," if(__v->t==-KS) __v=krr(__v->s); else if(__v->t==KC)  __v=krr(sn(kC(__v),__v->n)); else __v=krr(\"stype\"); goto __return;";
  `r=t;$[ck`pure;vv;nv,$[cv~"__res";"";"__res=",cv,"; "]],"goto __return;"; `b=t;:("  ",nv;""); `if=t;$[ck`pure;vv,"__v=kif(__v);",.b2c.krr,"if(0==__v->j) { r0(__v); ",ll,"}; r0(__v);";nv,"if(0==",cv,") ",ll];`j=t;ll;
  `d1=t;[v:(string first ck`cty),"="; $[ck`pure;vv,"__v=kif(__v);",.b2c.krr,cv,"=__v->j; r0(__v);";nv]];`d2=t;"if(0>=",cv,")",ll," ",(cv:string first cc[i-2;`cty]),"-=1;";$[cc[exec first i from cc where b=ck`j;`v];.b2c.popv;""],ll]};
/ stk - how many used K vals
.b2c.genExp:{[o;f;r;cc;i;stk] c:(ck:cc i)`c; $[not null t:first ck`cty;string t;(ck`pure)&2=ck`inl;$[stk;"__st[__stc-",string[stk],"]";"__v"];(2=ck`inl)&`s=t:first c;.b2c.genAName[o;f;r;cc;i];0<ck`inl;'"genExp: unexp";
  `c=t;.b2c.genExpC[o;r;c];t in .q2b.vc;.b2c.genExpV[o;c;1b];`i=t;.b2c.genExpI[o;f;r;cc;i];`ca=t;.b2c.genExpCa[o;f;r;cc;i;stk] 1;`sp=t;.b2c.genExpSp[o;f;r;cc;i;stk];'"genExp: unexp2"]};
.b2c.genMap:`c`a`b`s`ca`sp`i!(.b2c.genC;.b2c.genA;.b2c.genB;.b2c.genS;.b2c.genCa;.b2c.genSp;.b2c.genI);
.b2c.genMap[.q2b.vc]:.b2c.genV;

.b2c.genDbg:{[o;f;cc;tp;i] c:(ck:cc i)`c; $[`b=t:c 0;(`r`e`b`j`if`d1`d2`bj!("return cmd";"raise an exception";"end of statement";"jmp to if end";"if/while check condition";"check that do value is correct";"do condition";"jump back to do/while"))c 1;
  `s=t;.b2c.genDbgS[o;f;cc;tp;i];t in`p`pc;$[tp;"arg ";""],.b2c.genDbgN[o;f;ck];t in`l`lc;$[tp;"local ";""],.b2c.genDbgN[o;f;ck];t in`g`gc;$[tp;"global ";""],string c 2;`fk=t;$[tp;"C func ";""],c 4;
  `gk=t;$[tp;"C global ";""],c 4;t in`a`i;.b2c.genDbgA[o;f;cc;i];`c=t;$[tp;"const ";""],.b2c.genDbgN[o;f;ck];`ca=t;"`",string[ck[`ty;0]],"$<val>";`sp=t;string[c 1]," <val>";`z=t;".z.s";""]};
.b2c.genDbgN:{[o;f;ck] c:ck`c; $[-2=ck`j;"<val>";`c=c 0;$[`k=c 1;.Q[`s1].q2b.kc c 2;`c=c 1;{20 sublist .Q[`s1]x}$[77<count .q2b.cnsts;.q2b.cnsts;f 4] c 2;`q=c 1;string c 2;`C=c 1;last c;`D=c 1;.Q[`s1]c 2"???";`f=c 1;"<anon fn>";"<val>"];not null t:ck[`cty;0]; string t; c[0]in .q2b.vc; string c 2;"<val>"]};
.b2c.genDbgA:{[o;f;cc;i] c:(ck:cc i)`c; na:reverse .q2b.na[c]#ck`st; p:$[`cty in key ck;.b2c.genDbgN[o;f] each cc na;.b2c.genDbg[o;f;cc;0]each na]; fn:$[0=t:c 1;string .q2b.U c 3;1=t:c 1;string .q2b.B c 3;2=t;string .q2b.a c 3;p 0]; if[t=3;p:1_p]; fn,"[",(";"sv p),"]"};
.b2c.genDbgS:{[o;f;cc;tp;i] c:(ck:cc i)`c; p:.b2c.genDbgN[o;f] each cc na:.q2b.na[c]#ck`st; if[0=c 1;p:2#p]; l:(0 1 2 3 4!("param";"local";"global";"cglob";"cweakglob"))c 2; n:string c 4; fn:$[0<c 5;string .q2b.b c 5;""];
  n,$[c 1;"[",p[1],"]";""],fn,((1|c 1)#":"),(p 0),("";$[tp;" - no rval, ",l;""])c 6};
.q2b.calcTErr:{[o;f;c;i;msg] 'sublist[150;msg],", code: ",.b2c.genDbg[o;f;c;0;i]};
