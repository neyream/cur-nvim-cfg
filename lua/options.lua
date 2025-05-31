--номера строк и curNum строки + убрать тильды
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.fillchars = {eob = " "}
-- clipboard
vim.opt.clipboard = "unnamedplus"

-- tab moment, плюсовики требуют 4, но для sp мне нравится 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- переделывает табы в спайс
vim.opt.autoindent =  true

--чота с цветом хззз
vim.opt.termguicolors = true

--чтобы не пришлось мотать срок
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8


