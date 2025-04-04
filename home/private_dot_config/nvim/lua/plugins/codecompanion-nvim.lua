return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim"
  },
  lazy = true,
  event = "VeryLazy",
  config = function()
    local cc = require("codecompanion")

    cc.setup({
      adapters = {
        copilot = require("codecompanion.adapters").extend("copilot", {
          schema = {
            max_tokens = {
              default = 64000,
            },
          },
        })
      },
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
          },
        },
        inline = {
          adapter = "copilot",
        },
      },
      display = {
        action_palette = {
          provider = "telescope"
        },
      }
    })

    local wk = require("which-key")
    wk.add({
      { "<leader>a",  group = "AI assistance" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>",     mode = { "v", "n" }, desc = "AI code actions" },
      { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "v", "n" }, desc = "AI chat toggle" },
      {
        "<leader>ae",
        function() require("codecompanion").prompt("explain") end,
        mode = { "v" },
        desc = "AI explain"
      },
      {
        "<leader>af",
        function() require("codecompanion").prompt("fix") end,
        mode = { "v" },
        desc = "AI fix Code"
      },
      {
        "<leader>ai",
        function() require("codecompanion").prompt("buffer") end,
        mode = { "v" },
        desc = "AcI inline action"
      },
    })
  end
}
