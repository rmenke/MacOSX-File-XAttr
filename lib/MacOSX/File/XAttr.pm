package MacOSX::File::XAttr;

use 5.016000;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

our @EXPORT = qw( XATTR_CREATE XATTR_NODEFAULT XATTR_NOFOLLOW
                  XATTR_NOSECURITY XATTR_REPLACE XATTR_SHOWCOMPRESSION
                  XATTR_MAXNAMELEN

                  getxattr fgetxattr setxattr fsetxattr listxattr
                  flistxattr removexattr fremovexattr );

# Rarely used constants but included for consistency's sake
our @EXPORT_OK = qw(XATTR_FINDERINFO_NAME XATTR_RESOURCEFORK_NAME);

our $VERSION = '0.01';

sub AUTOLOAD {
  my $constname;
  our $AUTOLOAD;

  ($constname = $AUTOLOAD) =~ s/.*:://;

  croak "MacOSX::File::XAttr::constant not defined"
    if $constname eq 'constant';

  my ($error, $val) = constant($constname);

  croak $error if $error;

  no strict 'refs';

  *$AUTOLOAD = sub { $val };

  goto &$AUTOLOAD;
}

require XSLoader;

XSLoader::load('MacOSX::File::XAttr', $VERSION);

1;

__END__

=head1 NAME

MacOSX::File::XAttr - Perl extension for MacOS X extended file attributes

=head1 SYNOPSIS

    use MacOSX::File::XAttr;

    my $title = getxattr('file.png', 'kMDItemTitle');
    setxattr('file.png', 'kMDItemTitle', '"Hello, World"');
    removexattr('file.png', 'kMDItemTitle');
    my @xattrs = listxattr('file.png');

=head1 DESCRIPTION

This module allows Perl scripts to manipulate MacOS X extended file
attributes (I<xattrs>) without having to launch the xattr(1) tool.

Most xattrs are used to provide additional information about files to
the Spotlight metadata store without modifying the file itself.

=head2 EXPORTS

=over

=item B<getxattr(>I<path>B<,> I<name> [B<,> I<options> [B<,> I<position>]]B<)>

=item B<fgetxattr(>I<filehandle>B<,> I<name> [B<,> I<options> [B<,> I<position>]]B<)>

Get the extended attribute I<name> for the given file.  The I<options>
are the ORed values of the constants listed below.  The I<position>
should only be used for B<XATTR_RESOURCEFORK_NAME> attributes and
should be 0 (or omitted) for all other types.

=item B<setxattr(>I<path>B<,> I<name>B<,> I<value> [B<,> I<options> [B<,> I<position>]]B<)>

=item B<fsetxattr(>I<filehandle>B<,> I<name>B<,> I<value> [B<,> I<options> [B<,> I<position>]]B<)>

Set the extended attribute I<name> to I<value> for the given file.
The I<options> are the ORed values of the constants listed below.  The
I<position> should only be used for B<XATTR_RESOURCEFORK_NAME>
attributes and should be 0 (or omitted) for all other types.

=item B<listxattr(>I<path> [B<,> I<options>]B<)>

=item B<flistxattr(>I<filehandle> [B<,> I<options>]B<)>

List the extended attributes of the given file.  The I<options> are
the ORed values of the constants listed below.

=item B<removexattr(>I<path>B<,> I<name> [B<,> I<options>]B<)>

=item B<fremovexattr(>I<filehandle>B<,> I<name> [B<,> I<options>]B<)>

Remove the extended attribute I<name> from the given file.  The
I<options> are the ORed values of the constants listed below.

=back

=head2 OPTION CONSTANTS

=over

=item B<XATTR_NOFOLLOW>

Do not follow symbolic links; perform the operation on the link
itself.  (I<getxattr>, I<setxattr>, I<listxattr>, I<removexattr>)

=item B<XATTR_CREATE>

Fail if the named attribute already exists.  (B<setxattr>)

=item B<XATTR_REPLACE>

Fail if the named attribute does not exist.  (B<setxattr>)

=item B<XATTR_SHOWCOMPRESSION>

Operate on the HFS Plus Compression attributes.  (B<getxattr>,
B<listxattr>, B<removexattr>)

=item B<XATTR_NODEFAULT>

Ignore any dot-underscore files.  On filesystems without multifork
support, extended attributes for a file I<foo> are stored in a file
named "._I<foo>".  (B<getxattr>, B<setxattr>, B<listxattr>,
B<removexattr>)

=item B<XATTR_MAXNAMELEN>

The maximum length of the name of an xattr.

=back

=head1 SEE ALSO

xattr(1), getxattr(3), setxattr(3), listxattr(3), removexattr(3)

L<MacOSX::File::AttrList>

=head1 BUGS

Almost everything is exported by default because the author doesn't
like long C<use> statements.

=head1 AUTHOR

Rob Menke, E<lt>rgm@the-wabe.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Rob Menke

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
