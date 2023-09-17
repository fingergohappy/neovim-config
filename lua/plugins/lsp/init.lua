local lsp_config = require('config.lsp-config')

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neoconf.nvim",
            "folke/neodev.nvim",
            {
                "j-hui/fidget.nvim",
                tag = "legacy",
            },
            "nvimdev/lspsaga.nvim",
        },
        config = function()
            require("neoconf").setup()
            require("neodev").setup()
            require('fidget').setup()
            require("lspsaga").setup()
            require('mason').setup()
            require('mason-lspconfig').setup{
                ensure_installed = lsp_config.get_server_name(),
                automatic_installation = true,
                handlers = {
                    lsp_config.mason_lsp_config_handler,
                }
            }
        end
    },

    -- {
    --     "j-hui/fidget.nvim",
    --     tag = "legacy",
    --     event = {"LspAttach"},
    -- },
    --
    -- {
    --     "nvimdev/lspsaga.nvim",
    --     event = {"LspAttach"},
    -- }

}
