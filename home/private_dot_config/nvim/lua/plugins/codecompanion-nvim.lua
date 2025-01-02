return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim"
  },
  config = function()
    local cc = require("codecompanion")

    cc.setup({
      strategies = {
        chat = {
          adapter = "copilot",
          slash_commands = {
            ["buffer"] = {
              opts = {
                contains_code = true,
                provider = "telescope",
              },
            },
            ["file"] = {
              opts = {
                contains_code = true,
                max_lines = 1000,
                provider = "telescope",
              },
            },
            ["help"] = {
              opts = {
                contains_code = false,
                max_lines = 128,
                provider = "telescope",
              },
            },
            ["symbols"] = {
              opts = {
                provider = "telescope",
              },
            },
          },
          keymaps = {
            completion = {
              modes = {
                i = "<AS-Tab>",
              },
              index = 1,
              callback = "keymaps.completion",
              description = "Completion Menu",
            }
          }
        },
        inline = {
          adapter = "copilot",
        },
      },
      display = {
        action_palette = {
          provider = "telescope"
        }
      }
    })
  end,
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>",                           mode = { "x", "n" }, desc = "AI Code Actions" },
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>",                       mode = { "x", "n" }, desc = "AI Chat Toggle" },
    { "<leader>ae", function() require("codecompanion").prompt("explain") end, mode = { "x", "n" }, desc = "AI Explain" },
    { "<leader>af", function() require("codecompanion").prompt("fix") end,     mode = { "x", "n" }, desc = "AI Fix Code" },
  }
}
