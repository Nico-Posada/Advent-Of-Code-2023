#!ruby

a = `cat`.split("\n\n").map &:split
s = 0
a.each do |lines|
    changed = false
    for i in 0...lines.size - 1
        l, r = i, i+1
        found = true
        while l >= 0 && r < lines.size
            if lines[l] != lines[r]
                found = false
                break
            end

            l -= 1
            r += 1
        end

        if found
            s += 100 * (i + 1)
            changed = true
            break
        end
    end

    next if changed

    lines = lines.map(&:chars).transpose.map &:join
    for i in 0...lines.size - 1
        l, r = i, i+1
        found = true
        while l >= 0 && r < lines.size
            if lines[l] != lines[r]
                found = false
                break
            end

            l -= 1
            r += 1
        end

        if found
            s += (i + 1)
            changed = true
            break
        end
    end
end

p s