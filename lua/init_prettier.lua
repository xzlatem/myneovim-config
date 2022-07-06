local prettier = function()
  return {
    exe = "prettier",
    --args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--double-quote", "--tab-width", "4", "--print-width", "120" },
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
    stdin = true,
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    javascript = { prettier },
    typescript = { prettier },
    html = { prettier },
    css = { prettier },
    scss = { prettier },
    markdown = { prettier },
    svelte = { prettier },
    vue = { prettier },
    cpp = {
      function()
        return {
          exe = "clang-format",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = true,
        }
      end,
    },
    lua = {
      -- Stylua
      function()
        return {
          exe = "stylua",
          args = { "--indent-width", 2, "--indent-type", "Spaces" },
          stdin = false,
        }
      end,
    },
    python = {
      function()
        return {
          exe = "black",
          stdin = false,
        }
      end,
    },
  },
})

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.css,*.scss,*.md,*.html,*.lua,*.py : FormatWrite
augroup END

autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500)
]],
  true
)
