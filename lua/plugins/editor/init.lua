return {
    -- telescope -todo
    {
        'nvim-telescope/telescope.nvim',
        version = false,
        -- tag = '0.1.x',
        -- branch = '0.1.x',
        -- or                              , branch = '0.1.x',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            {'nvim-telescope/telescope-live-grep-args.nvim',version = '^1.0.0'}
        },
        config = function(_, opts)
            local opts  = {
                extensions = {
                    fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },
                    live_grep_args = {
                        mappings = {
                            i = {
                                ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                                ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
                            },
                        }
                    }
                },
                defaults = {
                    mappings = {
                        n = {
                            d = require("telescope.actions").delete_buffer,
                            q = require("telescope.actions").close
                        }
                    }
                }
            }
            require('telescope').setup(opts)
            require("telescope").load_extension("projects")
            require("telescope").load_extension("live_grep_args")
        end,
        keys = function(_, keys)
            local func_map = {
                { 'finder', 'find_project_file',   '<Cmd>Telescope find_files<CR>' },
                { 'finder', 'find_buffer',         '<cmd>Telescope buffers<cr>' },
                { 'finder', 'find_current_buffer', '<cmd>Telescope buffers show_all_buffers=true<cr>' },
                { 'finder', 'find_command',        '<cmd>Telescope commands<cr>',                     '<cmd>Telescope commands<cr>' },
                { 'finder', 'find_mark',           '<cmd>Telescope marks<cr>' },
                { 'finder', 'find_resume',         '<cmd>Telescope resume<cr>' },
                { 'finder', 'find_project_grep',   '<cmd>Telescope live_grep_args<cr>' },
                -- todo
                { 'finder', 'find_tag',            '<Nop>' },
                { 'finder', 'find_root_file',      '<Nop>' },
            }
            return require('config.lazy.utils').generate_keymaps(func_map)
        end,
        -- opts = {
        --     extensions = {
        --         fzf = {
        --             fuzzy = true,                   -- false will only do exact matching
        --             override_generic_sorter = true, -- override the generic sorter
        --             override_file_sorter = true,    -- override the file sorter
        --             case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        --             -- the default case_mode is "smart_case"
        --         },
        --         live_grep_args = {
        --             mappings = {
        --                 i = {
        --                     ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
        --                     ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
        --                 }
        --             }
        --         }
        --     }
        -- }

    },
    --  project managers
    {
        "ahmedkhalf/project.nvim",
        opts = {},
        lazy = true,
        config = function(_, opts)
            require("project_nvim").setup(opts)
            -- for nvim-tree tips
            require('project_nvim.project').on_buf_enter()
        end,
        keys = function(_, keys)
            return require('config.lazy.utils').generate_keymaps({})
        end
    },
    -- {
    --     'echasnovski/mini.surround',
    --     event = "VeryLazy",
    --     version = "*",
    --     opts = function()
    --         local mappings = {}
    --         local mapping_func = {
    --             add = 'add_surrond',
    --             delete = 'delete_surrond',
    --             replace = 'replace_surrond'
    --         }
    --         local map_defines = require('config.keymaps').key_maps.plugin_maps.edit
    --         vim.print(map_defines)
    --         for func, map_define in pairs(mapping_func) do
    --             mappings[func] = map_defines[map_define].lhs
    --         end
    --         vim.print(mappings)
    --         return {
    --             mappings = mappings
    --         }
    --     end
    -- },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            search = {
                mode = 'fuzzy',
            },
            jump = {
                autojump = true
            }
        },
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
}
