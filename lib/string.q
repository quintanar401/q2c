.b2c.include,:enlist"<string.h>";

.b2c.defExtFn[`string;`C.strerror;`c.S;`c.i;()]; / char *strerror(int errnum);
.b2c.defExtFn[`string;`C.strerror_l;`c.S;`c.i`c.locale_t;()]; / char *strerror_l(int errnum, locale_t locale);
.b2c.defExtFn[`string;`C.strerror_r;`c.i`chkNot0;(`c.i;`c.C;(`c.size_t;enlist(`length;2)));()]; / int strerror_r(int errnum, char *strerrbuf, size_t buflen);

.b2c.defExtFn[`string;`C.memccpy;enlist`c.void_p,.b2c.it;(enlist`c.C`c.void_p;enlist`c.C`c.void_p;`c.i;(`c.size_t;enlist(`length;2)));()]; / void *memccpy(void *restrict s1, const void *restrict s2, int c, size_t n);
.b2c.defExtFn[`string;`C.memchr;enlist`c.void_p,.b2c.it;(enlist`c.C`c.void_p;`c.i;(`c.size_t;enlist(`length;1)));()]; / void *memchr(const void *s, int c, size_t n);
.b2c.defExtFn[`string;`C.memcmp;`c.i;(enlist`c.C`c.void_p;enlist`c.C`c.void_p;(`c.size_t;enlist(`length;2)));()]; / int memcmp(const void *s1, const void *s2, size_t n);
.b2c.defExtFn[`string;`C.memcpy;enlist`c.void_p,.b2c.it;(enlist`c.C`c.void_p;enlist`c.C`c.void_p;(`c.size_t;enlist(`length;2)));()]; / void *memcpy(void *restrict s1, const void *restrict s2, size_t n);
.b2c.defExtFn[`string;`C.memmove;enlist`c.void_p,.b2c.it;(enlist`c.C`c.void_p;enlist`c.C`c.void_p;(`c.size_t;enlist(`length;2)));()]; / void *memmove(void *s1, const void *s2, size_t n);
.b2c.defExtFn[`string;`C.memset;enlist`c.void_p,.b2c.it;(enlist`c.C`c.void_p;`c.i;(`c.size_t;enlist(`length;1)));()]; / void *memset(void *s, int c, size_t n);
