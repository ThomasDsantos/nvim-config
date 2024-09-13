

-- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
-- treesitter, mason and typescript.nvim. So instead of the above, you can use:

-- add more treesitter parsers
return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"bash",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"sql",
			"go",
			"rust",
			"regex",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},
	},
}

