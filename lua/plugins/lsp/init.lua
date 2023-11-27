return {
    {
        "neovim/nvim-lspconfig",
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function() 
            require("mason").setup{}
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        -- enabled = false,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            local lang_config = require("plugins.lsp.servers")
            local lsp_config = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require("mason-lspconfig").setup{
                handlers = {function(server_name)
                    local server_setting = vim.tbl_get(server_name)
                    local setup = {
                        capabilities = capabilities
                    }
                    if(server_name) then
                        setup['settings'] = server_setting
                    end 
                    lsp_config[server_name].setup(setup)
                end
                }
            }
        end
    },
    {
        'nvimdev/lspsaga.nvim',
        event = {"LspAttach"},
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        opts ={

        }
    }
}
