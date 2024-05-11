local Path = require("plenary.path")

local M = {}
local SAVE_FILE = nil

local state = {
    size = 123,
    content = "cool",
}

M.setSaveFile = function(path)
    path = Path:new(path):expand()
    local dirname = vim.fs.dirname(path)
    if not Path:new(dirname):exists() then
        SAVE_FILE = nil
        vim.notify(string.format("can set save_file becuase dir does not exist (%s)", dirname), vim.log.levels.ERROR)
        return
    end
    SAVE_FILE = path
    vim.notify(string.format("save_file set: %s", SAVE_FILE), vim.log.levels.INFO)
end

M.prompt = function()
    local input = vim.fn.input({
        prompt = "new size: "
    })
    local size = tonumber(input)
    if size ~= nil then
        state.size = size
        vim.notify(string.format("\nstate.size: %d\n", state.size), vim.log.levels.INFO)
    else
        vim.notify(string.format("\nsize must be a number, invalid input [%s]\n", input), vim.log.levels.ERROR)
    end

    input = vim.fn.input({
        prompt = "new content: "
    })
    if size ~= "" then
        state.content = input
        vim.notify(string.format("\nstate.content: %s\n", state.content), vim.log.levels.INFO)
    else
        vim.notify(string.format("\ncontent cannot be empty\n", input), vim.log.levels.ERROR)
    end
    M.stateSave()
end


M.stateSave = function()
    Path:new(Path:new(SAVE_FILE):expand()):write(vim.fn.json_encode(state), "w")
end

M.stateLoad = function()
    local file = Path:new(SAVE_FILE)
    if not file:exists() then
        vim.notify(string.format("load faild save_file not found: %s", SAVE_FILE), vim.log.levels.ERROR)
        return
    end
    state = vim.fn.json_decode(file:read())

    vim.print("state:", state)
end

-- M.setSaveFile("~/.Trash/learn-lua-save-state.json")
-- M.stateLoad()
-- M.prompt()
return M
