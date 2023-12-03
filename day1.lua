local exampleInput = [[
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet]]

local partTwoExampleInput = [[
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen]]

local puzzleInput = require(script.puzzleInput)

local numberStrings = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

-- Part 1
local function findFirstNumber1(str)
	for i = 1, str:len() do
		local c = str:sub(i,i)
		if tonumber(c) then
			return c
		end
	end
end

local function findLastNumber1(str)
	for i = str:len(), 1, -1 do
		local c = str:sub(i,i)
		if tonumber(c) then
			return c
		end
	end
end

local sum = 0
for i, line in puzzleInput:split("\n") do
	sum += tonumber(findFirstNumber1(line) .. tostring(findFirstNumber1(line)))
end
print(sum)

-- Part 2
local function findFirstNumber2(str)
	local stack = ""
	for i = 1, str:len() do
		local c = str:sub(i,i)
		if tonumber(c) then
			return c
		end

		stack ..= c
		for j, numberString in numberStrings do
			if stack:find(numberString) then
				return tostring(j)
			end
		end
	end
end

local reversedNumberStrings = {}
for i, numberString in numberStrings do
	reversedNumberStrings[i] = numberString:reverse()
end

local function findLastNumber2(str)
	local stack = ""
	for i = str:len(), 1, -1 do
		local c = str:sub(i,i)
		if tonumber(c) then
			return c
		end

		stack ..= c
		for j, reversedNumberString in reversedNumberStrings do
			if stack:find(reversedNumberString) then
				return tostring(j)
			end
		end
	end
end

local sum = 0
for i, line in puzzleInput:split("\n") do
	sum += tonumber(findFirstNumber2(line) .. tostring(findLastNumber2(line)))
end
print(sum)
