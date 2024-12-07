-- https://github.com/neovim/neovim/issues/29312
-- https://github.com/echasnovski/mini.nvim/issues/990

local M = {}

-- # setup

M.setup = function(config)

M.config = vim.tbl_deep_extend("force", M.config, config or {})

M.create_autocmd()

end

-- # config

M.config = {
	excluded_filetypes = {},
	excluded_buftypes = {},
	opts = {
		id = nil,
		virt_text = {{"○", "NonText"}},
		virt_text_pos = "overlay",
		hl_mode = "combine",
		priority = 0,
	},
}

-- # mark

M.ns_id = vim.api.nvim_create_namespace("eolmark")

M.set_mark = function()
	M.config.opts.id = vim.api.nvim_buf_set_extmark(0, M.ns_id, vim.fn.line(".") - 1, -1, M.config.opts)
end

-- # autocmd

local H = {}

H.excluded_filetype_p = function()
	for _, pattern in pairs(M.config.excluded_filetypes) do
		if string.find(vim.bo.filetype, pattern) then
			return true
		end
	end
	return false
end

H.excluded_buftype_p = function()
	for _, pattern in pairs(M.config.excluded_buftypes) do
		if string.find(vim.bo.buftype, pattern) then
			return true
		end
	end
	return false
end

M.create_autocmd = function()
	vim.api.nvim_create_autocmd(
		{
			"BufEnter",
			"FileChangedShellPost",
		},
		{
			group = vim.api.nvim_create_augroup("eolmark0", {clear = true}),
			callback = function()
				----------------------------------------------------------------
				vim.schedule(function()
				-- https://github.com/neovim/neovim/issues/29419
				----------------------------------------------------------------
				if
					not H.excluded_filetype_p()
					and
					not H.excluded_buftype_p()
				then
					M.set_mark()
					vim.api.nvim_create_autocmd(
						{
							"CursorMoved",
							"CursorMovedI",
						},
						{
							group = vim.api.nvim_create_augroup("eolmark1", {clear = true}),
							callback = M.set_mark,
							buffer = 0,
						})
				end
				----------------------------------------------------------------
				end)
				----------------------------------------------------------------
			end,
		})
end

-- # return

return M
