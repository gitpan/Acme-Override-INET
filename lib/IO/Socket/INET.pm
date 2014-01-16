use strict;
use warnings;

#<<< No perltidy
package
    IO::Socket::INET; # hide from PAUSE because this module is EVIL
#>>>

# ABSTRACT: Object interface for AF_INET domain sockets

our $VERSION = 1.34;

# some $VERSIONs are set too late during circular loading,
# so we cheat and find them without loading
#
BEGIN {
    no strict 'refs';
    for my $mod (qw/IO::Socket IO::Socket::IP/) {
        ( my $file = $mod ) =~ s{::}{/}g;
        $file .= ".pm";
        if ( $INC{$file} && !defined ${"${mod}::VERSION"} ) {
            require Module::Metadata;
            my $mm = Module::Metadata->new_from_file( $INC{$file} );
            ${"${mod}::VERSION"} = $mm->version($mod);

        }
    }
}

use IO::Socket::IP 0.25 -register;
use base qw( IO::Socket::IP );
use Socket qw( PF_INET );

# Flag use of this module during testing; do after IO::Socket::IP loads so $VERSION is set
BEGIN {
    if ( $ENV{HARNESS_ACTIVE} && $INC{"Test/Builder.pm"} ) {
        Test::Builder->new->diag(
            "Acme::Override::INET replaced IO::Socket::INET with IO::Socket::IP $IO::Socket::IP::VERSION"
        );
    }
}

no warnings 'redefine'; # new defined twice due to circular load

sub new {
    my $class = shift;
    return $class->SUPER::new( Family => PF_INET, PeerAddr => shift ) if @_ == 1;
    return $class->SUPER::new( Family => PF_INET, @_ );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

IO::Socket::INET - Object interface for AF_INET domain sockets

=head1 VERSION

version 0.004

B<WARNING: This is a fake IO::Socket::INET as installed via Acme::Override::INET>.

The version number shown in the docs corresponds to the version of Acme::Override::INET
installed.

Documentation is a copy of that from IO::Socket::INET for your convenience.

=head1 SYNOPSIS

    use IO::Socket::INET;

=head1 DESCRIPTION

C<IO::Socket::INET> provides an object interface to creating and using sockets
in the AF_INET domain. It is built upon the L<IO::Socket> interface and
inherits all the methods defined by L<IO::Socket>.

=head1 CONSTRUCTOR

=over 4

=item new ( [ARGS] )

Creates an C<IO::Socket::INET> object, which is a reference to a
newly created symbol (see the C<Symbol> package). C<new>
optionally takes arguments, these arguments are in key-value pairs.

In addition to the key-value pairs accepted by L<IO::Socket>,
C<IO::Socket::INET> provides.

 PeerAddr    Remote host address          <hostname>[:<port>]
 PeerHost    Synonym for PeerAddr
 PeerPort    Remote port or service       <service>[(<no>)] | <no>
 LocalAddr   Local host bind address      hostname[:port]
 LocalHost   Synonym for LocalAddr
 LocalPort   Local host bind port         <service>[(<no>)] | <no>
 Proto       Protocol name (or number)    "tcp" | "udp" | ...
 Type        Socket type              SOCK_STREAM | SOCK_DGRAM | ...
 Listen      Queue size for listen
 ReuseAddr   Set SO_REUSEADDR before binding
 Reuse       Set SO_REUSEADDR before binding (deprecated,
                                              prefer ReuseAddr)
 ReusePort   Set SO_REUSEPORT before binding
 Broadcast   Set SO_BROADCAST before binding
 Timeout     Timeout value for various operations
 MultiHomed  Try all addresses for multi-homed hosts
 Blocking    Determine if connection will be blocking mode

If C<Listen> is defined then a listen socket is created, else if the
socket type, which is derived from the protocol, is SOCK_STREAM then
connect() is called.

Although it is not illegal, the use of C<MultiHomed> on a socket
which is in non-blocking mode is of little use. This is because the
first connect will never fail with a timeout as the connect call
will not block.

The C<PeerAddr> can be a hostname or the IP-address on the
"xx.xx.xx.xx" form.  The C<PeerPort> can be a number or a symbolic
service name.  The service name might be followed by a number in
parenthesis which is used if the service is not known by the system.
The C<PeerPort> specification can also be embedded in the C<PeerAddr>
by preceding it with a ":".

If C<Proto> is not given and you specify a symbolic C<PeerPort> port,
then the constructor will try to derive C<Proto> from the service
name.  As a last resort C<Proto> "tcp" is assumed.  The C<Type>
parameter will be deduced from C<Proto> if not specified.

If the constructor is only passed a single argument, it is assumed to
be a C<PeerAddr> specification.

If C<Blocking> is set to 0, the connection will be in nonblocking mode.
If not specified it defaults to 1 (blocking mode).

Examples:

   $sock = IO::Socket::INET->new(PeerAddr => 'www.perl.org',
                                 PeerPort => 'http(80)',
                                 Proto    => 'tcp');

   $sock = IO::Socket::INET->new(PeerAddr => 'localhost:smtp(25)');

   $sock = IO::Socket::INET->new(Listen    => 5,
                                 LocalAddr => 'localhost',
                                 LocalPort => 9000,
                                 Proto     => 'tcp');

   $sock = IO::Socket::INET->new('127.0.0.1:25');

   $sock = IO::Socket::INET->new(
                           PeerPort  => 9999,
                           PeerAddr  => inet_ntoa(INADDR_BROADCAST),
                           Proto     => udp,
                           LocalAddr => 'localhost',
                           Broadcast => 1 )
                       or die "Can't bind : $@\n";

 NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE

As of VERSION 1.18 all IO::Socket objects have autoflush turned on
by default. This was not the case with earlier releases.

 NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE

=back

=head2 METHODS

=over 4

=item sockaddr ()

Return the address part of the sockaddr structure for the socket

=item sockport ()

Return the port number that the socket is using on the local host

=item sockhost ()

Return the address part of the sockaddr structure for the socket in a
text form xx.xx.xx.xx

=item peeraddr ()

Return the address part of the sockaddr structure for the socket on
the peer host

=item peerport ()

Return the port number for the socket on the peer host.

=item peerhost ()

Return the address part of the sockaddr structure for the socket on the
peer host in a text form xx.xx.xx.xx

=back

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
