-- Telescope Global remapping
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    winblend = 0,
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
    layout_config = {
      vertical = {
        width = 0.9,
      },
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<C-w>"] = "delete_buffer",
        },
        n = {
          ["<C-w>"] = "delete_buffer",
        },
      },
    },
    -- https://gitter.im/nvim-telescope/community?at=6113b874025d436054c468e6 Fabian David Schmidt
    find_files = {
      on_input_filter_cb = function(prompt)
        local find_colon = string.find(prompt, ":")
        if find_colon then
          local ret = string.sub(prompt, 1, find_colon - 1)
          vim.schedule(function()
            local prompt_bufnr = vim.api.nvim_get_current_buf()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local lnum = tonumber(prompt:sub(find_colon + 1))
            if type(lnum) == "number" then
              local win = picker.previewer.state.winid
              local bufnr = picker.previewer.state.bufnr
              local line_count = vim.api.nvim_buf_line_count(bufnr)
              vim.api.nvim_win_set_cursor(win, { math.max(1, math.min(lnum, line_count)), 0 })
            end
          end)
          return { prompt = ret }
        end
      end,
      attach_mappings = function()
        actions.select_default:enhance({
          post = function()
            -- if we found something, go to line
            local prompt = action_state.get_current_line()
            local find_colon = string.find(prompt, ":")
            if find_colon then
              local lnum = tonumber(prompt:sub(find_colon + 1))
              vim.api.nvim_win_set_cursor(0, { lnum, 0 })
            end
          end,
        })
        return true
      end,
    },
  },
})

vim.api.nvim_exec(
  [[
nmap <C-p> :lua require("telescope.builtin").find_files(require("telescope.themes").get_ivy({}))<cr>
nmap <C-o> :lua require("telescope.builtin").file_browser(require("telescope.themes").get_ivy({}))<cr>
nmap <C-a> :lua require("telescope.builtin").buffers(require("telescope.themes").get_ivy({}))<cr>

nmap <leader>tc :lua require("telescope.builtin").colorscheme(require("telescope.themes").get_ivy({}))<cr>
nmap <leader>tt :lua require("telescope.builtin").tags(require("telescope.themes").get_ivy({}))<cr>

nmap <leader>rg :lua require("telescope.builtin").live_grep(require("telescope.themes").get_ivy({}))<cr>
nmap <leader>tr :lua require("telescope.builtin").registers()<cr> 
nmap <leader>tj :lua require("telescope.builtin").help_tags()<cr>
nmap <leader>ts :lua require("telescope.builtin").spell_suggest()<cr>

nmap <leader>git :lua require("telescope.builtin").git_status(require("telescope.themes").get_ivy({}))<cr>

nmap <leader>lr :lua require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy({}))<cr>
nmap <leader>ls :lua require("telescope.builtin").lsp_document_symbols(require("telescope.themes").get_ivy({}))<cr>
nmap <leader>la :lua require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_ivy({}))<cr>
]],
  true
)
