function up(str) --thanks google
    return (str:gsub("^%l", string.upper))
end