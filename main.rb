require_relative "lib/ui"
require_relative "lib/save_load"

save_or_load = SaveLoad.new
ui = UI.new(save_or_load)

ui.start