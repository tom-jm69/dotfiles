return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-macchiato")
			-- vim.cmd.colorscheme "catppuccin-latte"
		end,
	},
}
