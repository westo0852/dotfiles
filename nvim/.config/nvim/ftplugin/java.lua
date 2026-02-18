-- local function print_temp(msg)
-- 	print(msg)
-- 	vim.defer_fn(function()
-- 		vim.cmd("echo ''")
-- 	end, 3000)
-- end

local jdtls = require("jdtls")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use on_attach from lsp.lua
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
	-- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	nmap("<leader>g?", vim.diagnostic.open_float, "Show error message in floating window")
end

-- Assume project root where any of these are
local project_root = require("jdtls.setup").find_root({
	"gradlew",
	"mvnw",
	"pom.xml",
	".git",
})

if not project_root then
	-- print_temp("not a java project. defaulting to current working directory")
	project_root = vim.fn.getcwd()
end

local project_name = vim.fn.fnamemodify(project_root, ":p:t")

-- Set jdtls workspace dir in ~/.local/share/nvim/jdtls-workspaces/<dir_name>
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

local config = {
	-- Call jdtls script + lombok for code gen in spring projects
	-- TODO Try other GCs?
	cmd = {
		"jdtls",
		"-data",
		workspace_dir,
		"--jvm-arg=-javaagent:" .. vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
	},
	root_dir = project_root,
	on_attach = on_attach,
	capabilities = capabilities,
}

jdtls.start_or_attach(config)
