-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("nvim-tree").setup({
    sort_by = "case_sensitive",
    filters = {
        dotfiles = true,
    },
    update_focused_file = {
        enable = true,
        update_root = false,
    },
})

vim.keymap.set('n', '<leader>t', "<cmd>NvimTreeToggle<cr>", {})
