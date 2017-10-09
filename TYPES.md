For convenience all basic types are named after their `k.h` definitions:
* c.i - int
* c.j - long long
* c.f - double
* c.h - short
* c.g - unsigned char
* c.c - char
Pointer types for them will look like:
* c.I - int list
* c.J - long long list
* c.F - double list
* c.H - short list
* c.G - unsigned char list
* c.C - char list (for buffers)
* c.S - char list (for strings)
Pointers to pointers will look like: c.I_p, c.J_p, c.F_p and etc.

c.k - is a type for K objs but only t n and r fields are accessible for security reasons. c.K is its pointer type.

Aliases to base types are also defined: c.long_long c.int c.double c.uchar c.short c.char. Pointers look like c.int_p and etc.

.b2c.it is defined as either c.i for 32bit or c.j for 64bit. c.ij type is an alias for .b2c.it. Use .b2c.it or c.ij for pointer casts, sizes and etc.

Other C types: c.uint (unsigned int), c.void, c.cvoid (const void), c.bool, c.schar (signed char), c.ushort (unsigned short), c.long.

Stdlib defines some common C lib types: c.mode_t, c.size_t, c.pid_t, c.off_t, c.ssize_t, c.uid_t, c.gid_t, c.div_t, c.lldiv_t, c.FILE, c.fpos_t. These types are anonymous, casts are defined to c.i or c.j. Pointer types look like c.off_t_p.

It is easy to declare any C type via `.b2c.defExtType` or `.b2c.defType`. Structs can be declared via `.b2c.defExtStruct` or `.b2c.defStruct`.

lib/xxx.q files may declare other types if the corresponding h files have them.
