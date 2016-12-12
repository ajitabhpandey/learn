#!/usr/bin/perl
use strict;
use warnings;

use Cwd;
use Cwd 'abs_path';

my $cwd = cwd();

opendir(CWD, $cwd) or die $!;

while(defined (my $file = readdir(CWD))) {
    print("    ", abs_path($file), "\n");

}
closedir(CWD);
