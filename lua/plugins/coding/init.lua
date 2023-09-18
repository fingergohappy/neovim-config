return {
    -- snippets
    {
        "L3MON4D3/LuaSnip",
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
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
        opts = {
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = {
                "bash",
                "c",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "luadoc",
                "luap",
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

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = true,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            -- List of parsers to ignore installing (or "all")
            -- ignore_install = { "javascript" },

            ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
                enable = true,

                -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                -- the name of the parser)
                -- list of language that will be disabled
                -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
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
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = function()
            -- k: custom define func v: plugin define func
            local func_maps = {
                comment = 'comment',
                comment_line = 'comment_line',
                comment_text_object = 'textobject',
            }
            local map_defines = require('config.keymaps').key_maps.plugin_maps.code
            local mappings = {}
            for k, v in pairs(func_maps) do
                local map_define = map_defines[k]
                mappings[v] = map_define.lhs
            end
            return {
                mappings = mappings
            }
        end
    },
}
