.b2c.init:{.q2b.optMap:`singleConstOpt`emptyBlockOpt`idCallOpt`applyOpt`foldConsts`optConsts`calcTypes`simplifyCExpr`calcOpStatus`substCGlob`substSel!(.q2b.opt1;.q2b.opt2;.q2b.opt4;.q2b.opt5;.q2b.opt6;.q2b.opt7;.q2b.calcTypes;.q2b.simplifyCExpr;.q2b.calcOpStatus;.b2c.substCGlob;.b2c.substSel);
  .q2b.fmap:()!(); .q2b.f2t:([] n:0#`; f:(); t:(); d:0#0b; gf:());
  .b2c.q2bOpts:`simpleTypes`opts!(`c`l`p`z`gk`fk`lc`pc`gc;`applyOpt`idCallOpt`emptyBlockOpt`foldConsts`calcTypes`simplifyCExpr`substCGlob`singleConstOpt`optConsts`substSel`emptyBlockOpt`calcOpStatus);
  .b2c.genMap:`c`a`b`s`ca`sp`i!(.b2c.genC;.b2c.genA;.b2c.genB;.b2c.genS;.b2c.genCa;.b2c.genSp;.b2c.genI);
  .b2c.genMap[.q2b.vc]:.b2c.genV;
  .q2b.cnstCast:`c.j`c.i`c.f!(.b2c.cnstF["j";0wj;"";"LL"];.b2c.cnstF["i";0wi;"";""];.b2c.cnstF["f";0wf;"(double)";""]);
  .b2c.a2n:()!`$();
 };

vars:`.q2b.fmap`.q2b.kc`.q2b.U`.q2b.u`.q2b.B`.q2b.b`.q2b.a`.q2b.vc`.q2b.rmap`.q2b.defOpts`.q2b.optMap`.q2b.ktypes`.q2b.constTypes`.q2b.t2kt`.q2b.baseTypes`.q2b.f2t`.q2b.castMap;
vars,:`.q2b.fcMap`.q2b.types`.b2c.intused`.b2c.include`.b2c.if2sym`.b2c.defF2T`.b2c.intfnsMap`.q2b.getc`.q2b.cnstCast`.q2b.cnsts;
vars,:`.b2c.J`.b2c.LC`.b2c.Q`.b2c.G`.b2c.psh`.b2c.pshv`.b2c.popv`.b2c.krr`.b2c.intfns`.b2c.intglobs`.b2c.q2bOpts`.b2c.libs`.b2c.GET`.b2c.genMap`.b2c.g2n`.b2c.t2n`.b2c.ub`.b2c.a2n`.b2c.is32`.b2c.P`.b2c.it;

funcs:`.b2c.compile`.q2b.calcTypes`.q2b.opt1`.q2b.opt2`.q2b.opt4`.q2b.opt5`.q2b.opt6`.q2b.opt7`.q2b.simplifyCExpr`.q2b.calcOpStatus`.b2c.substCGlob`.b2c.substSel`.b2c.genC`.b2c.genA;
funcs,:`.b2c.genB`.b2c.genS`.b2c.genCa`.b2c.genSp`.b2c.genI`.b2c.defExtFn`.b2c.defExtVar`.b2c.defCompCast`.b2c.defCCast`.b2c.defExtStruct`.b2c.defExtType`.b2c.get`.b2c.init`.b2c.cnstF`.b2c.defStruct`.b2c.defUnion`.b2c.defExtUnion;

vexc:`.b2c.g2n`.b2c.t2n`.q2b.optMap`.q2b.fmap`.b2c.q2bOpts`.q2b.f2t`.b2c.genMap`.q2b.cnstCast`.q2b.cnsts`.b2c.a2n;

lname:`q2c;

rename:{ssr[;".q2b.";".q2b2."]ssr[;".b2c.";".b2c2."] x};
renameS:{`$rename string x};
renameF:{value rename string x};

if[not .z.x[0]~(),"c"; system each ("l ../q2b.q";"l ../b2c.q";"l ../std.q"); .b2c.intfnsMap:.b2c.intfns!value each .b2c.intfns; .b2c.get:{value x}; .b2c.mkan:{"_anon",string .b2c.J+:1}];

opts:(funcs; `libname`rec`debug`globals`initNow`goal`O`k!(lname;1b;1;vars;vars except vexc;`compile;0;".."));

.self.run:{
  if[not lib[x][]; '"test failed"];
  do[10; lib[x][]];
  w:.Q.w[];
  do[500; lib[x][]];
  if[1<(m:.Q.w[][`used]-w`used)%500; '"suspected memleak ",string m];
  : 1b;
 };


if[.z.x[0]~(),"c";
  f:`:./q2c 2: (`q2c__init;1); l:f 0; l[`.b2c.init][];
  {(set')[key x;value x]}l[`.b2c.get]`.b2c.intfnsMap;
  .b2c2.init:renameF .b2c.init;
  vars:renameS each vars;
  funcs:renameS each funcs;
  vexc:renameS each vexc;
  lname:`q2c2;
  `:./q2b2.q 0: rename each read0 `:../q2b.q;
  `:./b2c2.q 0: rename each read0 `:../b2c.q;
  `:./std2.q 0: rename each read0 `:../std.q;
  system each ("l q2b2.q";"l b2c2.q";"l std2.q");
  .b2c2.intfnsMap:.b2c2.intfns!value each .b2c2.intfns;
  .b2c2.get:{value x}; .b2c2.mkan:{"_anon",string .b2c.J+:1};
  opts:(funcs; `libname`rec`debug`globals`initNow`goal`O`k!(lname;1b;1;vars;vars except vexc;`compile;0;".."));
  l[`.b2c.compile] . opts; l[`.b2c.compile] . opts
  do[8; l[`.b2c.init][]; l[`.b2c.compile] . opts];
  w:.Q.w[]`used;
  do[20; l[`.b2c.init][]; l[`.b2c.compile] . opts];
  if[3<(-110+m:.Q.w[][`used]-w)%20; -1 "self: suspected memleak ",string m];
  exit 0;
 ];

.b2c.compile . opts;

exit 0;
