#! /usr/bin/env ruby

def checkTidy(n)
    sortedVal = n.to_s.split('').sort().join.to_i
    if(n == sortedVal)
        return n
    end
    return -1
end

def checkNums(num)
    retVal = 1
    (num).downto(1).each do |n|
        if(n < 99999999999999999)
            puts "FAIL"
            break
        end
        tmpVal = checkTidy(n)
        if(tmpVal != -1)
            retVal = tmpVal
            return retVal
        end
    end
    return retVal
end

ARGF.each_with_index do |line, index|
    input = line.chomp.to_i
    count = 0
    if(index > 0) 
        count = checkNums(input)
        puts "Case ##{index}: #{count}"
    end
end
