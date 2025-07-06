local cmp = require "cmp"
local luasnip = require "luasnip"

-- Better completion
vim.o.completeopt = "menuone,noselect"

cmp.setup {
	snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
	mapping = cmp.mapping.preset.insert {
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete {},
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		},
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, {"i", "s"})
	},
	sources = {
		{ name = "nvim_lsp", group_index = 2 },
	}
}
