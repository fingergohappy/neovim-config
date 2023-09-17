
return {
    -- telescope
    -- -todo  
    {
        'nvim-telescope/telescope.nvim',
        version = false,
        -- tag = '0.1.x',
        -- branch = '0.1.x',
        -- or                              , branch = '0.1.x',
        dependencies = {
            { 'nvim-lua/plenary.nvim'},
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function(_,opts)
            require('telescope').setup(opts)
            require("telescope").load_extension("projects")
        end,
        keys = function (_,keys)
            local func_map = {
                {'finder','find_project_file','<Cmd>Telescope find_files<CR>'},
                {'finder','find_buffer','<cmd>Telescope buffers<cr>'},
                {'finder','find_current_buffer','<cmd>Telescope buffers show_all_buffers=true<cr>'},
                {'finder','find_command','<cmd>Telescope commands<cr>','<cmd>Telescope commands<cr>'},
                {'finder','find_mark','<cmd>Telescope marks<cr>'},
                {'finder','find_resume','<cmd>Telescope resume<cr>'},
                {'finder','find_project_grep','<cmd>Telescope live_grep<cr>'},
                -- todo
                {'finder','find_tag','<Nop>'},
                {'finder','find_root_file','<Nop>'},
            }
            return require('config.lazy.utils').generate_keymaps(func_map)
        end,
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        }

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
    keys = function(_,keys)
        return require('config.lazy.utils').generate_keymaps({})
    end
  }
}
