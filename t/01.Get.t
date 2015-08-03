#!perl

use strict;
use warnings;

use Test::More tests => 2;
use File::Temp 'tempfile';

use MacOSX::File::XAttr;

use constant TITLE => 'com.apple.metadata:kMDItemTitle';
use constant WHERE_FROMS => 'com.apple.metadata:kMDItemWhereFroms';

my ($fh, $file) = tempfile('testXXXXXX', SUFFIX => '.txt', UNLINK => 1);

my $expected = '"Hello, World"';

system('xattr', '-w', TITLE, $expected, $file) == 0
  or BAIL_OUT "unexpected problem with xattr (exit status $?)";

my $got = getxattr($file, TITLE);

is($got, $expected, 'getxattr');

$expected = '("http://www.foo.com/", "http://www.bar.com/")';

system('xattr', '-w', WHERE_FROMS, $expected, $file) == 0
  or BAIL_OUT "unexpected problem with xattr (exit status $?)";

$got = fgetxattr($fh, WHERE_FROMS);

is($got, $expected, 'fgetxattr');
