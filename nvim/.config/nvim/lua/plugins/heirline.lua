return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local last_buf
    local original_init = opts.statusline.init

    opts.statusline.init = function(self)
      if original_init then original_init(self) end

      local buf = tonumber(vim.g.actual_curbuf) or vim.api.nvim_get_current_buf()
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype ~= "opencode_output" then last_buf = buf end
      self.bufnr = last_buf or buf
    end
  end,
}
