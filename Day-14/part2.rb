#!ruby
a = $<.map{_1.chomp.chars}

def cycle(arr)
    return arr.map{|c|
        s = -1
        while s != 0
            s = 0
            for i in 1...c.size
                if c[i-1] == ?O && c[i] == ?.
                    c[i-1], c[i] = c[i], c[i-1]
                    s += 1
                end
            end
        end

        c
    }
end

def full_cycle(a)
    a = a.transpose.map(&:reverse)
    a = cycle(a)
    a = a.transpose.map(&:reverse)
    a = cycle(a)
    a = a.transpose.map(&:reverse)
    a = cycle(a)
    a = a.transpose.map(&:reverse)
    a = cycle(a)
    return a
end

c = [a.join]
i = 0
x = false
while i < 1000000000
    a = full_cycle(a)
    joined = a.join
    if !x && c.count(joined) == 2
        l, r = c.index(joined), c.rindex(joined)
        d = r - l
        i += d * ((1000000000 - i) / d)
        x = true 
    end
    c << joined
    i += 1
end

puts a.size.times.sum{|i| a[i].count(?O) * (a.size - i)} if x