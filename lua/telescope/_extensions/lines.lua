local telescope_installed, telescope = pcall(require, "telescope")

if not telescope_installed then
  error("This plugin requires nvim-telescope/telescope.nvim")
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local options = {
  hide_empty_lines = true,
  trim_lines = true,
}

local function setup(opts)
  options = vim.tbl_extend("force", options, opts)
end

local function gather_lines()
  local formatted_lines = {}
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for i, line in ipairs(lines) do
    local processed_line

    if options.trim_lines then
      processed_line = vim.trim(line)
    else
      processed_line = line
    end

    table.insert(formatted_lines, {
      line_number = i,
      line = processed_line,
      filepath = vim.api.nvim_buf_get_name(0),
    })
  end

  if options.hide_empty_lines then
    lines = vim.tbl_filter(function(entry)
      return vim.trim(entry.line) ~= ""
    end, formatted_lines)
  end

  return formatted_lines
end

local function pick_lines(opts)
  opts = opts or {}

  if not options then
    error("Plugin is not set up, call `require('telescope').load_extension('lines')`")
  end

  pickers
    .new(opts, {
      prompt_title = "Lines",
      finder = finders.new_table({
        results = gather_lines(),
        entry_maker = function(entry)
          return {
            value = entry.line_number,
            display = entry.line,
            ordinal = entry.line,
            filename = entry.filepath,
            lnum = entry.line_number,
          }
        end,
      }),
      previewer = conf.qflist_previewer(opts),
      sorter = conf.file_sorter(opts),
    })
    :find()
end

return telescope.register_extension({
  setup = setup,
  exports = {
    lines = pick_lines,
  },
})
