# $Id: simple.t,v 1.3 2000/11/22 11:59:46 matt Exp $

use Test;
use HTTP::GHTTP;
BEGIN { plan tests => 3 }
ok(1);

{
  my $r = HTTP::GHTTP->new();
  ok($r);
  ok($r->set_uri("http://axkit.org/"));
}
