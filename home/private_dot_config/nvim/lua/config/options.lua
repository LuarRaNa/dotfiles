vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.clipboard = "unnamedplus"

vim.opt.virtualedit = "block"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.opt.wrap = false

vim.opt.diffopt = { "vertical", "internal", "linematch:120", "algorithm:histogram" }

vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
