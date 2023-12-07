#!ruby
p$<.map(&:split).sort_by{|h,_|[([]|q=h.chars).size,-q.tally.map{_2}.max,q.map{:AKQJT98765432=~/#{_1}/}]}.sum{_2.to_i*-~$.-=1}