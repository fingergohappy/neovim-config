return {
    -- snippets
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            {
                "saadparwaiz1/cmp_luasnip",
                dependencies = {
                    "L3MON4D3/LuaSnip",
                    dependencies = {
                        "rafamadriz/friendly-snippets",
                    }
                }
            },
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()

            local gen_key_map_from_define = function()
                local result = {}
                -- 补全和定义的按键的映射关系
                local func_maps = {
                    select_next_item = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    select_prev_item = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    scroll_doc_down  = cmp.mapping.scroll_docs(-4),
                    scroll_doc_up    = cmp.mapping.scroll_docs(-4),
                    complete         = cmp.mapping.complete(),
                    cancel_complete  = cmp.mapping.abort(),
                    confirm_item     = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    replace_complete = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }
                local defined_maps = require('config.keymaps').key_maps.plugin_maps.complete
                for func, ncmp_func in pairs(func_maps) do
                    local map_define = defined_maps[func]
                    result[map_define.lhs] = ncmp_func
                end
                return result
            end

            return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert(gen_key_map_from_define()),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = function(_, item)
                        local icons = require("config.ui-config").icons.kinds
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                sorting = defaults.sorting,
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        tag = "v0.9.1",
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            sync_install = true,
            auto_install = true,
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm"
                }
            },
            indent = {
                enable = true
            }

        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        -- enabled = false,
        -- event = { "BufReadPost", "BufNewFile" },
        dependencies  = {
            "nvim-treesitter/nvim-treesitter"
        },
        opts = {
            separator = '⋅',
            mode = "curosr",
            zindex = 50
        },
        config = function (LazyPlugin,opts)
            require("treesitter-context").setup(opts)
            vim.api.nvim_create_user_command('GoToContext',require("treesitter-context").go_to_context,{});
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        keys = {
            {"gcc",mode='n'},
            {"gbc",mode='n'},
            {"gc",mode='v'},
            {"gb",mode='v'},
        }
    },
    {
        "mhartington/formatter.nvim",
        name = "formatter",
        event = "BufWritePre",
        config = function(LazyPlugin,opts)
            local opts = {
                logging = true,
                log_level = vim.log.levels.WARNING,
                filetype = {
                    vue = {
                        require("formatter.filetypes.vue").prettier(),
                        _
                    },
                    c = {
                        require("formatter.filetypes.c").clangformat(),
                        _
                    }
                    -- defautl use lsp format
                    -- ["*"] = {
                    --     require("formatter.filetypes.any").remove_trailing_whitespace,
                    --     function()
                    --         vim.lsp.buf.format({async = true})
                    --     end
                    -- }
                }
            }
            require("formatter").setup(opts)
        end
    },
    -- {
    --    'stevearc/aerial.nvim', 
    --     event = {"VeryLazy"},
    --     opts = {
    --         backends = { "treesitter", "lsp", "markdown", "man" },
    --         -- backends = { "treesitter"},
    --         autojump = true,
    --         placement = "edge",
    --         filter_kind = false,
    --     }
    -- },
    {
        "simrat39/symbols-outline.nvim",
        event = {"LspAttach"},
        opts = {
            auto_preview = true,
            position = 'right',
        }
    }

}
