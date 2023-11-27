local M = {}

M.lang_config = {
    lua_ls = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
    },
    clangd = {
    },
    pyright = {
    },
    jsonls = {
    },
    marksman = {
    },
    volar = {
    },
    dockerls = {
    },
    docker_compose_language_service = {
    },
    bashls = {
    },
    taplo = {
    },
    ruff_lsp = {
    },
    stylelint_lsp = {
    },
    biome = {
    },
    volar = {
    }
}

M.mason_lsp_config_handlers = function(server_name)
end
M.get_registered_servers = function()

end
return M
