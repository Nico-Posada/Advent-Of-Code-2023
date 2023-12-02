#!/usr/bin/perl -pF;
$r=$g=$b=0;map{/ /;eval"\$$'=$`if\$$'<$`"}/\d+ \w/g for@F;$q+=$r*$g*$b}{$_=$q
