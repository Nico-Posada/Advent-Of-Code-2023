#!ruby
a = $<.map{_1.chomp.chars}.transpose

a.map!{|c|
    s = -1
    while s != 0
        s = 0
        for i in 1...c.size
            if c[i-1] == ?. && c[i] == ?O
                c[i-1], c[i] = c[i], c[i-1]
                s += 1
            end
        end
    end

    c
}

a=a.transpose.map(&:join)
p a.size.times.sum{|i| a[i].count(?O) * (a.size - i)}