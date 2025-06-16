-- space bar leader key
vim.g.mapleader = " "

-- Бинды для перемещения в insert mode
-- vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })
-- vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })
--
-- бинд для автоматического закрытия интерфейса дебаггера
vim.keymap.set("n", "<leader>ds", function()
	require("dap").close()
	require("dapui").close()
end)
-- бинд для выхода на esc из режима терминала
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})
