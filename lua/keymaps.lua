-- space bar leader key
vim.g.mapleader = " "

-- Бинды для перемещения в insert mode
vim.keymap.set('i', '<C-h>', '<Left>',  { noremap = true, silent = true })
vim.keymap.set('i', '<C-j>', '<Down>',  { noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', '<Up>',    { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })
