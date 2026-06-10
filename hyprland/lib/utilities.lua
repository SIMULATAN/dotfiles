---@generic T
---@param a T
---@param b table
---@return T
function Merge(a, b)
    local result = {}

    for k, v in pairs(a) do
        result[k] = v
    end

    for k, v in pairs(b) do
        result[k] = v
    end

    return result
end
