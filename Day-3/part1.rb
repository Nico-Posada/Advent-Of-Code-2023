#!ruby
t=0
(h=*$<).zip(0..){|s,y|
s.scan(/\d+/){|m|a,b=$~.offset w=0
(a...b).map{|x|(r=*-1..1).product(r){nx,ny=x+_2,y+_1;0<=nx&&nx<140&&0<=ny&&ny<140&&h[ny][nx]!~/[\d.]/&&w=m.to_i}}
t+=w}}
p t
