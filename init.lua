local M = require("eolmark/eolmark")

vim.api.nvim_set_hl(0, "EolExtmark", {link = "NonText"})



local excluded_filetypes = {
}

local excluded_buftypes = {
	"nofile",
	"terminal",
}

local member_p = function(str, tbl)
	for _, value in ipairs(tbl) do
		if value == str then
			return true
		end
	end
	return false
end



local eol_extmark_augroup = vim.api.nvim_create_augroup("eol_extmark", {clear = true})

vim.api.nvim_create_autocmd(
	{"BufEnter", "FileChangedShellPost"},
	{
		group = eol_extmark_augroup,
		callback = function(args)
			if
				not member_p(vim.bo.filetype, excluded_filetypes)
				and
				not member_p(vim.bo.buftype, excluded_buftypes)
			then
				M.show_at_cursor_line(args)
				vim.api.nvim_create_autocmd(
					{"CursorMoved", "CursorMovedI"},
					{
						group = eol_extmark_augroup,
						callback = M.show_at_cursor_line,
						buffer = 0,
					})
			end
		end,
	})
