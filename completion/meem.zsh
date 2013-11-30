#compdef meem

local cmds

_arguments -C '1: :->commands'

cmds=("${(@f)$(meem -l)}")

_describe -t commands 'meem templates' cmds
