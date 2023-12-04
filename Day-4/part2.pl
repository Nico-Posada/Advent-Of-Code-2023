#!perl -pF\|
push@n,~~grep$F[0]=~/ $_\s/,$F[1]=~/\d+/g}{sub f{$t++;f("@_"+$_)for 1..$n["@_"]}f$_-1for 1..$.;$_=$t