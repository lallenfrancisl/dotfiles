return {
  "NeogitOrg/neogit",
  lazy = true,
  version = "*",
  dependencies = {
    "esmuellert/codediff.nvim",

    -- For a custom log pager
    "m00qek/baleia.nvim",

    -- Only one of these is needed.
    "folke/snacks.nvim", -- optional
  },
  cmd = "Neogit",
  -- keys = {
  --   { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  -- },
}
