c.auto_save.session = True

c.content.cookies.accept = "no-unknown-3rdparty"
c.content.geolocation = False

c.fonts.web.size.default = 14
c.fonts.default_size = "14pt"
c.fonts.default_family = "JetBrainsMono Nerd Font"
c.fonts.completion.category = "14pt 'JetBrainsMono Nerd Font'"
c.fonts.completion.entry = "14pt 'JetBrainsMono Nerd Font'"
c.fonts.debug_console = "14pt 'JetBrainsMono Nerd Font'"

c.tabs.position = "left"
c.tabs.width = 400
c.tabs.favicons.show = "never"
c.tabs.indicator.width = 0
c.tabs.title.format = "{index} {current_title}"

# idk why QssColor when others are QtColor
# see qute://help/settings.html#colors.tabs.bar.bg
c.colors.tabs.bar.bg = "#000"
c.colors.tabs.even.bg = "black"
c.colors.tabs.odd.bg = "black"
c.colors.tabs.selected.even.bg = "darkgrey"
c.colors.tabs.selected.odd.bg = "darkgrey"

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"

# Settings set via GUI
config.load_autoconfig()

# Keybindings
# config.bind()
