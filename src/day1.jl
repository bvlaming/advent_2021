#=
day1:
- Julia version: 1.7.0
- Author: basvlaming
- Date: 2021-12-03
=#

using CSV
using DataFrames

data = CSV.read("input/day1.csv", DataFrame; header=0)
vals = data[:,1]

function day1a(vals)
    # add a placeholder to the end so the vectors are the same size
    nextvals = vcat(vals[2:end], [-5000])
    diffs = nextvals.-vals
    # both the below two methods do the same under the hood
#     println(length(diffs[diffs.>0]))
    positive_diffs = filter(x -> x > 0, diffs)
    println(length(positive_diffs))
    end

day1a(vals)

function day1b(data)
    windows = Vector{Int}(undef, size(data,1))
    for n in 1:size(data,1)
        windows[n] = data[n,1] + data[n + 1,1] + data[n + 2,1]
        end
    println(day1a(windows))
    end

day1b(data)
