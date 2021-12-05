#=
day4:
- Julia version: 1.7.0
- Author: basvlaming
- Date: 2021-12-04
=#


using CSV
using DataFrames
using DataStructures

numbers = [parse(Int, nr) for nr in split(readlines("input/day4a.csv")[1], ',')]

rawboards = readlines("input/day4b.csv")
# board n is (n-1)*6 + 1,2,3,4,5
# 1, 7, 13
println(numbers)
board_count = Int((size(rawboards, 1) + 1) / 6)

boards = [[split(replace(row, "  " => " "), " ") for row in rawboards[6 * (board_idx - 1) .+ (1:5)]]
    for board_idx in 1:board_count]

function check_bingo(board, numbers_so_far)
    cols = [[row[checkpos] for row in board] for checkpos in 1:5]
    for row in [board;cols]
        if length(intersect(Set(parse(Int, x) for x in row), Set(numbers_so_far))) == 5
            println(score(board, numbers_so_far))
            return true
        end
        end
    return false
    end

function score(board, numbers)
     board = [[parse(Int, n) for n in row] for row in board]
     last_nr = last(numbers)
     board_vec = []
     for row in board
        board_vec = [board_vec; row]
        end
     board_val = sum(filter(n -> !(n in numbers), board_vec))
     return last_nr * board_val
     end


function day4a(boards, numbers)
    # take n numbers; check what board makes bingo (if any); if none, go to n + 1
    n = 5
    function check_boards()
        bingos = findall(bc -> check_bingo(boards[bc], numbers[1:n]),  1:board_count)
        if length(bingos) == 0
            n += 1
            check_boards()
        else
            winning_board = boards[bingos[1]]
            return score(winning_board, numbers[1:n])
        end
    end
    check_boards()
    end

# day4a(boards, numbers)

function day4b(boards, numbers)
    # keep track of nr of bingos. print when a board bingos, but just keep going
    n = 5
    boards_left = 1:board_count
    function check_boards()
        bingos = findall(bc -> check_bingo(boards[bc], numbers[1:n]),  1:board_count)

        if length(bingos) == 0
            n += 1
            check_boards()
        elseif length(boards) == 0 # all boards have bingoed
            println("all boards have bingoed")
            return 0
        else
            boards_left = filter(bc -> !(bc in bingos), boards_left)
            println(boards_left)
            if length(boards_left) == 1
                winning_board = boards[boards_left[1]]
                println(numbers[n])
                println(winning_board)
                println(score(winning_board, numbers[1:n]))
                return score(winning_board, numbers[1:n])
            else
                n += 1
                check_boards()
                end
        end
    end
    check_boards()
    end

day4b(boards, numbers)

for n in 1:length(numbers)
    check_bingo(boards[60], numbers[1:n])
end