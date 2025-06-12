vim.g.mapleader = " "

-- telescope
vim.keymap.set('n', '<leader>fs', ':Telescope find_files<cr>')
--vim.keymap.set('n', '<leader>fp', ':Telescope git_files<cr>')
vim.keymap.set('n', '<leader>fz', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<cr>')

--neotree
 vim.keymap.set('n', '<leader>nt', ':Neotree float<cr>')

-- comments
vim.keymap.set({'n', 'v'}, '<leader>/', ':CommentToggle<cr>')
-- formatting
vim.keymap.set('n', '<leader>fmd', vim.lsp.buf.format)

vim.keymap.set('n', '<leader>ccw', ':BufferLinePickClose<cr>')
