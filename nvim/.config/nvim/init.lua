-- Basic Neovim Configuration
-- Replace this folder with your complete Neovim config (e.g., LazyVim, Kickstart, or custom)

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- System clipboard integration (crucial across Mac and Linux)
vim.opt.clipboard = "unnamedplus"

-- Indentation defaults
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Colors & UI
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- Set leader key to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
