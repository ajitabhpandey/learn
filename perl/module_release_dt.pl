#!/usr/bin/perl
use warnings;
use strict;

use Module::CoreList;

my @modules = sort keys $Module::CoreList::version{5.014002};

my $module_name_max_len = 0;

foreach my $module ( @modules ) {
   my $module_name_len = length $module;

   if ($module_name_len > $module_name_max_len) {
       $module_name_max_len = $module_name_len;
   }
}

printf "%s\n %*s %s\n %s\n", "="x72, - $module_name_max_len, "Module", "First Released Date", "="x72;

foreach my $module (@modules) {
    printf "%*s %s\n", - $module_name_max_len, $module, Module::CoreList->first_release($module);
}

