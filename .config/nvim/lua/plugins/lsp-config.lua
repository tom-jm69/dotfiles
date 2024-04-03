return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"lua_ls",
				"ansiblels",
				"bashls",
				"html",
				"tflint",
				"terraformls",
				"yamlls",
				"pyright",
				"docker_compose_language_service",
				"dockerls",
				"marksman",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.tsserver.setup({
				capabilites = capabilities,
			})
			lspconfig.html.setup({
				capabilites = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilites = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.ansiblels.setup({
				capabilities = capabilities,
			})
			lspconfig.tflint.setup({
				capabilities = capabilities,
			})
			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
				settings = {
					yaml = {
						schemas = {
							-- https://www.schemastore.org/json/
							kubernetes = "*.yaml",
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/*.{yml,yaml}",
							["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
							["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = "*play*.{yml,yaml}",
							["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*.gitlab-ci.{yml,yaml}",
							["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
						},
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				filetypes = { "python" },
			})
			lspconfig.docker_compose_language_service.setup({
				capabilities = capabilities,
			})
			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})
			lspconfig.marksman.setup({
				capabilities = capabilities,
			})
			local opts = { noremap = true, silent = true }

			-- set keybinds
			opts.desc = "Show LSP references"
			vim.keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			vim.keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			vim.keymap.set({"n", "v"}, "ca", "<cmd>FzfLua lsp_code_actions<CR>", opts) -- show  See available code actions

			opts.desc = "Smart rename"
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			vim.keymap.set("n", "<leader>d", "<cmd>FzfLua diagnostics_document<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show workspace diagnostics"
			vim.keymap.set("n", "<leader>D", "<cmd>FzfLua diagnostics_document<CR>", opts) -- show diagnostic for workspace

			opts.desc = "Go to previous diagnostic"
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end,
	},
}
