local options = {
  nu = true

  tabstop = 2
  softtabstop = 2
  shiftwidth = 2
  expandtab = true

  smartindent = true
  wrap = false

  hlsearch = false
  incsearch = true

  termguicolors = true

  scrolloff = 8
  signcolumn = "yes"

  updatetime = 50
  colorcolumn = "80"
}


for k, v in pairs(options) do
  vim.opt[k] = v
end


vim.g.mapleader = " "
