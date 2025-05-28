return {
  "michaelb/sniprun",
  branch = "master",

  build = "sh install.sh",
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

  config = function()
    require("sniprun").setup({})
  end,
}

-- cmd = "Trouble",
-- keys = {
--   { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
--   { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
--   { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
--   { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
--   { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
-- },
