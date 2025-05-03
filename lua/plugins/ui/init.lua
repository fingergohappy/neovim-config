local generate_keymaps = require("config.lazy.utils").generate_keymaps

return {
  {
    "loctvl842/monokai-pro.nvim",
    enabled = false,
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function(_, opts)
      require("monokai-pro").setup(opts)
      vim.cmd [[ colorscheme monokai-pro ]]
    end,
    opts = {

    }
  },
  {
    "catppuccin/nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd [[ colorscheme catppuccin ]]
    end,
    opts = {
      flavour = "latte",   -- latte, frappe, macchiato, mocha
    }
  },
  {
    "shellRaining/hlchunk.nvim",
    enabled = vim.g.start_mode == 1,
    event = { "UIEnter" },
    opts = {
      chunk = {

        style = {
          { fg = "#6d9c6f" },
          { fg = "#c21f30" }, -- this fg is used to highlight wrong chunk
        },
      },
    },
    --[[ config = function()
            require("hlchunk").setup({})
        end ]]
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "ahmedkhalf/project.nvim",
    },
    keys = function(_, keys)
      return generate_keymaps({
        { "file_tree", "toggle", "<cmd>NvimTreeToggle<cr>" },
      })
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
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
          },
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
          update_root = true,
        },
      }
    end,
  },

  {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
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
        enabled = true,              -- enables the Noice messages UI
        view = "notify",             -- default view for messages
        view_error = "notify",       -- view for errors
        view_warn = "notify",        -- view for warnings
        view_history = "messages",   -- view for :messages
        view_search = "virtualtext", --
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    enabled = false,
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
      background_colour = "#000000",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      -- background_colour = "NotifyBackground",
      -- render = "minimal"
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- enable = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        -- section_separators = { left = '', right = ''},
        section_separators = { left = "", right = "" },
        global_status = true,
      },
    },
  },
  {
    "echasnovski/mini.animate",
    version = "*",
    event = "BufEnter",
    opts = {},
  },
}
