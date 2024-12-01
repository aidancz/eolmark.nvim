local mark = {}

mark.ns_id = vim.api.nvim_create_namespace("eolmark")

mark.opts = {
	id = nil,
	virt_text = {{EolMark.config.mark, "EolMark"}},
	virt_text_pos = "overlay",
	hl_mode = "combine",
}

mark.set_mark = function()
	mark.opts.id = vim.api.nvim_buf_set_extmark(0, mark.ns_id, vim.fn.line(".") - 1, -1, mark.opts)
end

----------------------------------------------------------------

local H = {}

H.member_p = function(str, tbl)
	for _, value in ipairs(tbl) do
		if value == str then
			return true
		end
	end
	return false
end



vim.api.nvim_create_autocmd(
	{"BufEnter", "FileChangedShellPost"},
	{
		group = vim.api.nvim_create_augroup("eolmark0", {clear = true}),
		callback = function()
			if
				not H.member_p(vim.bo.filetype, EolMark.config.excluded_filetypes)
				and
				not H.member_p(vim.bo.buftype, EolMark.config.excluded_buftypes)
			then
				mark.set_mark()
				vim.api.nvim_create_autocmd(
					{"CursorMoved", "CursorMovedI"},
					{
						group = vim.api.nvim_create_augroup("eolmark1", {clear = true}),
						callback = mark.set_mark,
						buffer = 0,
					})
			end
		end,
	})
