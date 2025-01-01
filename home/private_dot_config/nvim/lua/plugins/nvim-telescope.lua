return {
  "nvim-telescope/telescope.nvim",
  dependencies = { 'nvim-lua/plenary.nvim' },
  tag = '0.1.8',
  keys = {
    {
      "<leader>fb",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Switch Buffer",
    },
    { "<leader>ff", "<cmd>Telescope find_files<cr>",      desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",       desc = "Find Word In Workspace" },
    { "<leader>:",  "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>/",  "<cmd>Telescope grep_string<cr>",     desc = "Find Word Under Cursor" },
    { "<leader>ss", "<cmd>Telescope grep_string<cr>",     desc = "Find Word Under Cursor" },
    {
      "<leader>ss",
      function()
        require("telescope.builtin").lsp_document_symbols({
        })
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
        })
      end,
      desc = "Goto Symbol (Workspace)",
    },
  },
}
