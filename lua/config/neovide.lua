vim.o.guifont="ComicShannsMono Nerd Font Mono:h18"
-- Helper function for transparency formatting
local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.0
vim.g.transparency = 0.95
vim.g.neovide_background_color = "#0f1117" .. alpha()

vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

vim.g.neovide_cursor_vfx_mode = "wireframe"
vim.g.neovide_cursor_animate_command_line = true

vim.g.neovide_underline_stroke_scale = 1.0


vim.cmd([[colorscheme tokyonight-night]])
-- vim.g.neovide_theme = 'auto'
