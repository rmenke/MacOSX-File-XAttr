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

setxattr $file, TITLE, $expected;

chomp(my $got = `xattr -p @{[TITLE]} \Q$file`);
BAIL_OUT "unexpected problem with xattr (exit status $?)" if $?;

is($got, $expected, 'setxattr');

$expected = '("http://www.foo.com/", "http://www.bar.com/")';

fsetxattr $fh, WHERE_FROMS, $expected;

chomp($got = `xattr -p @{[WHERE_FROMS]} \Q$file`);
BAIL_OUT "unexpected problem with xattr (exit status $?)" if $?;

is($got, $expected, 'fsetxattr');
