# Neovim Config with LSP and Treesitter

My previous Neovim setup used coc and it worked really well. Most of the things worked great, such as autocompletion, language server, snippets, prettier and other IDE-like experience on top of Neovim. I was happy until I found that one vim window with coc would start a `node` process that ate at least 400mb of RAM, and one time I saw it ate almost 1Gb RAM. To make it worst, I have the habbit to keep a few vim window open accross tmux panes. Thus I knew why my laptop froze often and I needed to find an alternative for coc.

## Plugin Choice

Many people likes to make neovim looks like graphical IDE, with icons, statusline and powerlines symbol. It sure looks great, but my favourite fonts (terminus (bitmap) and code new roman), doesn't have a very good support for powerline symbols. Also, I feel that these cosmetics doesn't really add much to my productivity. Therefore I decided not to install any cosmetics plugins such as `webdevicons` or other fancy statusline.

Some other intentional decisions I made due to practicality:

### init.vim instead of init.lua

Most article on the internet promotes using `init.lua`, but I found it is not practical for me because it still needs to call vim script to make mapping and other things, and I cannot reload it with `source %`. Besides most plugins can still be loaded from `init.vim`, also I can still modularized my plugin by calling `lua require('<lua_init_file>')`.

### fzf.vim instead of telescope

I admit telescope is really great, it has a lot of features that can replace both `fzf.vim` and `nerdtree`. However, I can't use telescope due to:

- Opening file browser don't give me a clue about the folder structure
- When working with deeply nested folder structure, it either show filename or foldername. Using `hidden` will not show file name, `tail` will not show folder name, `absolute` will only show truncated path that effectively don't show file name, `shorten` and `absolute` combo show file name but the path is only the first character, that makes it hard to grasp what folder this file is in.
- Typing full file name doesn't necessarily put the cursor on the file I want to open.

Until these minor issues fixed, I will still use `fzf` and `nerdtree` combo.

### Fugitive instead of telescope

I am comfortable using fugitive and most of my use case is already covered. Telescope might be better, but I like fugitive. :D

## Some Adjustment

### PHP indenting not working

When using `Treesitter` editing php file will be painful because the indentation doesn't work. To remedy that, create `~/.config/nvim/after/indent/php.vim`

```
setlocal indentexpr =
setlocal autoindent
setlocal smartindent
```

### Tokyonight Colorscheme line number is unreadable

Tokyonight is a great colorscheme that support lsp and other goodies. However the line number is unreadable due to very low contrast. To fix that edit `~/.config/nvim/plugged/tokyonight.nvim/lua/tokyonight/theme.lua` and change the following lines:

```
    LineNr = { fg = c.dark5 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr = { fg = c.fg_dark }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
```
