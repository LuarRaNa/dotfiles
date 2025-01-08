return {
  "shortcuts/no-neck-pain.nvim",
  config = function()
    require("no-neck-pain").setup({
      width = 120,
      autocmds = { enableOnVimEnter = true, skipEnteringNoNeckPainBuffer = true },
      buffers = {
        wo = {
          fillchars = "eob: ",
          laststatus = 3
        },
      },
    })
  end
}
