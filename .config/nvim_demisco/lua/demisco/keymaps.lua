vim.g.mapleader = ' '

-- Shorten function name
local keymap = vim.keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Quick actions 
keymap.set("n", "<C-s>", ":w<CR>")
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Navigate buffers
keymap.set("n", "<S-n>", ":bnext<CR>")
keymap.set("n", "<S-h>", ":bprevious<CR>")

keymap.set('n', '<leader>c', ':bd<cr>')
keymap.set('n', '<leader>h', ':nohlsearch<CR>')
keymap.set('n', '<leader>o', ':e ~/.config/nvim/init.lua<CR>')
keymap.set('n', '<leader>r', ':source %<CR>')

-- Merge lines
keymap.set("n", "J", "mzJ`z")

-- Keep focus
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
--keymap.set("n", "N", "Nzzzv")


-- Move selected block
keymap.set("v", "A", ":m '>+1<CR>gv=gv")
keymap.set("v", "I", ":m '<-2<CR>gv=gv")
keymap.set("x", "A", ":m '>+1<CR>gv-gv")
keymap.set("x", "I", ":m '<-2<CR>gv-gv")
-- Stay in indent mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Copy paste but do not replace register
keymap.set("x", "<leader>p", [["_dP]])
