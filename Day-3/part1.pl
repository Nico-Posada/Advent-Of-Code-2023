#!perl -pF
push@s,[@F]}{map{$_=join'',@{$s[$y=$_]};s^\d+^$p=0;$%=$&;for$x($-[0]..$+[0]-1){for$v(-1..1){$p|=$%*(0<=$y+$v<140&0<=$x+$_<140&$s[$y+$v][$x+$_]!~/[\d.]/)for-1..1}}$t+=$p^eg}0..139;$_=$t