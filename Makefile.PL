#!perl

use 5.016000;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'MacOSX::File::XAttr',
    VERSION_FROM      => 'lib/MacOSX/File/XAttr.pm',
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/MacOSX/File/XAttr.pm',
    AUTHOR            => 'Rob Menke <rgm@apple.com>',
    LIBS              => [''],
    DEFINE            => '',
    INC               => '-I.',
);

if (eval {require ExtUtils::Constant; 1}) {
  my %names = (
    XATTR_CREATE => 'IV',
    XATTR_MAXNAMELEN => 'IV',
    XATTR_NODEFAULT => 'IV',
    XATTR_NOFOLLOW => 'IV',
    XATTR_NOSECURITY => 'IV',
    XATTR_REPLACE => 'IV',
    XATTR_SHOWCOMPRESSION => 'IV',

    XATTR_FINDERINFO_NAME => 'PV',
    XATTR_RESOURCEFORK_NAME => 'PV',
  );

  my @names = map +{ name => $_, type => $names{$_} }, keys %names;

  ExtUtils::Constant::WriteConstants(
      NAME            => 'MacOSX::File::XAttr',
      NAMES           => \@names,
      DEFAULT_TYPE    => 'IV',
      C_FILE          => 'const-c.inc',
      XS_FILE         => 'const-xs.inc',
  );
}
else {
  use File::Copy;
  use File::Spec;

  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
