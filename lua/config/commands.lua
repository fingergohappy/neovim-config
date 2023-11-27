


-- to fix bug :https://github.com/nvim-telescope/telescope.nvim/issues/699
-- wait telescope update
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     pattern = { "*" },
--     command = "normal zx",
-- })


local formatAutoGroup = vim.api.nvim_create_augroup("FormatAutoGroup",{clear = true})




--     _   _   _ _____ ___         ____ ___  __  __ __  __    _    _   _ ____  
--    / \ | | | |_   _/ _ \       / ___/ _ \|  \/  |  \/  |  / \  | \ | |  _ \ 
--   / _ \| | | | | || | | |_____| |  | | | | |\/| | |\/| | / _ \ |  \| | | | |
--  / ___ \ |_| | | || |_| |_____| |__| |_| | |  | | |  | |/ ___ \| |\  | |_| |
-- /_/   \_\___/  |_| \___/       \____\___/|_|  |_|_|  |_/_/   \_\_| \_|____/ 
                                                                            

vim.api.nvim_create_autocmd({"BufWritePost"},{pattern = {"*"},command = "FormatWrite"})






--   ____ ___  __  __ __  __    _    _   _ ____  
--  / ___/ _ \|  \/  |  \/  |  / \  | \ | |  _ \ 
-- | |  | | | | |\/| | |\/| | / _ \ |  \| | | | |
-- | |__| |_| | |  | | |  | |/ ___ \| |\  | |_| |
--  \____\___/|_|  |_|_|  |_/_/   \_\_| \_|____/ 
--                                               
vim.api.nvim_create_user_command('TreesitterContext', function() require("lazy").load({plugins = {"nvim-treesitter-context"}}) end, {})
-- vim.api.nvim_create_user_command("Outline",[[AerialToggle right]],{})
vim.api.nvim_create_user_command("Outline",[[SymbolsOutline]],{})
