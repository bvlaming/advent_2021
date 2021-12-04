#=
day3:
- Julia version: 1.7.0
- Author: basvlaming
- Date: 2021-12-04
=#

using CSV
using DataFrames
using DataStructures

df = CSV.read("input/day3.csv", DataFrame; header=["binary"], types=String)

function day3a(data)
    # dictionary from pos to string (all 1st vals, 2nd vals, ...)
    pos_dict = [[row["binary"][pos] for row in eachrow(data)] for pos in 1:12]
    # Find most/least common keys for each position, and join into one string
    gamma = join([findmax(counter(pos_dict[pos]))[2] for pos in 1:12])
    epsilon = join([findmin(counter(pos_dict[pos]))[2] for pos in 1:12])

    println(parse(Int, gamma, base=2) * parse(Int, epsilon, base=2))
    return gamma, epsilon
    end

day3a(df)

function day3b(df)
    checkpos = 1

    function find_oxygen(data)
        if size(data, 1) == 1
            return data[1, "binary"]
        else
            vals = [row["binary"][checkpos] for row in eachrow(data)]
            most_freq = findmax(counter(vals))
            least_freq = findmin(counter(vals))
            val = most_freq > least_freq ? most_freq[2] : '1'
            checkpos += 1
            find_oxygen(filter(row -> row["binary"][checkpos - 1] == val, data))
        end
    end
    oxy = find_oxygen(df)

    checkpos = 1
    function find_co2(data)
        if size(data, 1) == 1
            return data[1, "binary"]
        else
            vals = [row["binary"][checkpos] for row in eachrow(data)]
            most_freq = findmax(counter(vals))
            least_freq = findmin(counter(vals))
            val = most_freq > least_freq ? least_freq[2] : '0'
            checkpos += 1
            find_co2(filter(row -> row["binary"][checkpos - 1] == val, data))
        end
    end
    co2 = find_co2(df)
    println(parse(Int, oxy, base=2) * parse(Int, co2, base=2))
    end

day3b(df)
