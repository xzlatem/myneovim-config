# Shortcuts

## Basic Keymap

|   Mode   | KeyStroke  | Actions                                            |
| :------: | :--------: | :------------------------------------------------- |
| nnoremap |   <C-l>    | Move cursor to right window                        |
| nnoremap |   <C-j>    | Move cursor to under window                        |
| nnoremap |   <C-k>    | Move cursor to upper window                        |
| nnoremap |   <C-h>    | Move cursor to left window                         |
| nnoremap |     tt     | Open terminal window at bottom with 7 lines weight |
| nnoremap |     vv     | Open terminal on the right side                    |
| nnoremap | <leader>ff | Open a new terminal tab                            |
| tnoremap | <esc><esc> | Exit terminal insert window                        |
| nnoremap | <leader>js | Set filetype to javascript                         |
| nnoremap | <leader>jh | Set filetype to HTML                               |
| nnoremap | <leader>jp | Set filetype php                                   |
| nnoremap | <leader>jo | Set filetype json                                  |
| nnoremap | <leader>jd | Set filetype htmldjango                            |
| nnoremap | <leader>jn | Format current document as json                    |
| nnoremap | <leader>jq | Format current document as SQL file                |
| nnoremap | <leader>md | Set editor for markdown editing                    |
| nnoremap | <leader>nd | Set nowrap<cr>                                     |
| nnoremap | <leader>tc | Open new tab                                       |
| nnoremap | <leader>tn | Select next tab                                    |
| nnoremap | <leader>tp | Select previous tab                                |
| nnoremap | <leader>ww | Write without any callback run                     |
|   nmap   |     ga     | EasyAlign                                          |

## LSP Related Keymap

| Mode |     KeyStroke     | Actions                           |
| :--: | :---------------: | :-------------------------------- |
|  n   |        gD         | Go to declaration                 |
|  n   |        gd         | Go to definition                  |
|  n   |         K         | Hover                             |
|  n   |        gi         | Go to implementation              |
|  n   |       <C-k>       | Show signature help               |
|  n   |    <leader>wa     | Add workspace folder              |
|  n   |    <leader>wr     | Remove workspace folder           |
|  n   |    <leader>wl     | List workspace folder             |
|  n   |     <leader>D     | Type definition                   |
|  n   |    <leader>rn     | Rename                            |
|  n   |        gr         | Go to references                  |
|  n   |    <leader>ca     | Code Action                       |
|  n   |     <leader>e     | Show line diagnostics             |
|  n   |        [d         | Go to previous diagnostic         |
|  n   |        ]d         | Go to next diagnostic             |
|  n   |     <leader>q     | Show location list                |
|  n   |    <Leader>gf     | LSP Saga finder                   |
|  n   |    <leader>ga     | LSP Saga code action              |
|  v   |    <leader>ga     | LSP Saga range code action        |
|  n   |    <leader>gh     | LSP Saga hover docs               |
|  n   |    <leader>gk     | LSP Saga scroll up                |
|  n   |    <leader>gj     | LSP Saga scroll down              |
|  n   |    <leader>gs     | LSP Saga signature help           |
|  n   |    <leader>gi     | LSP Saga show line diagnostic     |
|  n   |    <leader>gn     | LSP Saga diagnostic jum next      |
|  n   |    <leader>gp     | LSP Saga diagnostic jume previous |
|  n   |    <leader>gr     | LSP Saga rename                   |
|  n   |    <leader>gd     | LSP Saga preview definition       |
|  n   | <Leader><Leader>l | Linting Golang                    |
|  n   |    <Leader>gc     | Golang Comment                    |
