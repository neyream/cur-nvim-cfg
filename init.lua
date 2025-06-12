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

require('lualine').setup()
vim.cmd("colorscheme embark")

-- Автоформатирование при сохранении
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.cpp", "*.hpp", "*.c", "*.h"},
  callback = function()
    -- Форматирование с гарантией 2 пробелов
    local config_path = vim.fn.findfile(".clang-format", ".;")
    local style = config_path ~= "" and "file" or "{BasedOnStyle: LLVM, IndentWidth: 2}"
    
    vim.cmd(":%!clang-format -style='" .. style .. "' --assume-filename=" .. vim.fn.expand("%"))
  end
})

-- Автосоздание .clang-format при открытии C++ файла
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = {"*.cpp", "*.hpp"},
  callback = function()
    if vim.fn.findfile(".clang-format", ".;") == "" then
      local config = {
        "BasedOnStyle: LLVM",
        "IndentWidth: 2",
        "TabWidth: 2",
        "UseTab: Never",
        "BreakBeforeBraces: Allman",
        "AllowShortFunctionsOnASingleLine: false"
      }
      local file = io.open(".clang-format", "w")
      if file then
        file:write(table.concat(config, "\n"))
        file:close()
        print("Created .clang-format with 2-space indentation")
      end
    end
  end
})

