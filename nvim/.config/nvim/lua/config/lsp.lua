require("mason").setup()

-- Install language servers
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"gopls",
		"pyright",
		"clangd",
		-- "jdtls",
	},
	automatic_installation = false,
})

-- Install formatters
require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"gofumpt",
		"goimports",
		"shfmt",
		"prettier",
		"black",
		"clang-format",
	},
	run_on_start = false, -- Use :MasonToolsUpdate or :MasonToolsInstall
})

-- LSP defaults and keymaps
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("<leader>gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("<leader>gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	nmap("<leader>g?", vim.diagnostic.open_float, "Show error message in floating window")
end

-- Enable language servers with defaults
local function default_lsp_setup(module)
	vim.lsp.config(module, {
		on_attach = on_attach,
		capabilities = capabilities,
	})
	vim.lsp.enable(module)
end

-- Golang
default_lsp_setup("gopls")

-- Java: Use nvim-jdtls via ftplugin instead
-- default_lsp_setup("jdtls")

-- C/C++
default_lsp_setup("clangd")

-- Python
default_lsp_setup("pyright")

-- Lua
vim.lsp.config("lua_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",

				-- Find Lua modules the same way as nvim, see :h lua-module-load
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})
vim.lsp.enable("lua_ls")
