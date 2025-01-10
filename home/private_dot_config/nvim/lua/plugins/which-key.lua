return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    keys = {
      scroll_down = "<Down>",
      scroll_up = "<Up>",
    },
    icons = {
      mappings = false,
    },
    spec = {
      {
        mode = { "n", "v" },
        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        { "<leader>c", "<cmd>NoNeckPain<cr>", desc = "Centered mode" },
        { "<leader>w", proxy = "<c-w>",       group = "windows" },
        { "<leader>q", "<cmd>q<cr>",          desc = "Quit" },
      },
    },
  },
}
