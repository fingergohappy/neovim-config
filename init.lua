local start_mode=vim.fn.getenv("NVIM_START_MODE")
if start_mode==vim.NIL then
    start_mode=1
end
vim.g.start_mode=tonumber(start_mode)
require 'config'
