return {
  "nvim-telescope/telescope.nvim",
  dependencies = { 'nvim-lua/plenary.nvim', 'folke/which-key.nvim' },
  tag = '0.1.8',
  config = function()
    local builtin = require('telescope.builtin')
    local opts = { noremap = true, silent = true }

    local wk = require("which-key")
    wk.add({
      { "<leader>f",  group = "Find" },
      { "<leader>f:", builtin.command_history, desc = "Command history", opts },
      {
        "<leader>fb",
        function() builtin.buffers({ sort_lastused = true, sort_mru = true }) end,
        desc = "Buffers",
        opts
      },
      { "<leader>ff", builtin.find_files,                    desc = "Files",                      opts },
      { "<leader>fh", builtin.find_files,                    desc = "Files Hidden",               opts },
      { "<leader>ft", builtin.help_tags,                     desc = "Help tags",                  opts },
      { "<leader>fl", builtin.live_grep,                     desc = "With live grep",             opts },
      { "<leader>l",  group = "LSP" },
      { "<leader>lM", builtin.diagnostics,                   desc = "Diagnostics (Open buffers)", opts },
      { "<leader>lS", builtin.lsp_dynamic_workspace_symbols, desc = "Workspace symbols",          opts },
      { "<leader>ld", builtin.lsp_definitions,               desc = "Go to definition",           opts },
      { "<leader>li", builtin.lsp_implementations,           desc = "Go to implementation",       opts },
      {
        "<leader>lm",
        function() builtin.diagnostics({ bufnr = 0 }) end,
        desc = "Diagnostics (current buffer)",
        opts
      },
      {

        mode = { "n", "x" },
        {
          "<leader>lf",
          function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end,
          desc = "Format (current buffer)",
          opts
        }
      },
      { "<leader>ls", builtin.lsp_document_symbols, desc = "Document symbols",      opts },
      { "<leader>lt", builtin.lsp_type_definitions, desc = "Go to type definition", opts },
      { "<leader>t",  group = "Treesitter" },
      { "<leader>ts", builtin.treesitter,           desc = "Treesitter symbols",    opts },
      { "<leader>r",  builtin.resume,               desc = "Resume",                opts },
    })
  end
}
