require 'config.options'
require 'config.commands'
require 'config.highlight'
require 'config.lazy'



-- init basick maps
local key_maps = require 'config.keymaps'
key_maps.init_basic_maps()
-- set color scheme
-- vim.cmd([[colorscheme  catppuccin]])
-- vim.cmd [[colorscheme tokyonight-storm]]
-- vim.cmd([[colorscheme  cyberdream]])

vim.cmd([[colorscheme  dracula]])

-- 放到最后面,防止默认的覆盖
if vim.g.neovide then
    require 'config.neovide'
end
