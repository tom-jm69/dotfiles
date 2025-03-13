return {
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufreadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linter_by_ft = {
				dockerfile = { "hadolint" },
				go = { "golangcilint" },
				lua = { "selene", "luacheck" },
				sh = { "shellcheck" },
				yaml = { "yamllint" },
				dist = { "yamllint" },
				ansible = { "ansible_lint" },
				terraform = { "tfsec", "tflint" },
				python = { "pylint", "pydocstyle" },
				markdown = { "markdownlint" },
				hclfmt = { "tfsec", "tflint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				pattern = { "*.hcl", "*.tf", "*.py", "*.sh", "*.yaml", "*.yml", "*.go", "*.md", "*.lua", "*yaml.dist" },
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
}
