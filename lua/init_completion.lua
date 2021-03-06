-- SNIPPETS
vim.o.completeopt = "menuone,noselect"
-- luasnip setup

local function prequire(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

local luasnip = prequire("luasnip")

--
-- AUTOCOMPLETION using nvim-cmp
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "calc" },
  },
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
--_G.tab_complete = function()
--if vim.fn.pumvisible() == 1 then
--return t("<C-n>")
--elseif check_back_space() then
--return t("<Tab>")
--else
--return vim.fn["compe#complete"]()
--end
--end
--_G.s_tab_complete = function()
--if vim.fn.pumvisible() == 1 then
--return t("<C-p>")
--else
--return t("<S-Tab>")
--end
--end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-n>")
  elseif luasnip and luasnip.expand_or_jumpable() then
    return t("<Plug>luasnip-expand-or-jump")
  elseif check_back_space() then
    return t("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-p>")
  elseif luasnip and luasnip.jumpable(-1) then
    return t("<Plug>luasnip-jump-prev")
  else
    return t("<S-Tab>")
  end
end

vim.api.nvim_set_keymap("i", "<C-x>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
vim.api.nvim_set_keymap("i", "<C-k>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<C-k>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<C-l>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<C-l>", "v:lua.s_tab_complete()", { expr = true })

require("luasnip/loaders/from_vscode").load({ paths = { "./plugged/friendly-snippets" } })

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
