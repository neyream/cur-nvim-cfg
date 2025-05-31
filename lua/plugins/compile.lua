
  function _G.compile_and_run()
    -- Сохраняем путь к исходному файлу ДО открытия терминала
    if vim.bo.filetype ~= "cpp" then
        print("Только для C++ файлов!")
        return
    end
    local source_file = vim.fn.expand("%")
    local output_file = vim.fn.expand("%<")

    local current_win = vim.api.nvim_get_current_win()
    vim.cmd("botright 8 split | terminal")
    local term_buf = vim.api.nvim_get_current_buf()

    -- Используем сохранённые пути
    local cmd = string.format(
        "clang++ -fstandalone-debug -g -std=c++17 %s -o 'main' && exit\n",
        vim.fn.shellescape(source_file),
        vim.fn.shellescape(output_file),
        vim.fn.shellescape(output_file)
    )

    vim.api.nvim_chan_send(
        vim.api.nvim_buf_get_var(term_buf, "terminal_job_id"),
        cmd
    )
    vim.api.nvim_set_current_win(current_win)
end

vim.keymap.set("n", "<leader>co", "<cmd>lua compile_and_run()<CR>")

