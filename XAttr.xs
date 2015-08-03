#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <sys/xattr.h>

#include "const-c.inc"

MODULE = MacOSX::File::XAttr PACKAGE = MacOSX::File::XAttr

INCLUDE: const-xs.inc

PROTOTYPES: ENABLE

void
getxattr(path, name, options = 0, position = 0)
	char *path;
	char *name;
	int options;
	U32 position;
PREINIT:
        ssize_t len;
PPCODE:
        len = getxattr(path, name, NULL, 0, position, options);
        if (len < 0) {
           SETERRNO(errno, errno);
           XSRETURN_UNDEF;
        }
        char buffer[len];
        len = getxattr(path, name, buffer, len, position, options);
        if (len < 0) {
           SETERRNO(errno, errno);
           XSRETURN_UNDEF;
        }
        mXPUSHp(buffer, len);

void
fgetxattr(file, name, options = 0, position = 0)
	PerlIO *file;
	char *name;
	int options;
	U32 position;
PROTOTYPE: *$;$$
PREINIT:
        int fd;
        ssize_t len;
PPCODE:
        fd = PerlIO_fileno(file);
        len = fgetxattr(fd, name, NULL, 0, position, options);
        if (len < 0) {
           SETERRNO(errno, errno);
           XSRETURN_UNDEF;
        }
        char buffer[len];
        len = fgetxattr(fd, name, buffer, len, position, options);
        if (len < 0) {
           SETERRNO(errno, errno);
           XSRETURN_UNDEF;
        }
        mXPUSHp(buffer, len);

bool
setxattr(path, name, value, options = 0, position = 0)
	char *path;
        char *name;
        SV *value;
        int options;
        U32 position;
PREINIT:
        void *val;
        size_t len;
        int status;
CODE:
        val = SvPV(value, len);
        status = setxattr(path, name, val, len, position, options);
	if (status < 0) {
	    SETERRNO(errno, errno);
	    XSRETURN_NO;
	}
	else {
	    XSRETURN_YES;
	}

bool
fsetxattr(file, name, value, options = 0, position = 0)
	PerlIO *file;
        char *name;
        SV *value;
        int options;
        U32 position;
PROTOTYPE: *$$;$$
PREINIT:
	int fd = PerlIO_fileno(file);
        void *val;
        size_t len;
        int status;
CODE:
        val = SvPV(value, len);
        status = fsetxattr(fd, name, val, len, position, options);
	if (status < 0) {
	    SETERRNO(errno, errno);
	    XSRETURN_NO;
	}
	else {
	    XSRETURN_YES;
	}
OUTPUT:
	RETVAL

void
listxattr(path, options = 0)
	char *path;
	int options;
PREINIT:
        ssize_t len, slen;
        char *scan, *end;
PPCODE:
        len = listxattr(path, NULL, 0, options);
        if (len < 0) {
            SETERRNO(errno, errno);
            XSRETURN_EMPTY;
        }
        char buffer[len];
        len = listxattr(path, buffer, len, options);
        if (len < 0) {
            SETERRNO(errno, errno);
            XSRETURN_EMPTY;
        }
        end = buffer + len;
        for (scan = buffer; scan < end; scan += slen + 1) {
            slen = strnlen(scan, end - scan);
            mXPUSHp(scan, slen);
        }

void
flistxattr(file, options = 0)
	PerlIO *file;
        int options;
PROTOTYPE: *;$
PREINIT:
        ssize_t len, slen;
        char *scan, *end;
        int fd = PerlIO_fileno(file);
PPCODE:
        len = flistxattr(fd, NULL, 0, options);
        if (len < 0) {
            SETERRNO(errno, errno);
            XSRETURN_EMPTY;
        }
        char buffer[len];
        len = flistxattr(fd, buffer, len, options);
        if (len < 0) {
            SETERRNO(errno, errno);
            XSRETURN_EMPTY;
        }
        end = buffer + len;
        for (scan = buffer; scan < end; scan += slen + 1) {
            slen = strnlen(scan, end - scan);
            mXPUSHp(scan, slen);
        }

int
removexattr(path, name, options = 0)
	char *path
	char *name
	int options
PREINIT:
        int status;
CODE:
	if (removexattr(path, name, options) < 0) {
	    SETERRNO(errno, errno);
	    XSRETURN_NO;
	}
	else {
	    XSRETURN_YES;
	}

int
fremovexattr(file, name, options = 0)
	PerlIO *file
	char *name
	int options
PREINIT:
        int status;
CODE:
	if (fremovexattr(PerlIO_fileno(file), name, options) < 0) {
	    SETERRNO(errno, errno);
	    XSRETURN_NO;
	}
	else {
	    XSRETURN_YES;
	}
