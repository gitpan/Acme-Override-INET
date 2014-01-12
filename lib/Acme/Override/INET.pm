use strict;
use warnings;

package Acme::Override::INET;
# ABSTRACT: Monkeypatch IO::Socket::INET to use IO::Socket::IP
our $VERSION = '0.002'; # VERSION

1;


# vim: ts=4 sts=4 sw=4 et:

__END__

=pod

=encoding UTF-8

=head1 NAME

Acme::Override::INET - Monkeypatch IO::Socket::INET to use IO::Socket::IP

=head1 VERSION

version 0.002

B<WARNING>: This may break your system

=head1 DESCRIPTION

Installing this distribution replaces your L<IO::Socket::INET> with
a patched version that uses L<IO::Socket::IP>.  Don't do this unless
you are willing to accept the risk of doing so.

Use this only to test how effective L<IO::Socket::IP> is as a drop-in
replacement.

=for Pod::Coverage BUILD

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at L<https://github.com/dagolden/Acme-Override-INET/issues>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/dagolden/Acme-Override-INET>

  git clone https://github.com/dagolden/Acme-Override-INET.git

=head1 AUTHORS

=over 4

=item *

David Golden <dagolden@cpan.org>

=item *

Paul Evans <pevans@cpan.org>

=item *

Matthew Horsfall <wolfsage@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by David Golden.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut
