local get_lazy_keys = require('config.keymaps').get_lazy_keys
local  M = {}
-- generate a lazyvim can use args
function M.generate_keymaps(func_mappings)
    local result = {}
    for _,config in ipairs(func_mappings) do
        local a = get_lazy_keys(unpack(config))
        table.insert(result,a)
    end
    return result
end


return M
