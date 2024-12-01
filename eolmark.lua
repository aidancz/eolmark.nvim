-- https://github.com/echasnovski/mini.nvim/issues/990

local M = {}

M.ns_id = vim.api.nvim_create_namespace("eolmark")

M.opts = {
	id = nil,
	virt_text = {{"○", "EolExtmark"}},
	virt_text_pos = "overlay",
	hl_mode = "combine",
}

M.show_at_cursor_line = function(args)
	M.opts.id = vim.api.nvim_buf_set_extmark(args.buf, M.ns_id, vim.fn.line(".") - 1, -1, M.opts)
end

return M
