\l ../q2b.q
\l ../b2c.q
\l ../std.q

/ bad fn decl
.e.badf1:{"c)`K`c.i`c.i";};
.e.badf2:{[x;y;z]"c)`K`c.i`c.i";};
.e.badf3:{[x;y]"c)`K`c.i`c.ii";};
.e.badf4:{[x;y]"c)(`K;1;2)";};
.e.badf5:{[x;y]"c)`K`K`..";};

/ bad attr
.e.badattr:{"attr)1"};

/ extra c.do
.e.baddo1:{c.i.i+c.do1;};
.e.baddo2:{do[c.i.i+c.do2];};

/ type err
.e.badvty1:{c.a+c.j.b;};
.e.badvty2:{c.i.a+c.j.a;};
.e.badvty3:{do[1;c.i.do1+c.j.a];};

/ fn calls
.e.badfc1:{aaa[c.i.i];};
.e.badfc2:{aaa[bbbb;c.i.i];};
.e.badfc3:{{"c)`c.i`c.i"; c.i.i}aaaa; };
.e.badfc4:{{"c)`c.i`c.i"; c.i.i}c.j.a; };
.e.badfc5:{{[x;y]"c)`c.i`c.i`c.i"; c.i.i}c.i.a; };
.e.badfc6:{{[x;y]"c)`c.i`c.i`c.i"; c.i.i}[c.i.a;c.i.a;c.i.a]; };
.e.badfc7:{{"c)`c.i`c.void"; c.i.i}c.j.a; };
.e.badfc8:{{"c)`c.void`c.void"; c.i.i}[]; };
.e.badfc9:{c.i.i+{"c)`c.void`c.void"; c.i.i;}[]; };
.e.badfc10:{a+:c.i.i;};
.e.badfc11:{a[10]+:c.i.i;};
.e.badfc12:{c.i.i+:a;};
.e.badfc13:{c.I.i[10]+:a;};

/ bad idx
.b2c.defExtType[`c.idxtst;(`s;"tst";`a`b!(`c.i;`K))];
.e.badidx1:{a[c.i.i]};
.e.badidx2:{c.i.i[c.i.i];};
.e.badidx3:{c.I.i[`f];};
.e.badidx4:{c.I.i[10;20];};
.e.badidx5:{c.I.i[10;`f];};
.e.badidx6:{c.k.k["xxx"];};
.e.badidx7:{c.K.k[c.i.i;"xxx"];};
.e.badidx8:{c.idxtst_p.s[0;`b;20];};

/ bad ext pure K
.e.badext1:{C.xT[a;b];};
.e.badext2:{C.xD[a];};

/ cast
.e.badcast1:{`c.i$c.k.k;};

/ spec *
.e.badunp:{(*)c.i.i;};

/ lists
.e.badlst1:{enlist c.i.i;};
.e.badlst2:{(10;c.i.i);};

/ assign
.e.bada1:{ c.i.i:c.j.j; };
.e.bada2:{ c.I.i[10]:c.j.j; };
.e.bada3:{ c.k.i[`t]:c.j.j; };
.e.bada4:{ c.k.i[0;`t]:c.j.j; };
.e.bada5:{ c.k.i[`rr]:c.j.j; };

/ ret type
.e.badrt1:{"c)`K`K"; c.i.i};
.e.badrt2:{"c)`c.j`K"; 10};
.e.badrt3:{"c)`c.j`K"; if[1; :c.i.i]; c.j.j};

/ exep type
.e.badex:{'c.i.i};

/ cond type
.e.badcond1:{if[c.k.k;1];};
.e.badcond2:{$[1;1;c.k.k;1;1];};
.e.badcond3:{while[c.k.k;1];};
.e.badcond4:{do[c.k.k;1];};

/ branch
.e.badbr1:{$[1;1;c.j.j];};
.e.badbr2:{$[1;c.j.j;1];};
.e.badbr3:{$[1;c.j.j;c.i.i];};

/ &
.e.badgetref:{(&)c.i.i+c.i;};

.b2c.defType[`c.badf;`f`c.j`c.j];
.ee.badf1:{"c)`c.j`c.i"; `c.j$0};
.ee.badf2:{"c)`c.i`c.j"; `c.j$0};
.e.badfvar1:{c.badf_p.f:(&).ee.badf1;};
.e.badfvar2:{c.badf_p.f:(&).ee.badf2;};

.ee.run:{.q2b.fmap:()!(); .b2c.compile[` sv``e,x;`libname`rec`goal!(`my;1b;`generate)]; 1b};
-1 "Error tests";
{$[@[.ee.run;x;0b];-1"\nERROR: ",string x;1 "."]}each 1_key .e;
-1 "";
exit 0;
