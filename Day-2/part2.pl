#!/usr/bin/perl -pF;
$r=$g=$b=0;map{/\pL/;eval"\$$&=$`if\$$&<$`"}/\d+ \w+/g for@F;$q+=$r*$g*$b}{$_=$q
