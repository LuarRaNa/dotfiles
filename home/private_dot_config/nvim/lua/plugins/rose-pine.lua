return {
  "rose-pine/neovim",
  lazy = false,
  priority = 1000,
  config = function()
    require("rose-pine").setup({
      dark_variant = "moon",
    })
    vim.cmd("colorscheme rose-pine")
  end
}
