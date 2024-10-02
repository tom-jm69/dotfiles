return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
      require('mason-tool-installer').setup({
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
          "gopls", -- go
          "bash-debug-adapter", -- bash
          "hclfmt" -- tf hcl
        }
      })
		end,
	},
}
