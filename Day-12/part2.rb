#!ruby
$memo = {}

def solve(str, nums)
    memo_arr = [str, *nums]
    return $memo[memo_arr] if $memo.has_key?(memo_arr)

    t = 0
    first, *rest = nums
    if first.nil?
        result = str.size == 0 || !str[?#] ? 1 : 0
        $memo[memo_arr] = result
        return result
    end

    if str.size == 0
        $memo[memo_arr] = 0
        return 0
    end

    reg = /^[\?\#]{#{first}}([\.\?]\.*(.*)|)$/
    if str =~ /^\?+/
        $~.end(0).times do
            if str =~ reg
                t += solve($2||'', rest)
            end

            str = str[1..]
        end
    end

    if str =~ reg
        t += solve($2||'', rest)
    elsif str =~ /^\.+/
        t += solve(str.gsub(/^\.+/, ''), nums)
    end

    $memo[memo_arr] = t
    return t
end

p $<.sum{|input|
    l, r = input.split
    r = r.split(?,).map(&:to_i) * 5
    l = ([l] * 5) * ??
    l.gsub!(/^\.+|\.+$/,'')
    solve(l, r)
}