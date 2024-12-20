return {
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		build = "make install_jsregexp",
		enabled = vim.g.start_mode == 1,
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
		-- version = false, -- last release is way too old
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"zbirenbaum/copilot-cmp",
		},
		opts = {},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "copilot" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		enabled = false,
		build = ":TSUpdate",
		-- event = { "BufReadPost", "BufNewFile" ,"BufEnter"},
		event = { "syntax" },
		tag = "v0.9.2",
		-- enabled=vim.g.start_mode==1,
		opts = {
			ensure_installed = {
				"bash",
				"c",
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
				"sql",
			},
			sync_install = true,
			auto_install = true,
			highlight = {
				enable = true,
				-- disable = function(lang, buf)
				-- local max_filesize = 100 * 1024 -- 100 KB
				-- local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				-- if ok and stats and stats.size > max_filesize then
				--     return true
				-- end
				-- end,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			indent = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		-- enabled = false,
		-- event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			separator = "⋅",
			mode = "curosr",
			zindex = 50,
		},
		config = function(LazyPlugin, opts)
			require("treesitter-context").setup(opts)
			vim.api.nvim_create_user_command("GoToContext", require("treesitter-context").go_to_context, {})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		keys = {
			{ "gcc", mode = "n" },
			{ "gbc", mode = "n" },
			{ "gc", mode = "v" },
			{ "gb", mode = "v" },
		},
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- ["*"] = { "codespell" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		event = { "LspAttach" },
		opts = {
			auto_preview = true,
			position = "right",
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = {
				enabled = true,
				keymap = {
					accept = "<C-L>",
				},
			},
			panel = { enabled = true },
			filetypes = {
				-- markdown = true,
				-- help = true,
				["*"] = true,
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = "copilot.lua",
		opts = {},
		config = function(_, opts)
			local copilot_cmp = require("copilot_cmp")
			copilot_cmp.setup(opts)
			-- attach cmp source whenever copilot attaches
			-- fixes lazy-loading issues with the copilot cmp source
			-- LazyVim.lsp.on_attach(function(client)
			--     if client.name == "copilot" then
			--         copilot_cmp._on_insert_enter({})
			--     end
			-- end)
		end,
	},
}
