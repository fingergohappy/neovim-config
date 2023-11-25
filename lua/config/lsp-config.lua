local M = {}


-- language config 
local lang_config = {
    -- lua_ls = {
    --     settings = {
    --         Lua = {
    --             workspace = { checkThirdParty = false },
    --             telemetry = { enable = false },
    --         }
    --     }
    -- },
    clangd = {
        settings = {}
    },
    pyright = {
        settings = {}
    },
    jsonls = {
        settings = {}
    },
    marksman = {
        settings = {}
    },
    volar = {
        settings = {}
    },
    dockerls = {
        settings = {}
    },
    docker_compose_language_service = {
        settings = {}
    },
    bashls = {
        settings = {}
    },
    -- ocamllsp = {},
    taplo = {
        settings = {}
    },
    ruff_lsp = {
        settings = {}
    },
    stylelint_lsp = {
        settings = {}
    },
    biome = {
        settings = {}
    },
    volar = {

    }
}


local function exec_telescop_builtin_func( builtin_func_name, opts)
    return function ()
        require('telescope.builtin')[builtin_func_name](opts)
    end
end

-- get neovim lsp confg different levle diagnostic
local function diagnostic_go_to_with_level(is_next,level)
    local direction = is_next and "goto_next" or "goto_prev"
    local severity = level and vim.diagnostic.severity[level] or nil
    return function ()
        vim.diagnostic[direction]({ severity = severity })
    end
end

-- 功能映射
local func_map = {
    go_to_declaration = exec_telescop_builtin_func("lsp_definitions") ,
    go_to_definition = exec_telescop_builtin_func("lsp_definitions",{ reuse_win = true }),
    go_to_implemention = exec_telescop_builtin_func("lsp_implementations",{ reuse_win = true }),
    show_documention = vim.lsp.buf.hover,
    action = vim.lsp.buf.code_action,
    go_to_type_definition = exec_telescop_builtin_func("lsp_type_definitions", {reuse_win = true}),
    next_diagnostic = diagnostic_go_to_with_level(true),
    prev_diagnostic = diagnostic_go_to_with_level(false),
    next_error = diagnostic_go_to_with_level(true,"ERROR"),
    prev_error = diagnostic_go_to_with_level(false,"ERROR"),
    next_warning = diagnostic_go_to_with_level(true,"WARN"),
    prev_warning = diagnostic_go_to_with_level(false,"WARN"),
    format = function() vim.lsp.buf.format { async = true } end


}

-- generate key map from define
local function get_lsp_map(buffer)
    local lsp_map_definition =  require('config.keymaps').key_maps.plugin_maps.lsp
    local result = {}
    for func_name,func in pairs(func_map) do
        local map_define = lsp_map_definition[func_name]
        local opts = map_define.opts
        opts.buffer = buffer
        local vim_key_map = {map_define.mode,map_define.lhs,func,opts}
        table.insert(result,vim_key_map)
    end
    return result
end

local function lsp_on_attach(_,buffer)
    local lsp_map = get_lsp_map(buffer)
    for _,v in pairs(lsp_map) do
        vim.keymap.set(unpack(v))
    end
end

function M.mason_lsp_config_handler(server_name)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig')[server_name].setup{
        settings = lang_config[server_name].settings,
        on_attach = lsp_on_attach,
        capabilities = capabilities
    }
end

function M.get_server_name()
    return vim.tbl_keys(lang_config)
end


return M
