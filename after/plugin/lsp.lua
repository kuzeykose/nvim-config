local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.setup()

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]



