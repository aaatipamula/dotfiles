-- Function to wrap current line in a fancy header
local function create_header()
  -- Get the current line number and content
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local line_text = vim.api.nvim_get_current_line()

  -- Trim whitespace from the line
  line_text = line_text:match("^%s*(.-)%s*$")

  -- Calculate the width for the header box
  local text_length = vim.fn.strdisplaywidth(line_text)
  local padding = 2  -- Space on each side of the text
  local total_width = text_length + (padding * 2)

  -- Create the header lines using Unicode box-drawing characters
  local top_line = "╔" .. string.rep("═", total_width) .. "╗"
  local middle_line = "║" .. string.rep(" ", padding) .. line_text .. string.rep(" ", padding) .. "║"
  local bottom_line = "╚" .. string.rep("═", total_width) .. "╝"

  -- Replace the current line and insert the header lines
  vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, {
    top_line,
    middle_line,
    bottom_line
  })

  -- Move cursor to the middle line
  vim.api.nvim_win_set_cursor(0, {line_num + 1, padding + 1})

  vim.cmd[[ .-1,.+1 Comment ]]
end

-- Create the :Header command
vim.api.nvim_create_user_command('Header', create_header, {})

return {
  create_header = create_header
}
