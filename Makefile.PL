# $Id: Makefile.PL,v 1.4 2001/01/10 14:12:58 matt Exp $

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

# get libs and inc from gnome-config
my $libs = `gnome-config --libs ghttp`;
my $inc = `gnome-config --cflags ghttp`;

chomp $libs; chomp $inc;

warn "Using LIBS='$libs' and INC='$inc'.\nRe-run $^X Makefile.PL LIBS='...' INC='...' if this is wrong\n";

WriteMakefile(
    'NAME'	=> 'HTTP::GHTTP',
    'VERSION_FROM' => 'GHTTP.pm', # finds $VERSION
    'LIBS'	=> [$libs],   # e.g., '-lm' 
    'DEFINE'	=> '',     # e.g., '-DHAVE_SOMETHING' 
    'INC'	=> $inc,     # e.g., '-I/usr/include/other' 
    'EXE_FILES' => [ 'scripts/g-request' ],
);
