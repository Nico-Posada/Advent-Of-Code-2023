#!ruby
a = $<.map{
    a,b=_1.split
    [a, b.split(?,).map(&:to_i)]
}

$s = 0
def solve(str, str_idx, list)
    if str_idx == str.size
        m = str.scan(/#+/).map &:size
        $s += 1 if m.size == list.size && m.zip(list).all?{_1 == _2}        
    elsif str[str_idx] != ??
        solve(str, str_idx + 1, list)
    else
        idx = str.index(??) || str.size
        m = str[0, idx].scan(/#+/)
        return if m.size > list.size

        m.each_with_index do |s, i|
            return if s.size > list[i]
        end

        copy = str.dup
        copy[str_idx] = ?.
        solve(copy, str_idx + 1, list)

        str[str_idx] = ?#
        solve(str, str_idx + 1, list)
    end
end

a.each do |list, chunks|
    prev = $s
    solve(list, 0, chunks)
    p $s - prev
end

p $s