eolmark.nvim - display end-of-line mark at current cursor line

# demo

![](assets/demo.gif)

i prefer using block cursor, but i often find it tricky to distinguish whether the character under the cursor at the end of a line is space or eol

the `listchars` option is a great solution, but enabling it to show eol marks for every line creates visual clutter that distracts me while editing

this plugin was created to address that problem by showing a subtle, single-line marker for eol — just where it matters, at the cursor line

# setup

## setup example 1:

```
require("eolmark").setup()
```

this uses default settings, which is equivalent to:

```
require("eolmark").setup({
	mark = "○",
	excluded_filetypes = {},
	excluded_buftypes = {},
})

vim.api.nvim_set_hl(0, "EolMark", {link = "NonText"})
```

## setup example 2:

```
require("eolmark").setup({
	mark = "$",
})
```

this displays the mark as `$`, leaves everything else as default

## setup example 3:

```
require("eolmark").setup({
	mark = "$",
	excluded_filetypes = {},
	excluded_buftypes = {
		"nofile",
		"terminal",
	},
})

vim.api.nvim_set_hl(0, "EolMark", {link = "LineNr"})
```

this displays the mark, but only when the `buftype` is neither `nofile` nor `terminal`

also changes the highlight group of the mark

## setup example 4:

if you are using `lazy.nvim`:

```
{
	"aidancz/eolmark",
	lazy = false,
	config = function()
		require("eolmark").setup()
		vim.api.nvim_set_hl(0, "EolMark", {link = "NonText"})
	end,
}
```
