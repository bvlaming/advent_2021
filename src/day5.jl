#=
day5:
- Julia version: 1.7.0
- Author: basvlaming
- Date: 2021-12-05
=#

using DataStructures


function parse_line_a(ln)
    ln2 = split(ln, " -> ")
    p0 = split(ln2[1], ",")
    p1 = split(ln2[2], ",")
    x0 = parse(Int, p0[1])
    y0 = parse(Int, p0[2])
    x1 = parse(Int, p1[1])
    y1 = parse(Int, p1[2])
    # Now, only consider horizontal or vertical lines
    if x0 == x1
        return [(x0, y) for y in min(y0, y1):max(y0,y1)]
    elseif y0 == y1
        return [(x, y0) for x in min(x0, x1):max(x0, x1)]
    else
        return []
    end
    end

points_a = collect(Iterators.flatten([parse_line_a(line) for line in readlines("input/day5.csv")]))

# how many points occur > once
day5a = count(ct -> ct > 1, values(counter(points_a)))
println(day5a)

function parse_line_b(ln)
    ln2 = split(ln, " -> ")
    p0 = split(ln2[1], ",")
    p1 = split(ln2[2], ",")
    x0 = parse(Int, p0[1])
    y0 = parse(Int, p0[2])
    x1 = parse(Int, p1[1])
    y1 = parse(Int, p1[2])
    # Now, only consider horizontal or vertical lines
    if x0 == x1
        return [(x0, y) for y in min(y0, y1):max(y0,y1)]
    elseif y0 == y1
        return [(x, y0) for x in min(x0, x1):max(x0, x1)]
    elseif (y1 - y0) == (x1 - x0) # positive diagonal
        return [(min(x0, x1) + n, min(y0,y1) + n) for n in 0:abs(y1-y0)]
    elseif (y1 - y0) == (x0 - x1)  # negative diagonal
        return [(min(x0, x1) + n, max(y0,y1) - n) for n in 0:abs(y1-y0)]
    else
        return []
    end
    end

points_b = collect(Iterators.flatten([parse_line_b(line) for line in readlines("input/day5.csv")]))

# how many points occur > once
day5b = count(ct -> ct > 1, values(counter(points_b)))
println(day5b)