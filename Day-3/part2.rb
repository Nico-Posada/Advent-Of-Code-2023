#!/usr/local/bin/ruby
a=*$<
t=0
q=/\d/
140.times{|y|140.times{|x|
a[y][x]==?*&&(n=[]
(b=-1..1).map{|s|f=!0
b.map{k=x+_1;j=y+s
!f&&0<=k&&k<140&&0<=j&&j<140&&q===a[j][k]?(k-=1while k>=0&&a[j][k]=~q
n<<a[j][k+1..].to_i
s!=0&&f=!p):_1==0&&a[j][k]!~q ?f=!0:0}}
n.size==2&&t+=n[0]*n[1])}}
p t
