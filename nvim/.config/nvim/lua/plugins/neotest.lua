---@type LazySpec
return {
  "nvim-neotest/neotest",
  version = "*",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "neotest-golang",
  },
  keys = {
    { "<Leader>T", desc = "Test", group = "Test" },
    { "<Leader>Tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
    { "<Leader>Tf", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run test file" },
    { "<Leader>Ta", function() require("neotest").run.attach() end, desc = "Attach to test" },
    { "<Leader>Ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    { "<Leader>To", function() require("neotest").output.open { enter = true } end, desc = "Open test output" },
    { "<Leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Toggle test output panel" },
    { "<Leader>Tw", function() require("neotest").watch.toggle(vim.fn.expand "%") end, desc = "Toggle test watch" },
  },
}
