local o = vim.o
local go = vim.go
local bo = vim.bo
local wo = vim.wo
local g = vim.g
local opt = vim.opt
-- linenumber
o.number = true
go.scrolloff = 5
go.sidescrolloff = 5
wo.relativenumber=true
wo.numberwidth=1

-- curosr line
wo.cursorline=true
wo.cursorlineopt='screenline'
wo.signcolumn='yes'
wo.colorcolumn='120'

-- config tab wdith 
opt.tabstop=4
opt.softtabstop=4
opt.shiftwidth=4
opt.expandtab=true

-- autointent
bo.autoindent=true
bo.smartindent=true

go.smartcase=true
go.ignorecase=true


go.hidden=true
vim.opt_global.completeopt:append({'noselect','noinsert'})

go.termguicolors=true

wo.list=true
-- go.listchars="space:·"


bo.formatoptions = "jcroqlnt"
go.shiftround = true
go.pumblend = 10
go.pumheight = 10

opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
-- leader
g.mapleader = " "



-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
