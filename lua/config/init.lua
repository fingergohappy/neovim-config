require("config.options")
require("config.commands")
require("config.highlight")
require("config.lazy")

-- init basick maps
local key_maps = require("config.keymaps")
key_maps.init_basic_maps()
-- set color scheme
-- vim.cmd([[colorscheme  catppuccin]])
-- vim.cmd [[colorscheme tokyonight-storm]]
--
-- vim.cmd([[colorscheme solarized]])

-- vim.cmd([[colorscheme  tokyonight-moon]])
-- vim.cmd([[colorscheme  catppuccin-macchiato]])
-- vim.cmd([[colorscheme  catppuccin-latte]])

-- vim.cmd([[colorscheme  tokyonight-day]])



-- 放到最后面,防止默认的覆盖
if vim.g.neovide then
  require("config.neovide")
end
