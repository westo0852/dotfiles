c.auto_save.session = True

c.content.cookies.accept = "no-unknown-3rdparty"
c.content.geolocation = False
c.content.notifications.enabled = False

# See https://github.com/qutebrowser/qutebrowser/issues/5182
c.content.headers.user_agent = "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135"

# Stolen from https://github.com/BreadOnPenguins/dots
c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "!ddg": "https://duckduckgo.com/?q={}",
    "!wiki": "https://en.wikipedia.org/w/index.php?search={}",
    "!wiktionary": "https://en.wiktionary.org/w/index.php?search={}",
    "!a": "https://wiki.archlinux.org/?search={}",
    "!pkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!yt": "https://youtube.com/results?search_query={}",
    "!reddit": "https://old.reddit.com/search?q={}&&include_over_18=on",
}

c.zoom.default = "150%"

c.fonts.web.size.default = 14
c.fonts.default_size = "14pt"
c.fonts.default_family = "JetBrainsMono Nerd Font"
c.fonts.completion.category = "14pt 'JetBrainsMono Nerd Font'"
c.fonts.completion.entry = "14pt 'JetBrainsMono Nerd Font'"
c.fonts.debug_console = "14pt 'JetBrainsMono Nerd Font'"

# c.tabs.tree_tabs = True

c.tabs.position = "left"
c.tabs.width = 400
c.tabs.favicons.show = "never"
c.tabs.indicator.width = 0
c.tabs.title.format = "{index} {current_title}"

c.tabs.new_position.related = "next"
c.tabs.new_position.unrelated = "first"

# idk why QssColor when others are QtColor
# see qute://help/settings.html#colors.tabs.bar.bg
c.colors.tabs.bar.bg = "#434343"
c.colors.tabs.even.bg = "#434343"
c.colors.tabs.odd.bg = "#434343"
c.colors.tabs.selected.even.bg = "darkgrey"
c.colors.tabs.selected.odd.bg = "darkgrey"

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"

# Settings set via GUI
config.load_autoconfig()

# Keybindings
config.bind(",so", "config-source")
