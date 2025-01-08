return {
  "lewis6991/gitsigns.nvim",
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

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Hunk - Stage"})
        map('n', '<leader>hu', gitsigns.undo_stage_hunk,{ desc = "Hunk - Undo Stage"})
        map('n', '<leader>hr', gitsigns.reset_hunk,{ desc = "Hunk - Reset"})
        map('n', '<leader>hp', gitsigns.preview_hunk,{ desc = "Hunk -  Preview Hunk"})
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,{ desc = "Hunk - Stage"})
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,{ desc = "Hunk - Reset"})
        map('n', '<leader>hS', gitsigns.stage_buffer,{ desc = "Hunk - Stage Buffer"})
        map('n', '<leader>hR', gitsigns.reset_buffer,{ desc = "Hunk - Reset Buffer"})
        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end,{ desc = "Hunk - Blame Line"} )
        map('n', '<leader>htb', gitsigns.toggle_current_line_blame,{ desc = "Hunk - Toggle Current Blame Line"})
        map('n', '<leader>htd', gitsigns.toggle_deleted,{ desc = "Hunk - Toggle Deleted"})
        map('n', '<leader>hd', gitsigns.diffthis,{ desc = "Diff This"})
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end,{ desc = "Diff this (~)"})

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select Inner Hunk"})
      end
    })
  end,
}
