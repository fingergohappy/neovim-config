local generate_keymaps = require('config.lazy.utils').generate_keymaps

return {
    -- catppuccin
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        name = "catppuccin",
        opts = {
            flavour = "mocha",
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
        keys = function(_,keys)
            local a = generate_keymaps({
                {"file_tree","toggle","<cmd>NvimTreeToggle<cr>"}
            })
            return a
        end,
        config = function(_,opts)
            require('nvim-tree').setup(opts)
        end,
        opts = function(_,opts)
            -- 获取当前终端的高和宽
            local win_height = vim.fn.winheight(o)
            local win_width = vim.fn.winwidth(o)
            local width = math.floor(win_width * 0.4)
            local height = math.floor(win_height * 0.8)
            local row = math.floor(win_height* 0.05)
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
}
