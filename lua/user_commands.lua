local ucmd = vim.api.nvim_create_user_command

local txt2po_regex = ':s/^\\(.*\\) :: \\(.*$\\)/msgid "\\1"\rmsgstr "\\2"'
local txt2po_search = "^\\(.*\\) :: \\(.*$\\)"
local txt2po_replace = 'msgid "\\1"\rmsgstr "\\2'
ucmd("Txt2po", function(args)
	if args.line1 == args.line2 then
		vim.cmd(txt2po_regex)
		return
	end
	local buf = vim.api.nvim_get_current_buf()

	local startpos = args.line1 - 1 --vim.fn.getpos("'<")
	local endpos = args.line2 - 1 -- vim.fn.getpos("'>")
	--print(startpos)
	--print(endpos)

	--	local startrow = startpos[2] - 1
	--	local endrow = endpos[2] - 1

	local lines = vim.api.nvim_buf_get_lines(buf, startpos, endpos + 1, false)
	local updated = {}

	local sub = function(line)
		local _, _, mid, mstr = string.find(line, "^(.*) :: (.*)$")
		--	print(mid)
		--	print(mstr)
		if mid == nil and mstr == nil then
			return "", ""
		end
		return 'msgid "' .. mid .. '"', 'msgstr "' .. mstr .. '"'
	end

	for _, line in ipairs(lines) do
		local sub1, sub2 = sub(line)
		--print(sub(line))
		--print(sub1 .. " ::: " .. sub2)
		table.insert(updated, sub1)
		table.insert(updated, sub2)
		--print(unpack(updated))
	end

	vim.api.nvim_buf_set_lines(buf, startpos, endpos + 1, false, {})
	--print("UPODA")
	--print(unpack(updated))
	--print("ASjHDK")
	vim.api.nvim_buf_set_lines(buf, startpos, startpos, false, updated)
end, { range = true })
