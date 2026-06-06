---@type LazySpec
return {
  "AstroNvim/astroui",
  specs = {
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require "astroui.status"

        opts.statuscolumn = {
          init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
          status.component.signcolumn {
            padding = {
              left = 0,
              right = 0,
            },
          },
          status.component.numbercolumn(),
          status.component.foldcolumn(),
        }
      end,
    },
  },
  ---@type AstroUIOpts
  opts = {
    colorscheme = "kanagawa",
    status = {
      separators = {
        breadcrumbs = "  ",
      },
    },
  },
}
