local M = {}
local cmp = require("cmp")

function M.split_path(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end

	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

function M.join_paths(absolute, relative)
	local path = absolute
	for _, dir in ipairs(M.split_path(relative, "/")) do
		if dir == ".." then
			path = absolute:gsub("(.*)/.*", "%1")
		end
	end
	return path .. "/" .. relative:gsub("^[%./|%../]*", "")
end

function M.get_css_variables(files)
	local variables = {}
	local used = {}

	vim.print(type(files))

	for _, file in ipairs(files) do
		local content = vim.fn.readfile(M.join_paths(vim.fn.getcwd(), file))
		for index, line in ipairs(content or {}) do
			local name, value = line:match("^%s*[-][-](.*):(.*)[;]")
			if name and not used[name] then
				local lineBefore = content[index - 1]
				local comment = lineBefore:match("%s*/[*](.*)[*]/")
				table.insert(variables, {
					label = "--" .. name,
					insertText = "var(--" .. name .. ")",
					kind = cmp.lsp.CompletionItemKind.Variable,
					documentation = comment and value .. "\n\n" .. comment or value,
				})
				used[name] = true
			end
		end
	end

	return variables
end

-- function M.find_files(path)
-- 	local Job, exists = pcall(require, "plenary.job")
-- 	if not exists then
-- 		vim.notify(
-- 			"[cmp-css-variables]: Plenary is required as a dependency.",
-- 			vim.log.levels.ERROR,
-- 			{ title = "cmp-css-variables" }
-- 		)
-- 		return
-- 	end
-- 	local stdout = Job:new({
-- 		command = "find",
-- 		args = { ".", "-type", "d", "-name", "node_modules", "-prune", "-o", "-name", path, "-print" },
-- 	}):sync()
-- 	return stdout
-- end

return M
