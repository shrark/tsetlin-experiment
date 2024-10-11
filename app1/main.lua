--[[
Tsetlin-type machine

automata
weight (0.0-1.0)

predict(input - 0.0-1.0) => weight - input

training:
the machine iterates through, sums up values, and shifts each automata
based on the correctness factor to ground truth.
ref:
https://tsetlinmachine.org/wp-content/uploads/2022/11/Tsetlin_Machine_Book_Chapter_One_Revised.pdf
]]

local automataClass = require("automata")

local machine = {}
machine.__index = machine

function machine:new(dataset)
    local obj = setmetatable({}, machine)
    obj.dataset = dataset
    obj.automatas = {}
    for i = 1,#dataset do
        obj:addAutomata()
    end
    return obj
end

function machine:addAutomata()
    local automata = automataClass:new(2)
    -- correction steps.
    table.insert(self.automatas, automata)
end

function machine:encodeDataset(dataset)
    --[[
    examples:
    {

    }
    ]]
end

function machine:train()
    --[[
    example:
    {
        [2] = {input=0.1, truth=0.2}
        [1] = {input=0.2, truth=0.3}
    }
    --]]
    for i,v in pairs(self.dataset) do
        local automata = self.automatas[i]
        local correction = automata:correct(v.input, v.truth)
    end
end

function machine:predict(data)
    local score = 0
    for i = 1,#data do
        local v = data[i]
        local automata = self.automatas[i]
        local input,truth = v.input, v.truth
        local result = automata:predict(input)
        score = score +result
    end
    print(score)
end


local example = {
    {input=0.1, truth=1},
    {input=0.1, truth=1},
    {input=0.2, truth = 0.9}
}

local example2 = {
    {input=0.8, truth=0.1},
    {input=0.99, truth=0.3},
    {input=0.8, truth = 0.4},
    {input=0.99, truth=0.8},
    {input=1, truth=0.3},
    {input=0.9, truth = 0.4}
}

local machineObj = machine:new(example2)
machineObj:train()
machineObj:predict(example)