#!/usr/bin/perl -p
sub f{(($i)=grep$a[$_]=~@_[0],0..8)?$i+1:@_[0]}
$r+=(f/(?=(\d|${\(join'|',@a=(one,two,three,four,five,six,seven,eight,nine))}))/g).f$1}{$_=$r
