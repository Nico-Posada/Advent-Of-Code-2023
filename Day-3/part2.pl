#!perl -p
push@s,$_;push@{$h{$.}},"$& $-[0] $+[0]"while/\d+/g}{s/\*/@a=map{grep{($a,$b,$c)=split$";$b-2<$-[0]<=$c}@{$h{$y+$_}}}0..2;$t+=$a[0]*$a[1]if@a==2/eg,$y++for@s;$_=$t
