# $Id: Makefile.PL,v 1.6 2001/01/13 20:10:10 matt Exp $

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

# get libs and inc from gnome-config
my $libs = `gnome-config --libs ghttp`;
my $inc = `gnome-config --cflags ghttp`;

chomp $libs; chomp $inc;

my %config;

$config{LIBS} = $libs;
$config{INC} = $inc;

while($_ = shift) {
    my ($key, $val) = split(/=/, $_, 2);
    $config{$key} = $val;
}

warn "Using LIBS='$config{LIBS}' and INC='$config{INC}'.\nIf this is wrong, Re-run as: \n  \$ $^X Makefile.PL LIBS='...' INC='...'\n\n";

WriteMakefile(
    'NAME'	=> 'HTTP::GHTTP',
    'VERSION_FROM' => 'GHTTP.pm', # finds $VERSION
    'EXE_FILES' => [ 'scripts/g-request' ],
    %config,
);
