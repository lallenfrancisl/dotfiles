-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.opt.equalalways = false
vim.g.python3_host_prog = vim.fn.expand "~/.local/share/nvim/python-provider/bin/python"

vim.g.node_host_prog = vim.fn.expand "~/.local/share/nvim/node-provider/node_modules/neovim/bin/cli.js"

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- vim.o.foldcolumn = "1"
-- vim.opt.fillchars = {
--   foldopen = " ",
--   foldclose = "-",
--   foldsep = " ",
--   foldinner = " ",
-- }
