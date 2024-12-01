-- https://github.com/neovim/neovim/issues/29312
-- https://github.com/echasnovski/mini.nvim/issues/990

EolMark = {}



EolMark.setup = function(config)

EolMark.config = vim.tbl_deep_extend("force", require("eolmark/default_config"), config or {})

require("eolmark/default_highlight")

require("eolmark/main")

end



return EolMark
