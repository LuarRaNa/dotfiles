local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

-- Common options
local expr_opts = { expr = true }

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Saner behavior of n and N
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
local search_mappings = {
  { "n", "n", "'Nn'[v:searchforward].'zv'", "Next Search Result" },
  { "x", "n", "'Nn'[v:searchforward]", "Next Search Result" },
  { "o", "n", "'Nn'[v:searchforward]", "Next Search Result" },
  { "n", "N", "'nN'[v:searchforward].'zv'", "Prev Search Result" },
  { "x", "N", "'nN'[v:searchforward]", "Prev Search Result" },
  { "o", "N", "'nN'[v:searchforward]", "Prev Search Result" },
}

for _, mapping in ipairs(search_mappings) do
  map(mapping[1], mapping[2], mapping[3], vim.tbl_extend("force", expr_opts, { desc = mapping[4] }))
end

-- Trigger autocomplete
map("i", "<AS-Tab>", "<C-n>")
