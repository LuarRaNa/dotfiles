return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "mason.nvim" },
  config = function()
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr
      opts.desc = "Go To References"
      keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
      opts.desc = "Go To Definitions"
      keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, opts)
      opts.desc = "Go To Implementations"
      keymap.set("n", "gi", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, opts)
      opts.desc = "Go To Type Definitions"
      keymap.set("n", "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, opts)
      opts.desc = "Format from LSP"
      keymap.set({ 'n', 'x' }, 'gf', function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end, opts)
    end

    require("mason-lspconfig").setup()
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup {
          on_attach = on_attach
        }
      end,
      ["lua_ls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } }
            }
          },
          on_attach = on_attach
        })
      end,
    })
  end,
  opts = function()
  end,
}
