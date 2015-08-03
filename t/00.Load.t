#!perl

use strict;
use warnings;

use constant XATTR_CONSTANT => qw( XATTR_NOFOLLOW XATTR_CREATE XATTR_REPLACE XATTR_NOSECURITY XATTR_NODEFAULT XATTR_SHOWCOMPRESSION XATTR_MAXNAMELEN XATTR_FINDERINFO_NAME XATTR_RESOURCEFORK_NAME );

use Test::More tests => 1 + scalar(XATTR_CONSTANT);

our $Failed;

BEGIN {
  use_ok('MacOSX::File::XAttr') or $Failed = 1;
}

BAIL_OUT "One or more modules failed to load." if $Failed;

foreach (XATTR_CONSTANT) {
  no strict;
  my $value = &{"MacOSX::File::XAttr::$_"};
  ok(defined $value, "$_ (= $value)");
}
