#!perl

use strict;
use warnings;

use MacOSX::File::XAttr;

use Test::More tests => 2;
use File::Temp 'tempfile';

my ($fh, $file) = tempfile(undef, UNLINK => 1);

for ([foo => 1], [bar => 2], [baz => 3]) {
  system('xattr', '-w', @$_, $file) == 0
    or BAIL_OUT "unexpected problem with xattr (exit status $?)";
}

my @xattr = listxattr($file);

is_deeply([sort @xattr], [qw(bar baz foo)], 'listxattr');

@xattr = flistxattr($fh);

is_deeply([sort @xattr], [qw(bar baz foo)], 'flistxattr');

done_testing;
