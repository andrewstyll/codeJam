#! /usr/bin/env ruby

class State
    attr_accessor :key, :depth

    def initialize(key, depth, solved)
        @key = key
        @depth = depth
        @solved = solved
    end

    def solved
        if(@key == @solved)
            return true
        end
        return false
    end
end

class Move
    
    def self.checkState(state, visited)
        if(!visited.key?(state.key))
            visited[state.key] = state.key
            return true
        end
        return false
    end

    def self.makeMoves(state, moves, visited, solvedPuzzle, numFlip)
        depth = state.depth
        (0..state.key.length-numFlip).each do |i|
            newGriddle = String.new(state.key)
            (i...(i+numFlip)).each do |j|
                if(newGriddle[j] == "+")
                    newGriddle[j] = "-"
                else
                    newGriddle[j] = "+"
                end
            end
             
            #puts state.key
            #puts newGriddle
            newState = State.new(String.new(newGriddle), state.depth+1, solvedPuzzle)
            if(checkState(newState, visited))
                moves << newState
                #printAgenda(moves)
            end
        end
        return moves
    end
end

def printAgenda(agenda)
    agenda.each do |move|
        puts "Move: #{move.key}, Depth #{move.depth}"
    end
end

def BFS(newAgenda, searchAgenda, visited, solvedPuzzle, numFlip)
    solved = false
    while(1)

        searchAgenda.each do |move|
            if(move.solved)
                return move.depth
                #puts "Solved at depth: #{move.depth}"
            end
            Move.makeMoves(move, newAgenda, visited, solvedPuzzle, numFlip)
            #puts "Move: #{move.key} == #{move.solved} Depth #{move.depth}"
        end

        if(newAgenda.length == 0) 
            return "IMPOSSIBLE"
        end
        searchAgenda = newAgenda[0...newAgenda.length]
        newAgenda = Array.new
    end
end

def solvedProblem(pLength)
    solved = "+" * pLength
    return solved
end

caseCount = 0

ARGF.each_line do |line|
    input = line.chomp.split(' ')
    if(input.length != 1)
        caseCount += 1
        
        newAgenda = Array.new
        searchAgenda = Array.new
        visited = Hash.new
        
        numFlip = input[1].to_i
        solved =  solvedProblem(input[0].length)
        
        # init BFS
        initState = State.new(input[0], 0, solved)
        searchAgenda << initState
        visited[initState.key] = initState.key
        depth = BFS(newAgenda, searchAgenda, visited, solved, numFlip)
    
        puts "Case ##{caseCount}: #{depth}"
    end
end
