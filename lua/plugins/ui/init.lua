local generate_keymaps = require('config.lazy.utils').generate_keymaps

return {
    -- catppuccin
    {
        "folke/tokyonight.nvim",
        lazy = false,
        dependencies = {
            -- "nvim-lualine/lualine.nvim",
            "nvim-tree/nvim-web-devicons",
            -- "utilyre/barbecue.nvim",
            -- "SmiteshP/nvim-navic",
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            -- require('lualine').setup({
            --     options = {
            --         theme = 'tokyonight'
            --     },
            -- })
            -- require('barbecue').setup {
            --     theme = 'tokyonight',
            -- }
        end,
        opts = {
            style = "storm",
            transparent = true,
            terminal_colors = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent"
            }
        }
    },
    {
        "catppuccin/nvim",
        lazy = true,
        priority = 1000,
        name = "catppuccin",
        opts = {
            flavour = "macchiato",
            transparent_background = true,
            integrations = {
                alpha = true,
                cmp = true,
                flash = true,
                gitsigns = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                lsp_trouble = true,
                mason = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                noice = true,
                notify = true,
                nvimtree = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                which_key = true,
            },
        },
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {
            style = "night",
            transparent = true,
            terminal_colors = true,
            sidebars = { "help" },
            styles = {
                sidebars = "transparent",
                comments = { italic = true }
            }
        }
    },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = true,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "ahmedkhalf/project.nvim"
        },
        keys = function(_, keys)
            return generate_keymaps({
                { "file_tree", "toggle", "<cmd>NvimTreeToggle<cr>" }
            })
        end,
        config = function(_, opts)
            require('nvim-tree').setup(opts)
        end,
        opts = function(_, opts)
            -- 获取当前终端的高和宽
            local win_height = vim.fn.winheight(o)
            local win_width = vim.fn.winwidth(o)
            local width = math.floor(win_width * 0.4)
            local height = math.floor(win_height * 0.8)
            local row = math.floor(win_height * 0.05)
            local col = math.floor(win_width * 0.3)
            return {
                sort_by = "case_sensitive",
                view = {
                    width = 30,
                    float = {
                        enable = true,
                        quit_on_focus_loss = true,
                        open_win_config = {
                            relative = "editor",
                            border = "rounded",
                            width = width,
                            height = height,
                            row = row,
                            col = col,
                        },
                    }
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true
                },
            }
        end
    },


    {
        "folke/noice.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
            messages = {
                -- NOTE: If you enable messages, then the cmdline is enabled automatically.
                -- This is a current Neovim limitation.
                enabled = true,  -- enables the Noice messages UI
                view = "notify", -- default view for messages
                view_error = "notify", -- view for errors
                view_warn = "notify", -- view for warnings
                view_history = "messages", -- view for :messages
                view_search = "virtualtext", --
            }
        }
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        dependencies = {
            "folke/noice.nvim"
        },
        keys = {
            {
                "<leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss all Notifications",
            },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },
    -- better vim.ui
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },
    { 
        "MunifTanjim/nui.nvim",
        event = "VeryLazy" ,
    },

}
