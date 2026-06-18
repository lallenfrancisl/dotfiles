return {
  "folke/snacks.nvim",
  dependencies = { "amansingh-afk/milli.nvim", version = "*" },
  ---@param opts snacks.Config
  opts = function(_, opts)
    local splash = require("milli").load { splash = "lights" }
    opts.dashboard = opts.dashboard or {}
    opts.dashboard.enabled = true
    opts.dashboard.preset = opts.dashboard.preset or {}
    opts.dashboard.preset.header = table.concat(splash.frames[1], "\n")
    opts.dashboard.sections = {
      { section = "header", padding = 1 },
      { section = "keys", gap = 1, padding = 1 },
      { section = "startup" },
    }
  end,
  config = function(_, opts)
    require("snacks").setup(opts)
    require("milli").snacks { splash = "lights", loop = true }
  end,
}
