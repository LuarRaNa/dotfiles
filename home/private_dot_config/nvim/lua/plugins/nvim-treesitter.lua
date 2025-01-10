return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup(
      {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "yaml" },
        auto_install = true,
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<A-Up>",
            node_incremental = "<A-Up>",
            node_decremental = "<A-Down>"
          }
        },
      }
    )
  end
}
