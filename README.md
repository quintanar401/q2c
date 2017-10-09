* [Intro](#intro)
* [Purpose](#purpose)
* [Compilers](#compilers)
* [Glossary](#glossary)
* [Stability](#stability)
* [Description](#descrption)
* [Usage](#usage)
* [Examples](#examples)
* [Debug](#debug)
* [C-DSL](#c-dsl)
* [Definition of a function](#definition-of-a-function)
* [Calling a function](#calling-a-function)
* [Types](#types)
* [Variables](#variables)
* [Constants](#constants)
* [Expressions](#expressions)
* [Strings](#strings)
* [Casts from Q](#casts-from-q)
* [Casts to Q](#casts-to-q)
* [Simple C casts](#simple-c-casts)
* [Predefined functions](#predefined-functions)
* [Globals, weak globals and C globals](#globals--weak-globals-and-c-globals)
* [Accessing compiled functions and variables by name](#accessing-compiled-functions-and-variables-by-name)
* [Q-SQL](#q-sql)
* [Memory allocation](#memory-allocation)
* [Exceptions](#exceptions)
* [API](#api)
* [.b2c.compile](-b2c-compile)
* [.b2c.defExtFn - declare an external function](#-b2c-defextfn---declare-an-external-function)
* [.b2c.defExtVar - declare an external variable](#-b2c-defextvar---declare-an-external-variable)
* [.b2c.defExtType - define an external type](#-b2c-defexttype---define-an-external-type)
* [.b2c.defType - define an internal type](#-b2c-deftype---define-an-internal-type)
* [.b2c.defExtStruct, .b2c.defStruct - declare a structure](#-b2c-defextstruct---b2c-defstruct---declare-a-structure)
* [.b2c.defCompCast - composite cast](#-b2c-defcompcast---composite-cast)
* [.b2c.defCCast - C cast](#-b2c-defccast---c-cast)
* [.b2c.defPCast - pointer cast](#-b2c-defpcast---pointer-cast)
* [.b2c.defExtConstFn - get C consts into Q](#-b2c-defextconstfn---get-c-consts-into-q)

# Intro

## Purpose

Compile any Q or C-DSL function or set of functions into a C shared library to be loaded into a Q process. Provide an easy way to create proxy functions to any native C library. Obfuscate Q code.

## Compilers

Currently only gcc 64/32 is tested on Linux. The generated C file though contains nothing extraordinary and it can probably be compiled with only small adjustments on other platforms. Please contribute functions like .b2c.gcc for other compilers.

## Glossary

C-DSL - C like DSL that can be used to code low level C expressions directly in Q. This code can't be executed in Q, it should be compiled into C first but it looks like the ordinary Q code. Any Q expression can be used provided it is well typed.

Pure function - a function that takes and returns only K objects. All Q functions are pure by default. A function can contain C-DSL code and be pure.

## Stability

There should be no memory leaks and SEGFAULTS caused by the library itself. There are tests that ensure that tricky expressions work as expected and also the compiler is a test by itself. It can compile itself and then it can be loaded as a lib into a Q process and compile itself again with no memory leaks or other issues.

## Description

q2c lib can be used to compile any Q or C-DSL function or set of functions and Q global variables into C code and that can be compiled into a shared library to be loaded into a Q process.

Basicaly any set of Q functions can be compiled as is and will work with 95% probability. 5% is due to the fact that Q can't access C functions by name and this can cause some Q-SQL expresions to fail. q2c itself can be fully compiled into C with all its functions and globals and this has required only several adjustments to Q-SQL expressions. Though you can compile any Q code this makes little sense unless you want to obfuscate it. Compiled Q functions will not be faster, if anything they will be slower because q2c is based on k.h `dot` function that has considerable overhead.

The main purpose of this compiler is to facilitate access to the native C libraries. So that a person without knowledge of C could create proxy functions that have no memleaks and SEGFAULTS. For example a proxy to sleep can be created by a single call
```
.b2c.defExtFn[`unistd;`C.sleep;`c.i;`c.i;()];
...
ini:`:./sleep 2: (`sleep__init;1);
lib:ini[];
lib[`.unistd.sleep] 1000;
```
and then `.unistd.sleep` proxy function can be compiled as is and used from a shared library. q2c supports casting from C-structures to Q dictionaries and back, to and from buffers or string, error handling and etc.

You can also use low level C-DSL to speed up critical parts of your program. Lets say you want to merge two sorted vectors:
```
qmerge:{asc x,y}; / Q version. Very short but unfortunately Q can't leverage the fact that the args are sorted, thus this will have ~O(nlog n) time and consume 3x mem.
cmerge:{ c.J.x:`c.J$x; c.J.y:`c.J$y; res:(count[x]+count y)#0; c.J.res:`c.J$res; / Absolutely safe casts and memory alloc of args and the result
  c.j.i:0; c.j.j:0; / define pointers into args
  do[count res; c.res[c.do1]: $[c.i=(`c.k$x)`n; [c.j+:1; c.y c.j-1]; c.j=(`c.k$y)`n; [c.i+:1; c.x c.i-1]; c.x[c.i]<c.y c.j; [c.i+:1; c.x c.i-1]; [c.j+:1; c.y c.j-1]]]; / c code can use any Q expresions
  : res; / return the result, if there is an exception res will be freed because it is a K obj
 };
```

## Usage

C lib can be created and compiled with `.b2c.compile` function. Basically you just provide a list of functions and set the final goal - generate, compile and etc. Also you can declare global vars and how they should be inited, some paths and etc
```
/ these 3 q libs are always required
\l q2b.q
\l b2c.q
\l std.q
.b2c.compile[`fn1`fn2;`libname`rec`goal!(`mylib;1b;`compile)]
```
`mylib.so` will be created. `rec 1b` can be used to compile all global functions that are called from compiled functions (including .Q functions but not .q). Now you can load `mylib.so` and init it:
```
ini:`:./mylib 2: (`mylib__init;1); / There is always libname__init function that must be called to initialize the lib
lib:ini[]; / init will return a dictionary like `fn1`fn2!(code;code) with the compiled functions.
lib[`fn1][arg]; / you can call them now
```

lib/xxx.q files provide FFI to some C libraries (unistd, semaphore and etc). You may load them after std.q (as you would have done in C), they add themselves to `.b2c.include` list automatically.

## Examples

Examples dir contains examples based on C libraries. Tests dir contains examples of C-DSL. Lib dir contains examples of how to define FFI proxies via `.b2c.defExtFn`.

## Debug

There is an option `debug` for `.b2c.compile`. If it is set to 1 then comments with Q code will be added to each C line. If it is set to 2 then these comments will be printed to stderr.

Also there are predefined C macroses:
* PE("string") - print something to stderr.
* QSHOW(x) - where x is a Q variable, constant and etc. Calls `show` fn for this value.
* QSET("name",y) - where y is a Q value. Save this value to \`name global.

If you free some Q value by mistake this will eventually lead to a SEGFAULT. This SEGFAULT is likely to happen not far from the place of the mistake, you can locate it with debug=2 and then add QSHOW calls to each line. QSHOW consumes a lot of K objects and is very likely to cause SEGFAULT just after the line with the mistake.

# C-DSL

C-DSL is strictly typed, you can use any Q expressions provided they are well typed. Transition between Q and C-DSL is realized through casts and `C.toK` set of functions. C-DSL is only a subset of C and it gets compiled to something more like LLVM IR assembler than C. You should not use it for complicated things but it can be extremly useful when you pass values between Q and C because it automatically checks types, supports Q exceptions, creates copies of C arrays, transforms structs to dicts and back, controls correct types and etc.

C-DSL and Q can be freely intermixed even in one expression, there will be no leaks of K objects (if you do not mess with them) and they will not be freed prematurely.

### Definition of a function

If a function is pure do nothing. If a function is non-pure its first expression must be a string of the form:
```
c)`res_type`arg1_type`arg2_type...
```
If you remove the first two chars and apply value you should get a sym list of valid c types. Examples:
```
f1:{"c)`c.i`c.i"; `c.i$0i}; / int->int function
f2:{"c)`c.void`c.void";}; / void f2(); function with no args and res.
f3:{"c)`K`K`K";}; / pure function with two args. You could have omitted the definition.
f4:{"c)`K`K`c.j";}; / mixed args function
```
All type names must be symbols. Define your own type first if needed.
Try to always use K as the return type otherwise a K exception will cause the program to exit.

Note that \`.. is supported for the external C functions with variable number of args but it can't be used with the compiled functions.

C function declarations can be overloaded (see C.toK for example) but not the compiled functions, you'll have to insert them into .q2b.f2t table manually (again see C.toK in std.q as an example). If you overload some function that has a Q version you must declare it last with the type \`K (not like \`K\`K\`K), see `not` as an example.

Anonymous functions can be non-pure but the only thing you can do with them is to call them right away:
```
{do[10;{"c)`c.void`c.j"; -1 string C.toK x;}c.do1]}[] / it is much easier to use Q funcs + C.toK than to call printf and etc
```

### Calling a function

Pure functions can be called as ordinary Q functions. Non-pure have these restrictions: number of args must match the definition, types must match the definition, function can't be saved into a variable.
```
f[1;2] / if it is `c.j`c.j`c.j
f[c.a+1;c.b] / variables and expresions can be used as args if they have the right type
f[] / functions with 0 arguments can be called in this way
.z.s[1] / recursive call
c.f:(&)f; / you can't save f in a variable but you can save a pointer to it. c.f must have type like c.fn_p where c.fn type matches f definition.
c.f[2;3] / c.f then can be called as f
```

### Types

C type names have this structure: `c.typename`. For convenience `c.typename_p` pointer type is created for every `c.typename`. C types can be:
```
() - anonymous type defined in some external *.h file.
`type - typename of an existing type.
(`p;type) - pointer to a type
(`a;length;type) - array[length] of a type
(`s;"name";`field1`field2`...!(type1;type2;...);structOrUnion) - structure/union. You don't have to list all fields if it is an external structure.
(`f;res type;arg1 type;...) - function
```
To define you own type call `.b2c.defType`, to define an external type call `.b2c.defExtType` and to define an internal/external structure/union call `.b2c.defStruct`, `.b2c.defExtStruct`, `.b2c.defUnion`, `.b2c.defExtUnion`:
```
.b2c.defType[`c.myarray;(`a;10;`c.i)]; / int arr[10];
.b2c.defExtType[`c.pid_t;()];  / we do not know what is pid_t
.b2c.defExtType[`c.size_t;`c.i]; /  alias size_t to c.i
.b2c.defExtStruct[`c.div_t;`quot`rem!`c.i`c.i;`quot`rem!`c.i`c.i;`quot`rem!`c.i`c.i]; / def struct requires: typename, struct def, cast map from K, cast map to K. see defStruct help for more info
```
When you use `defExtType` name (without c.) should be exactly the C type name. Structures have their own rules, see help on `defStruct`.

There are many predefined types like c.i, c.j, c.f, c.I, c.schar and etc. See the full list in TYPES.md

.b2c.it is defined as either c.i for 32bit or c.j for 64bit. c.ij type is an alias for .b2c.it.

When you define a type c.type_p pointer type will be created automatically and also casts from this pointer to c.ij, .b2c.it, c.void_p types.

### Variables

Parameter's types are deduced from the function definition. There are no restrictions on their names.
Pure locals can have ordinary names. Non-pure locals must be first referenced as `c.typename.localname` and then you can use them as `c.localname`. This binds `c.typename` to `c.localname` local.
External globals and functions must be defined via `.b2c.defExtVar` or `.b2c.defExtFn`. It is recomended to add `C.` in front of them to make them visible in the code (C. will be automatically removed).
User pure and non-pure globals can be defined in `.b2c.compile` params, they can have any name but add `C.` prefix to c globals for consistency.
```
c.i.var:10i; c.i+:1i; / this is how you create and use a C locals.
C.sleep[1000i]; / External function has C. prefix
```
There are special local variables - c.do1, c.do2, ... They are implicitly created in `do` expression and have `c.j` type.
```
c.j.sum:0; do[N; c.sum+:c.J.lst c.do1]; / this is how c.doX can be used in a cycle.
```

### Constants

You can use Q constants in C-DSL expressions:
```
c.i.a+10i   / int, long, double consts can be used in exps that require int, long or double.
```
Some constants can be casted at compile time:
```
`c.i$100; / long into int. and all other combinations for c.i, c.j and c.f
C.puts `c.S$"string"; / string can be casted into a C string const.
```
If q2c complains about an incorrect type apply a cast for the correct type
```
f[`c.i$10i;`c.h$10h]
```
Complex constants like dictionaries and lists can be casted only during the execution of the program.

### Expressions

All Q expressions are allowed if they are well typed. You can also mix Q and C-DSL without any restrictions (Q expressions all have type \`K).
```
c.a:10; / assigments - type of a value and a variable must be the same
c.J.a[10]:10; / index assigns
c.strct["field"]:10; / or c.strct[`field]:10;,  structures
cfunc[1;2]; / func calls
c.struct.a[`field] or c.struct_p.a["field"]; / indexing into structs. Struct field names must be sym or string consts. You can index structs or pointers to them.
c.I.a[10] / indexing into arrays. Array indecies must have c.i or c.j type.
c.struct_buf.a[`buff;c.a`index]; / complex indexing. Limitation - index path can't contain K type.
if[cexpr; ]; / cexpr type must be c.bool, c.i or c.j
while[cexpr; ]; / cexpr type must be c.bool, c.i or c.j
$[cexpr;br1;br2]; / cexpr type must be c.bool, c.i or c.j. $ can have more than 1 condition. All branches must have the same type.
do[cexpr;..]; / cexpr type must be c.i or c.j. Each do has a special var c.do1, c.do2 and etc where 1,2.. is the do level like in do[a;c.do1 ... do[b;c.do2+c.do1]]
c.j.a+10; / primitive ops: + - * %
c.j.a+:1; / increment and decrement, you can use index into the var
C.toK c.j.a; / casts to K objects
c.j.a + `c.j$var; / casts from K objects
c.j.a + `c.j$c.i.b; / simple C type casts
(&)c.i.a; / or where[c.i.a], take a pointer
(*)c.I.a; / or first[c.I.a], dereference a pointer
count `c.type; / sizeof type
not c.bool.a; / logical not
c.bool.a | & ^  c.bool.b / logical or and and xor
not c.i.a; / bitwise not
c.i.a | & ^ c.i.b / bitwise or, and and xor
c.i.a > = < >= <= <> c.i.b  / compare ops, the result has type c.bool
abs c.i.a; / abs
neg c.i.b; / negation
```
There is no concept of lvalue in Q thus you can't assign to an expression. In such case use indexing:
```
(*a)[10]=20; / not possible in Q
a[0;10]:20; / use 0 idx instead
```

### Strings

```
C.print `c.S$"string"; / to create a C-level string const
C.read[`c.C$var;10]; / if you need a char buff use `c.C cast, var sould be a string
C.print `c.S$var;  / if you need a string ending with 0 use `c.S cast. It can be applied to strings or syms and checks strings for 0 at the end.
C.toK c.S.var; / create a K string from a C string. Copy is created.
C.toK[c.C.var;10]; / create a K string from a buffer.
```

### Casts from Q

Casts from Q are done via the usual Q cast function:
```
`c.typename$var or `c.typename$exp or `c.typename$const
```
There are several predefined casts from int, long, float, int vector and etc. Simple constants can be casted at the compile time:
```
`c.i$100;
`c.j$100i;
`c.f$100;
`c.S$"string";
```
Types are checked during the cast and if they are incorrect an exception is raised.
```
var:1 2 3; `c.i$var; / exception
```
There is one important restriction for the vector casts - it is allowed only if there is more than 1 reference to the vector. This is done to avoid the potential memleaks and SEGFAULTS:
```
var:1 2 3; `c.I$var; / ok
`c.I$var+1; / exception - there could be a SEGFAULT because var+1 is freed after the cast.
```
Define struct function can create a cast from Q to a C struct. It can be used like this:
```
.b2c.defStruct[`c.strct;`a`b!`c.j`c.j;`a`b!`c.j`c.j;`a`b!`c.j`c.j];
C.somefn (&)`c.strct$`a`b!1 2; / cast to an anonymous struct defined on the stack and pass a pointer to a function
c.strct_p.v:(&)`c.strct$`a`b!1 2; / or save a pointer - not possible to cast by a pointer in this way
c.strct_p.v:`c.strct_p$C.malloc count`c.strct; .b2c.K2strct_cast[c.v;`a`b!1 2]; / you can call the cast fn explicitly
C.toK c.strct_p.v; / creating a dict from a struct is much easier - by a pointer
C.toK c.strct.v; / or directly, it is the same C.toK call
```
Basic K obj properties can be accessed via `c.k` cast
```
(`c.k$val)`t / type
(`c.k$val)`r / refcount
(`c.k$val)`n / length
```
vector properties can't be accessed via `c.k`, use the vector casts instead (unsafe cast is intentionally undocumented!). List of predefined casts:
```
c.i - int, c.j - long, c.I - int vector, c.J - long vector (also will work on all types based on int and long)
c.f - double, c.h - short, c.F - double vector, c.H - short vector
c.S - string. the source should be either a) string const b) string ending with \000 c) symbol
c.C - char buff (a string with no \000 at the end) or a byte list
c.k - to access basic K obj fields

`c.I$kval, `c.f$kval and etc
```

### Casts to Q

Casts to Q are done via C.toK* functions
```
C.toK c.i.var / for basic types and structs
C.toKp c.j.var / for types based on simpler types like timestamp
```
Also all `c.o` functions are available
```
C.ki c.i.var
```
C.toK can be applied to
```
c.k, c.i, c.f, c.j, c.h, c.long (it is C long type not c.j which is long long), c.uint, c.bool
/ all vector functions will create a copy of the argument
c.I, c.J, c.F, c.H, c.S, c.C as C.toK[c.C.var;length]
```
C.toKx can be used with all atom types except guid where x is the type name.
```
C.toKi c.i.var
C.toKp c.j.var
```
DefStruct function can create a `C.toK` overload for a struct/union, it will accept either the struct or a pointer to it
```
C.toK c.struct_a.a
```
it will return a dictionary with fields.

### Simple C casts

There are many casts between C types see them all in CASTS.md. They do nothing, just set a new type to a var.
```
`c.j$c.i.var
```
For all new types several casts are created automatically - cast to/from c.j for pointers, cast to/from c.void_p for pointers. c.j cast can be used to safely pass pointers from/to Q. void cast can be used to switch between any 2 pointer types.

### Predefined functions

All `c.o` functions are available as
```
C.kj c.j.var
```
You can use `knk` to create vectors (enlist is better)
```
C.knk[a;b;c] / knk: (K;K;...)->K. knk DOESN'T check if all args are of the same type unlike enlist
```
`dot` can be used to call Q funcs directly
```
C.dot[value;enlist a] / (K;K) -> K
```
`k` can be used to call Q via a handler
```
C.k[c.i.var;`c.S$"{x*2}";10]
```
Most of `stdlib.h` and `stdio.h` functions are predeclared, see `std` example.

There are declarations for some other libs, see lib/xxx.q files.

### Globals, weak globals and C globals

You can compile not only functions but globals as well. There is an issue with the compiled globals though - it is not possible to update them in place. Each update will create a copy of the global. Thus if you're using upsert for example each time you update a table it will be reallocated and this is extremly inefficient.

To mitigate this problem there are weak globals. They are just like globals but they can be updated efficiently. Unfortunately at the same time if ANY exception happens during the update the value of the weak global will be lost and substituted with (). There is no way around atm, to make the update efficient Q must think there is only 1 reference to the value and if there is an exception this reference is lost.

Another way - do not use compiled globals, Q globals will be ok but much slower.

Also you can declare C globals, these globals will be accessible only to compiled functions of course and Q functions can't be used with them.


### Accessing compiled functions and variables by name

Generally you can't access compiled vars/funcs by name but there is some logic in the compiler that allows you to do it in some cases and only in compiled functions:
* value symVal, if symVal is a name of some compiled func/global its value will be returned (note that if you define the same var in Q it will be ignored)
* cls xasc symVal or cls xdesc symVal - xasc/xdesc can sort compiled vars by name.
* symVal upsert val - upsert supports symbolic names but refer to the globals section to see the drawbacks.
* cols, meta, key, keys - all these functions can access compiled vars by name.
* Functional amend - @[symName;a2;a3], @[symName;a2;a3;a4], .[symName;a2;a3], .[symName;a2;a3;a4]. Again see the globals section to understand the associated problems.

All functions must be called exactly as shown above. Something like `value each lst` will not work (but `{value x}each lst` is ok).

If you need to access the compiled vars from Q just compile a function like {value x}.

### Q-SQL

Q-SQL can't access compiled functions and variables by name thus you either should use the functional form of select/update and ensure you do not reference compiled names via symbols or you should save all compiled vars/funcs in local variables first and use locals in your select/update.

There are no other restrictions. It is ok to compile any Q-SQL provided it doesn't try to resolve C names (in this case you will get 'name error).

### Memory allocation

Malloc and etc can be used as external C functions but try never to use them. All allocations can be done via K vectors but you need to ensure that they are saved to some variables until they are no longer needed. K locals in a function will be automatically deleted on any exception/exit from a function thus they can play a role of a smart pointer.

If you explicitly alloc something it may leak if a K exception occurs. Use this:
```
{...;"attr)enlist[`c.var]!enlist`free";...}
```
as some kind of a smart pointer to ensure that `free` is called at the end of the function if c.var is not null.

### Exceptions

You can raise an exception in all functions as usual but if a function doesn't have K return type `exit` will be called. Thus try always to return a K object.

# API

### .b2c.compile

```
.b2c.compile[`fn1`.ns.fn2;`libname`rec`goal!(`myLib;1b;`compile)]
```

Use this funciton to generate and compile your library. Args:
* Function list, symbols.
* options, dictionary.

Options:
* libname, symbol. The library name. All C functions will look like `libnamefn`.
* libpath, symbol. Where to put myLib.c and myLib.so, the current dir by default.
* rec, bool. Recursively compile all functions that are used in the compiled functions (this doesn't affect anonymous functions, they are always compiled).
* goal, symbol. Values: generate - generate a C file, compile - generate and compile, load - generate, compile, load into Q process and call init.
* globals, symbol list. Globals to be compiled.
* weakglobals, symbol list. Weakglobals to be compiled. See the globals section for more details.
* cglobals, list of items (\`cname;\`c.type[;"initial value"]). C globals to be added to the library. See `.b2c.compile` as an example.
* initOnLoad, symbol list. List of globals to be inited when the lib is loaded, for each global the following will be executed: globname: get\`globname.
* initNow, symbol list. List of globals that should be inited with their value at the compile time.
* k, string. Path to k.h file.
* O, long. Optimization level for gcc.
* debug, long. Debug level: 0 - none, 1 - comments, 2 - print every line executed.

By default all Q globals will be inited with ().

The function returns either a path (generate or compile) or a dictionary with the compiled functions (load).

### .b2c.defExtFn - declare an external function

```
.b2c.defExtFn[`std;`C.abort;`c.void;`c.void;()];
```

This function can be used to declare external C functions and create Q proxies for them. Args:
* lib - symbol, lib name. The name of the corresponding h file can be used.
* fn name - symbol, function name. I recommend to add `C.` prefix to all functions to avoid name clashes. The name must be the same as C name.
* return value definition - see more info below.
* args definition - see more info below.
* options. There is only one option -  (enlist\`nogen)!(),1b - which means do not generate a Q proxy function. Only C prototype will be added.

Return and each arg definition have this format:
```
(typename list or atom [;opts])
```
Where typenames are valid C types. All arguments are either in or out (return value is out by default).  Typename list sets what casts must be applied to an arg to get a C value from a K value (in arg) or from a C value to a K value (out arg). For out args you may omit the last cast if it is `C.toK`. Usually the typename expression can be just an atom like `c.i`. More complicated casts are requred only for unusual types.

Opts are:
* \`in - in argument, all args are in by default. In the proxy fn corresponds to: \`c.t2$\`c.t1$xN, where N is the position number of this arg.
* \`out - output argument. It will be passed in as &cvar (by reference) and the returned value will be casted to a K value. As it is passed by reference in the arg definition you should use the main type name not a pointer to it. There may be several out params. In proxy fn: C.toK \`c.t$c.var.
* \`in_out - like in. The input Q var is returned. This Q var can be used as a buffer for a C fn.
* \`retVal - similar to out but the variable will passed in as is without taking its address. Return value is a retVal by default but it loses this status if any retVal or out arg exists (you need to mark it explicitly with retVal in this case).
* \`notRV - not a retVal. Can be used to supress the return value.
* (\`const;"str") - str is some Q/C-DSL expression. Can be used to pass in consts. In the proxy fn - \`c.t2$\`c.t1$str.
* (\`length;N) - length of some other argument will be passed in, useful for buffers. In the proxy fn - \`c.t2$\`c.t1$count xN, where xN is some other arg.
* (\`expr;"str") - str is some Q/C-DSL expression. Can be used to calculate the arg value from other args. In the proxy fn - \`c.t2$\`c.t1$str [xN], xN is the arg name in this position if available.
* \`notarg - to be used with \`expr, means the value will be calculated from other args/consts.
* (\`chkLen;N) - checks that the input arg length is at least N. In the proxy fn - if[N>count xM;'exc].
* (\`chkLenEq;N) - checks that the input arg length is exactly N. In the proxy fn - if[N<>count xM;'exc].
* (\`chk0 [;optCastsToRes]) - return value check. Raise an exception if the result is 0, it can be optionally casted to `=` friendly type first. In the proxy fn - if[0=\`c.t$res; 'exc].
* (\`chk1 [;optCastsToRes]) - return value check. Raise an exception if the result is -1, it can be optionally casted to `=` friendly type first. In the proxy fn - if[-1=\`c.t$res; 'exc].
* (\`chkNot0 [;optCastsToRes]) - return value check. Raise an exception if the result is not 0, it can be optionally casted to `=` friendly type first. In the proxy fn - if[0<>\`c.t$res; 'exc].
* (\`chkExp;"exp" [;optCastsToRes]) - return value check. Raise an exception if the result is equal to exp, it can be optionally casted to `=` friendly type first. In the proxy fn - if[exp=\`c.t$res; 'exc].
* \`free - add free attr to a pointer var - out or retVal. It will be automatically freed (via free function) if it is not NULL.

Examples:
```
.b2c.defExtFn[`std;`C.calloc;`c.void_p;`c.size_t`c.size_t;enlist[`nogen]!(),1b]; / do not generate a proxy
.b2c.defExtFn[`std;`C.div;`c.div_t_p`free;`c.i`c.i;()]; / free the returned value
.b2c.defExtFn[`std;`C.erand48;`c.f;enlist(`c.H`c.ushort_p;enlist(`chkLenEq;3));()]; / check the input arg length
.b2c.defExtFn[`std;`C.seed48;enlist`c.ushort_p`c.j;enlist(`c.H`c.ushort_p;enlist(`chkLenEq;3));()]; / retval and arg have more than 1 cast because ushort_p is not one of the basic types
.b2c.defExtFn[`std;`C.initstate;(`c.S;((`chk0;`c.j);`notRV));(`c.uint;`c.S;(`c.size_t;enlist(`length;2)));()]; / check the 3d arg's length, check the return val is not 0, cast it first, do not return it
.b2c.defExtFn[`std;`C.ctermid;(`c.S;enlist(`chk0;`c.j));enlist(`c.S;((`expr;"`c.j$0");`notarg));()]; / use const expression for the arg
```
More examples can de found in std and other include files.

### .b2c.defExtVar - declare an external variable

Internal variables must be created via .b2c.compile.

Args:
* Varname - symbol. It is recomended to add `C.` prefix. You may declare macroses and defines via this function too. It only makes them visible to the b2c compiler.
* Type - symbol.
Examples:
```
.b2c.defExtVar[`C.NULL;`c.void_p];
.b2c.defExtVar[`C.errno;`c.i];
```

### .b2c.defExtType - define an external type

Ensure the correct h file is added to `.b2c.include` list.

Args:
* Typename - symbol like `c.ctypename`.
* Definition - type definition, see type section.

Examples:
```
.b2c.defExtType[`c.string;`c.S]; / alias
.b2c.defExtType[`c.FILE;()]; / anonymous type
.b2c.defExtType[`c.sometype;(`p;`c.sometype2)]; / pointer
```

### .b2c.defType - define an internal type

This type will declared via a `typedef` at the start of the generated C file.

Args:
* Typename - symbol like `c.ctypename`.
* Definition - type definition, see type section.

Examples:
```
.b2c.defType[`c.cmp_func;`f`c.i`c.void_p`c.void_p]; / function
```

### .b2c.defExtStruct, .b2c.defStruct - declare a structure

You don't have to list all fields for an external structure if this is not required by your task. Def struct can create a cast from a Q dictionary to the C structure and create a `C.toK` overload to convert the C structure to Q dict.

Args:
* Name - symbol. Either `c.cname` if `cname` can be used in a C program and `name` if it requires `struct` in front of it. In the second case the C-DSL name will be `c.s_name`. For internal structures use `c.cname` form.
* Definition - dictionary. A map from field names to their types.
* Q to C cast - dictionary or (). Cast from a Q dictionary to the C struct. You may define the cast only for a subset of fields from the definition. The cast can be done like this: \`c.name$qvar.
* C to Q cast - dictionary or (). Cast from the C struct to a Q dict. You may define the cast only for a subset of fields from the definition. The cast can be done like this: C.toK c.strct.var.

Examples:
```
{.b2c.defExtStruct[`c.lldiv_t;x;x;x]}`quot`rem!`c.j`c.j; / all 3 dict args are the same
{.b2c.defExtStruct[`flock;x;x:`l_type`l_whence`l_start`l_len`l_pid!`c.h`c.h`c.off_t`c.off_t`c.pid_t;`l_type`l_whence`l_start`l_len`l_pid!`c.h`c.h`c.j`c.j`c.i]}[]; / def and c cast are the same (as usual), Q cast is more tricky
`c.s_name$KDict or `c.name$KDict - cast a K value to a struct (anonymous stack variable), add (&) to take a pointer to it.
.b2c.K2name_cast[(&)c.name.v;KDict]; - cast into some variable using the cast fn explicitly, c.name is a struct type
.b2c.K2name_cast[(&)c.aname.v[c.i];KDict]; - into an array of structs
C.toK c.name.v or C.toK c.name_p.v - cast back from a struct to a dict
```

### .b2c.defCompCast - composite cast

It can be used to bind together a cast from Q like c.i and a simple C cast to the required type thus creating a direct cast from Q to some C type.

Example:
```
.b2c.defCompCast `K`c.i`c.uint; / there shoud be at least three types, each pair must be a valid cast. Now you can do `c.uint$QVal
```

### .b2c.defCCast - C cast

Simple C cast like `(sometype)varOfAnotherType`.

Example:
```
.b2c.defCCast `c.schar`c.i; / (int)signedCharVal, there should be 2 C type names, you must ensure yourself that this cast is valid
```

### .b2c.defPCast - pointer cast

This function declares 4 casts for the pointer to the provided type - to and from c.j (useful if you want to pass a pointer to Q or to compare two pointers) and to and from `c.void_p` - pointer to void.

Examples:
```
.b2c.defPCast `c.ushort; / c.ushort_p vs c.j and c.void_p
```

### .b2c.defExtConstFn - get C consts into Q

This function will create a function .xxx.getConsts that if compiled and called will return a map from C vars to their values. It is useful if you need to access C flags for example. You need to add it to your compile list yourself.

Args:
* Lib name - symbol, h lib name for example.
* C vars - sym list, flags defined in this h lib for example.

Example:
```
.b2c.defExtConstFn[`fcntl;`C.F_GETFD`C.F_SETFD`C.F_GETFL]; / C. will be removed in the returned dict
```
