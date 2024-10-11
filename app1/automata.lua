local automata = {}
automata.__index = automata
function automata:new(correctionSteps)
    local obj = setmetatable({}, automata)
    obj.correctionSteps = correctionSteps or 10
    obj.weight = math.random()

    return obj
end

function automata:predict(input)
    local result = self.weight*input
    return result
end

-- only to be used in training.
function automata:correct(input, truth)
    local noise = 1
    local err = 0
    for i = 1,self.correctionSteps do
        local prediction = self:predict(input)
        err = prediction - truth
        local adFactor = truth / (self.weight * input)*(math.random()/noise)
        self.weight = (self.weight * adFactor)
        if math.abs(err) < 0.3 then
            return math.abs(err)
        end
    end
    return math.abs(err)
end

return automata