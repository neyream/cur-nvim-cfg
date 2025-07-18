vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.cpp",
	callback = function()
		-- Проверяем что файл действительно новый и пустой
		if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
			-- Шаблонный код
			local template = {
				"#include <bits/stdc++.h>",
        "",
				"using namespace std;",
				"",
        "#define ll long long",
        "#define uscor ios::sync_with_stdio(0); cin.tie(0); cout.tie(0);",
        "#define mod7 int(1e9 + 7)",
        "#define mod9 int(1e9 + 9)",
        "#define pi pair<int, int>",
        "#define um unordered_map",
        "",
				"int main()",
				"{",
				"  ",
				"  return 0;",
				"}",
			}

			-- Вставляем строки в буфер
			vim.api.nvim_buf_set_lines(0, 0, -1, false, template)

			-- Устанавливаем курсор в позицию для начала написания кода
			vim.api.nvim_win_set_cursor(0, { 9, 4 })
		end
	end,
})
