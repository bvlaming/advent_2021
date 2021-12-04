#=
day2:
- Julia version: 1.7.0
- Author: basvlaming
- Date: 2021-12-03
=#


using CSV
using DataFrames

df = CSV.read("input/day2.csv", DataFrame; header=["dir","val"], delim=" ")

function day2a(data)
    moves = combine(groupby(data, :dir), :val => sum => :total)
    move_dict = Dict(Pair.(moves.dir, moves.total))
    println(move_dict["forward"]*(move_dict["down"] - move_dict["up"]))
    end

day2a(df)

function day2b(data)
    x = 0
    y = 0
    aim = 0
    for row in eachrow(data)
        if row["dir"] == "down"
            aim += row["val"]
        elseif row["dir"] == "up"
            aim -= row["val"]
        else
            x += row["val"]
            y += aim*row["val"]
        end
    end
    println(x*y)
    end

day2b(df)
