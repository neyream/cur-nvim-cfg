require("plugins.lazy")
require("plugins.keymaps")
require("plugins.options")
-- require("plugins.none-ls")
require("plugins.compile")
require("plugins.bufferline")
require("plugins.diagn")
require("plugins.dap")
require("plugins.autocpp")
require("keymaps")
require("options")
require('competitest').setup()
require('lualine').setup()
vim.cmd("colorscheme embark")

-- Автоформатирование при сохранении


-- Автосоздание .clang-format при открытии C++ файла

