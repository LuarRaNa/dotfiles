return {
  "lewis6991/gitsigns.nvim",
  dependencies = { 'folke/which-key.nvim' },
  config = function()
    require('gitsigns').setup({
      attach_to_untracked = true,
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        local wk = require("which-key")
        wk.add({
          { "<leader>h",  group = "Hunk" },
          { "<leader>hs", gitsigns.stage_hunk,      desc = "Stage" },
          { "<leader>hu", gitsigns.undo_stage_hunk, desc = "Undo stage" },
          { "<leader>hr", gitsigns.reset_hunk,      desc = "Reset" },
          { "<leader>hp", gitsigns.preview_hunk,    desc = "Preview" },
          { "<leader>hS", gitsigns.stage_buffer,    desc = "Stage buffer" },
          { "<leader>hR", gitsigns.reset_buffer,    desc = "Reset buffer" },
          {
            "<leader>hb",
            function() gitsigns.blame_line { full = true } end,
            desc = "Blame line"
          },
          { "<leader>htb", gitsigns.toggle_current_line_blame, desc = "Toggle current line blame" },
          { "<leader>htd", gitsigns.toggle_deleted,            desc = "Toggle deleted" },
          { "<leader>hd",  gitsigns.diffthis,                  desc = "Diff this" },
          {
            "<leader>hD",
            function() gitsigns.diffthis('~') end,
            desc = "Diff this (~)"
          },
          {
            mode = { "v" },
            {
              "<leader>hs",
              function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
              desc = "Stage"
            },
            {
              "<leader>hr",
              function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
              desc = "Reset"
            }
          },
          {
            mode = { "o", "x" },
            { "<leader>hi", ':<C-U>Gitsigns select_hunk<CR>', desc = "Select" }
          }
        })
      end
    })
  end,
}
