return {
  "sudo-tee/opencode.nvim",
  config = function()
    require("opencode").setup {
      ui = {
        window_width = 0.25,
        input = {
          text = {
            wrap = true,
          },
        },
      },
      keymap = {
        input_window = {
          ["<C-CR>"] = { "submit_input_prompt", mode = { "n", "i" } },
          ["<esc>"] = false,
        },
        output_window = {
          ["<esc>"] = false,
        },
        editor = {
          ["<leader>ag"] = { "toggle" }, -- Open opencode. Close if opened
          ["<leader>ai"] = { "open_input" }, -- Opens and focuses on input window on insert mode
          ["<leader>aI"] = { "open_input_new_session" }, -- Opens and focuses on input window on insert mode. Creates a new session
          ["<leader>ao"] = { "open_output" }, -- Opens and focuses on output window
          ["<leader>at"] = { "toggle_focus" }, -- Toggle focus between opencode and last window
          ["<leader>aT"] = { "timeline" }, -- Display timeline picker to navigate/undo/redo/fork messages
          ["<leader>aq"] = { "close" }, -- Close UI windows
          ["<leader>as"] = { "select_session" }, -- Select and load a opencode session
          ["<leader>aR"] = { "rename_session" }, -- Rename current session
          ["<leader>ap"] = { "configure_provider" }, -- Quick provider and model switch from predefined list
          ["<leader>aV"] = { "configure_variant" }, -- Switch model variant for the current model
          ["<leader>ay"] = { "add_visual_selection", mode = { "v" } },
          ["<leader>aY"] = { "add_visual_selection_inline", mode = { "v" } }, -- Insert visual selection as inline code block in the input buffer
          ["<leader>az"] = { "toggle_zoom" }, -- Zoom in/out on the Opencode windows
          ["<leader>av"] = { "paste_image" }, -- Paste image from clipboard into current session
          ["<leader>ad"] = { "diff_open" }, -- Opens a diff tab of a modified file since the last opencode prompt
          ["<leader>a]"] = { "diff_next" }, -- Navigate to next file diff
          ["<leader>a["] = { "diff_prev" }, -- Navigate to previous file diff
          ["<leader>ac"] = { "diff_close" }, -- Close diff view tab and return to normal editing
          ["<leader>ara"] = { "diff_revert_all_last_prompt" }, -- Revert all file changes since the last opencode prompt
          ["<leader>art"] = { "diff_revert_this_last_prompt" }, -- Revert current file changes since the last opencode prompt
          ["<leader>arA"] = { "diff_revert_all" }, -- Revert all file changes since the last opencode session
          ["<leader>arT"] = { "diff_revert_this" }, -- Revert current file changes since the last opencode session
          ["<leader>arr"] = { "diff_restore_snapshot_file" }, -- Restore a file to a restore point
          ["<leader>arR"] = { "diff_restore_snapshot_all" }, -- Restore all files to a restore point
          ["<leader>ax"] = { "swap_position" }, -- Swap Opencode pane left/right
          ["<leader>att"] = { "toggle_tool_output" }, -- Toggle tools output (diffs, cmd output, etc.)
          ["<leader>atr"] = { "toggle_reasoning_output" }, -- Toggle reasoning output (thinking steps)
          ["<leader>a/"] = { "quick_chat", mode = { "n", "x" } }, -- Open quick chat input with selection context in visual mode or current line context in normal mode
        },
      },
    }

    local wk = require "which-key"
    wk.add {
      { "<leader>a", group = "Opencode" },
    }
  end,
  dependencies = {
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    },
    "saghen/blink.cmp",
    "folke/snacks.nvim",
  },
}
