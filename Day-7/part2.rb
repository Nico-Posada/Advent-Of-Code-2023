#!ruby
p$<.map(&:split).sort_by{|h,_|t=(g=h.tr(?J,'').chars.tally).size;[t<1?1:t,-h.count(?J)-(g.map{_2}.max||0),h.chars.map{:AKQT98765432J=~/#{_1}/}]}.sum{_2.to_i*-~$.-=1}