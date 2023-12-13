#!ruby

a = `cat`.split("\n\n").map &:split
s = 0
a.each do |lines|
    changed = false
    for i in 0...lines.size - 1
        l, r = i, i+1

        c = 0
        while l >= 0 && r < lines.size
            left, right = lines[l].chars, lines[r].chars
            c += left.zip(right).count{_1 != _2}

            l -= 1
            r += 1
        end

        if c == 1
            s += 100 * (i + 1)
            changed = true
            break
        end
    end

    next if changed

    lines = lines.map(&:chars).transpose.map &:join
    for i in 0...lines.size - 1
        l, r = i, i+1

        c = 0
        while l >= 0 && r < lines.size
            left, right = lines[l].chars, lines[r].chars
            c += left.zip(right).count{_1 != _2}

            l -= 1
            r += 1
        end

        if c == 1
            s += (i + 1)
            changed = true
            break
        end
    end
end

p s