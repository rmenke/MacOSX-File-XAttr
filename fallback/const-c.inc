#define PERL_constant_NOTFOUND	1
#define PERL_constant_NOTDEF	2
#define PERL_constant_ISIV	3
#define PERL_constant_ISNO	4
#define PERL_constant_ISNV	5
#define PERL_constant_ISPV	6
#define PERL_constant_ISPVN	7
#define PERL_constant_ISSV	8
#define PERL_constant_ISUNDEF	9
#define PERL_constant_ISUV	10
#define PERL_constant_ISYES	11

#ifndef NVTYPE
typedef double NV; /* 5.6 and later define NVTYPE, and typedef NV to it.  */
#endif
#ifndef aTHX_
#define aTHX_ /* 5.6 or later define this for threading support.  */
#endif
#ifndef pTHX_
#define pTHX_ /* 5.6 or later define this for threading support.  */
#endif

static int
constant (pTHX_ const char *name, STRLEN len, IV *iv_return, const char **pv_return) {
  /* Initially switch on the length of the name.  */
  /* When generated this function returned values for the list of names given
     in this section of perl code.  Rather than manually editing these functions
     to add or remove constants, which would result in this comment and section
     of code becoming inaccurate, we recommend that you edit this section of
     code, and use it to regenerate a new set of constant functions which you
     then use to replace the originals.

     Regenerate these constant functions by feeding this entire source file to
     perl -x

#!perl -w
use ExtUtils::Constant qw (constant_types C_constant XS_constant);

my $types = {map {($_, 1)} qw(IV PV)};
my @names = (qw(XATTR_CREATE XATTR_MAXNAMELEN XATTR_NODEFAULT XATTR_NOFOLLOW
	       XATTR_NOSECURITY XATTR_REPLACE XATTR_SHOWCOMPRESSION),
            {name=>"XATTR_FINDERINFO_NAME", type=>"PV"},
            {name=>"XATTR_RESOURCEFORK_NAME", type=>"PV"});

print constant_types(), "\n"; # macro defs
foreach (C_constant ("MacOSX::File::XAttr", 'constant', 'IV', $types, undef, 3, @names) ) {
    print $_, "\n"; # C constant subs
}
print "\n#### XS Section:\n";
print XS_constant ("MacOSX::File::XAttr", $types);
__END__
   */

  switch (len) {
  case 12:
    if (memEQ(name, "XATTR_CREATE", 12)) {
#ifdef XATTR_CREATE
      *iv_return = XATTR_CREATE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 13:
    if (memEQ(name, "XATTR_REPLACE", 13)) {
#ifdef XATTR_REPLACE
      *iv_return = XATTR_REPLACE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 14:
    if (memEQ(name, "XATTR_NOFOLLOW", 14)) {
#ifdef XATTR_NOFOLLOW
      *iv_return = XATTR_NOFOLLOW;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 15:
    if (memEQ(name, "XATTR_NODEFAULT", 15)) {
#ifdef XATTR_NODEFAULT
      *iv_return = XATTR_NODEFAULT;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 16:
    /* Names all of length 16.  */
    /* XATTR_MAXNAMELEN XATTR_NOSECURITY */
    /* Offset 6 gives the best switch position.  */
    switch (name[6]) {
    case 'M':
      if (memEQ(name, "XATTR_MAXNAMELEN", 16)) {
      /*                     ^                */
#ifdef XATTR_MAXNAMELEN
        *iv_return = XATTR_MAXNAMELEN;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'N':
      if (memEQ(name, "XATTR_NOSECURITY", 16)) {
      /*                     ^                */
#ifdef XATTR_NOSECURITY
        *iv_return = XATTR_NOSECURITY;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 21:
    /* Names all of length 21.  */
    /* XATTR_FINDERINFO_NAME XATTR_SHOWCOMPRESSION */
    /* Offset 7 gives the best switch position.  */
    switch (name[7]) {
    case 'H':
      if (memEQ(name, "XATTR_SHOWCOMPRESSION", 21)) {
      /*                      ^                    */
#ifdef XATTR_SHOWCOMPRESSION
        *iv_return = XATTR_SHOWCOMPRESSION;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'I':
      if (memEQ(name, "XATTR_FINDERINFO_NAME", 21)) {
      /*                      ^                    */
#ifdef XATTR_FINDERINFO_NAME
        *pv_return = XATTR_FINDERINFO_NAME;
        return PERL_constant_ISPV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 23:
    if (memEQ(name, "XATTR_RESOURCEFORK_NAME", 23)) {
#ifdef XATTR_RESOURCEFORK_NAME
      *pv_return = XATTR_RESOURCEFORK_NAME;
      return PERL_constant_ISPV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

