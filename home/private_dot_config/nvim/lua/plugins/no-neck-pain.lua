return {
  "shortcuts/no-neck-pain.nvim",
  config = function()
    require("no-neck-pain").setup({
      width = 110,
      autocmds = { enableOnVimEnter = true, skipEnteringNoNeckPainBuffer = true },
    })
  end
}
