local M = {}

M.exec_telescop_builtin_func = function ( builtin_func_name, opts)
    return function ()
        require('telescope.builtin')[builtin_func_name](opts)
    end
end

-- get neovim lsp confg different levle diagnostic
M.diagnostic_go_to_with_level = function (is_next,level)
    local direction = is_next and "goto_next" or "goto_prev"
    local severity = level and vim.diagnostic.severity[level] or nil
    return function ()
        vim.diagnostic[direction]({ severity = severity })
    end
end


return M
