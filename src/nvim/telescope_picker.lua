local t_themes = require("telescope.themes")
local t_pickers = require("telescope.pickers")
local t_finders = require("telescope.finders")
local t_actions = require("telescope.actions")
local t_action_set = require("telescope.actions.set")
local t_action_state = require("telescope.actions.state")
local t_config = require("telescope.config")

local example_select_default = function(opts)
    opts = opts or {}
    t_pickers.new(opts, {
        prompt_title = "sluggg",
        finder = t_finders.new_table({
            results = { "glob", "slog", "blob", "tonk" }
        }),
        sorter = t_config.values.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            t_actions.select_default:replace(function()
                local selection = t_action_state.get_selected_entry()
                vim.notify(string.format("selected: %s", selection[1]), vim.log.levels.INFO)
                return t_action_set.edit(prompt_bufnr, "default")
            end)
            return true
        end,
    }):find()
end


example_select_default()
-- example_select_default(t_themes.get_dropdown({}))
