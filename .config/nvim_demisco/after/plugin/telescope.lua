require('telescope').setup()
local builtin = require('telescope.builtin')

--vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>f', builtin.find_files, {})
vim.keymap.set('n', '<Space>g', builtin.live_grep, {})
vim.keymap.set("n", "<leader>\\", builtin.buffers, {})
vim.keymap.set('n', '<Space>/', builtin.help_tags, {})
