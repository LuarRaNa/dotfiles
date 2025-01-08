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
            model = {
              default = "claude-3.5-sonnet",
            },
            max_tokens = {
              default = 200000,
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
        chat = {
          show_settings = true
        }
      }
    })
  end,
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>",                           mode = { "v", "n" }, desc = "AI Code Actions" },
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>",                       mode = { "v", "n" }, desc = "AI Chat Toggle" },
    { "<leader>ae", function() require("codecompanion").prompt("explain") end, mode = { "v" },      desc = "AI Explain" },
    { "<leader>af", function() require("codecompanion").prompt("fix") end,     mode = { "v" },      desc = "AI Fix Code" },
    { "<leader>ai", function() require("codecompanion").prompt("buffer") end,  mode = { "v" },      desc = "AcI Inline Action" },
    {
      "<leader>ag",
      function()
        require("codecompanion.strategies.chat").new({
          adapter = require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-4o-2024-08-06",
              },
              max_tokens = {
                default = 64000,
              },
            },
          }),
          messages = nil,
          context = require("codecompanion.utils.context").get(vim.api.nvim_get_current_buf())
        })
      end,
      mode = { "v", "n" },
      desc = "AI Chat GPT-4o"
    },
  },
}
