# $Id: GHTTP.pm,v 1.2 2000/11/21 19:59:27 matt Exp $

package HTTP::GHTTP;

use strict;
use vars qw($VERSION @ISA @EXPORT_OK);

require Exporter;
require DynaLoader;

@ISA = qw(Exporter DynaLoader);

@EXPORT_OK = qw( get );

$VERSION = '1.0';

bootstrap HTTP::GHTTP $VERSION;

sub new {
    my $class = shift;
    my $r = $class->_new();
    bless $r, $class;
    if (@_) {
        my $uri = shift;
        $r->set_uri($uri);
        while(@_) {
            my ($header, $value) = splice(@_, 0, 2);
            $r->set_header($header, $value);
        }
    }
    return $r;
}

sub get {
    die "get() requires a URI as a parameter" unless @_;
    my $r = __PACKAGE__->new(@_);
    $r->process_request;
    return $r->get_body();
}

1;
__END__

=head1 NAME

HTTP::GHTTP - Perl interface to the gnome ghttp library

=head1 SYNOPSIS

  use HTTP::GHTTP;
  
  my $r = HTTP::GHTTP->new();
  $r->set_uri("http://axkit.org/");
  $r->process_request;
  print $r->get_body;

=head1 DESCRIPTION

This is a fairly low level interface to the Gnome project's libghttp,
which allows you to process HTTP requests to HTTP servers. There also
exists a slightly higher level interface - a simple get() function
which takes a URI as a parameter. This is not exported by default, you
have to ask for it explicitly.

=head1 API

=head2 HTTP::GHTTP->new([$uri, [%headers]])

Constructor function - creates a new GHTTP object. If supplied a URI
it will automatically call set_uri for you. If you also supply a list
of key/value pairs it will set those as headers:

    my $r = HTTP::GHTTP->new(
        "http://axkit.com/",
        Connection => "close");

=head2 $r->set_uri($uri)

This sets the URI for the request

=head2 $r->set_header($header, $value)

This sets an outgoing HTTP request header

=head2 $r->process_request()

This sends the actual request to the server

=head2 $r->get_header($header)

This gets the value of an incoming HTTP response header

=head2 $r->get_body()

This gets the body of the response

=head2 $r->get_error()

If the response failed for some reason, this returns a textual error

=head2 $r->set_authinfo($user, $password)

This sets an outgoing username and password for simple HTTP 
authentication

=head2 $r->set_proxy($proxy)

This sets your proxy server, use the form "http://proxy:port"

=head2 $r->set_proxy_authinfo($user, $password)

If you have set a proxy and your proxy requires a username and password
you can set it with this.

=head2 get($uri, [%headers])

This does everything automatically for you, retrieving the body at
the remote URI. Optionally pass in headers.

=head1 AUTHOR

Matt Sergeant, matt@sergeant.org

=head1 LICENSE

This is free software, you may use it and distribute it under the 
same terms as Perl itself. Please be aware though that libghttp is
licensed under the terms of the LGPL, a copy of which can be found
in the libghttp distribution.

=head1 BUGS

No support for POST (yet).

=cut
