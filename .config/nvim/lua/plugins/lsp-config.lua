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
				"docker_compose_language_service",
				"dockerls",
				"marksman",
				"ruff",
        "qmlls",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- linter
					"ansible-lint", -- ansible
					"hadolint", -- dockerfile
					"mypy", -- python
					"ruff", -- python
					"selene", -- lua
					"shellcheck", -- bash
					"shellharden", -- bash
					"tflint", -- terraform
					"tfsec", -- terraform
					"trivy", -- a lot
					"stylua", -- lua
					"yamllint", -- yaml
					-- formatter
					"beautysh", -- bash
					"shfmt", -- bash
					"latexindent", -- latex
					"prettier", -- yaml,json
					"ruff", -- python
					"black", -- python
					"shellharden", -- bash
					"stylua", -- lua
					"yamlfmt", -- yaml
					-- # dap
					"bash-debug-adapter", -- bash
				},
			})
		end,
	},

	-- Keep nvim-lspconfig installed for its server definitions/defaults,
	-- but DO NOT call require('lspconfig').<server>.setup(...) anymore.
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} }, -- better Lua LS for Neovim
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Define per-server configs using the core API
			local servers = {
				html = {
					capabilities = capabilities,
				},
				lua_ls = {
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
						},
					},
				},
				bashls = {
					capabilities = capabilities,
				},
				ansiblels = {
					capabilities = capabilities,
				},
				tflint = {
					capabilities = capabilities,
				},
				terraformls = {
					capabilities = capabilities,
				},
				yamlls = {
					capabilities = capabilities,
					settings = {
						yaml = {
							schemas = {
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
				},
				ruff = {
					capabilities = capabilities,
					filetypes = { "python" },
				},
				docker_compose_language_service = {
					capabilities = capabilities,
				},
				dockerls = {
					capabilities = capabilities,
				},
				marksman = {
					capabilities = capabilities,
				},
			}

			-- Register each server config
			for name, cfg in pairs(servers) do
				vim.lsp.config(name, cfg)
			end

			-- Enable them (auto-starts on matching filetypes)
			vim.lsp.enable(vim.tbl_keys(servers))

			-- ── Keymaps (unchanged) ──────────────────────────────────────────────
			local opts = { noremap = true, silent = true }

			opts.desc = "Show LSP references"
			vim.keymap.set("n", "<leader>xr", "<cmd>FzfLua lsp_references<CR>", opts)

			opts.desc = "Smart rename"
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show LSP definitions"
			vim.keymap.set("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", opts)

			opts.desc = "Go to declaration"
			vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts)

			opts.desc = "See available code actions"
			vim.keymap.set({ "n", "v" }, "ca", "<cmd>FzfLua lsp_code_actions<CR>", opts)

			opts.desc = "Show documentation for what is under cursor"
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

			opts.desc = "Show LSP implementations"
			vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			vim.keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts)
		end,
	},

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ...",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
	},
}
