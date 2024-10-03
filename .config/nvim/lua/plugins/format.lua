return {
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					json = { "prettier" },
					markdown = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					tex = { "latexindent" },
					typst = { "typstfmt" },
					lua = { "stylua" },
					sh = { "beautysh" },
					terraform = { "terraform_fmt" },
					yaml = { "yamlfmt", "prettier" },
					-- python = { "isort", "black" },
					python = { "isort", "ruff_fix", "ruff_organize_imports" , "pylint" },
					go = { "goimports", "gofmt" },
          hcl = { "hclfmt" },
          sql = { "sql-formatter" },
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>tf", function()
				conform.format({
					lsb_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file of range in (in visual mode)" })
		end,
	},
}
