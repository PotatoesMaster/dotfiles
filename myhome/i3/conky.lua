local blocks = {}

function block(t)
    table.insert(blocks, t)
end

function format_blocks()
    local joined = format_block(1)
    for i = 2, #blocks do
        joined = joined .. format_block(i)
    end
    return joined
end

function format_block(index)
    local t = blocks[index]
    return i3_bar_block(t.color, t.text, t.cond, index == #blocks)
end

function i3_bar_block(color, text, cond, last)
    local bar_block = '{"full_text":"' .. text .. '","color":"\\#' .. color .. '"}' .. (last and '' or ',')
    if cond then
        return '${if_' .. cond .. '}' .. bar_block .. '${endif}'
    end
    return bar_block
end

require 'blocks_config'

conky.text = '[' .. format_blocks() .. '],'
