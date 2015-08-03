#!perl

use strict;
use warnings;

use MacOSX::File::XAttr;

use Test::More tests => 4;
use File::Temp 'tempfile';

my ($fh, $file) = tempfile(undef, UNLINK => 1);

for ([foo => 1], [bar => 2], [baz => 3]) {
  system('xattr', '-w', @$_, $file) == 0
    or BAIL_OUT "unexpected problem with xattr (exit status $?)";
}

ok(removexattr($file, 'foo'), "removexattr - 1")
  or diag("$file: $!\n");

my @xattr = listxattr($file);

is_deeply([sort @xattr], [qw(bar baz)], "removexattr - 2");

ok(fremovexattr($fh, 'bar'), "fremovexattr - 1")
  or diag("$file: $!\n");

@xattr = flistxattr($fh);

is_deeply([sort @xattr], [qw(baz)], "fremovexattr - 2");

done_testing;
