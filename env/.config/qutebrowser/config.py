config.load_autoconfig(False)

c.aliases = {"q": "quit", "w": "session-save", "wq": "quit --save"}

# Setting dark mode
# config.set("colors.webpage.darkmode.enabled", True)

config.set("content.cookies.accept", "all", "chrome-devtools://*")
config.set("content.cookies.accept", "all", "devtools://*")
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
    "https://web.whatsapp.com/",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0",
    "https://accounts.google.com/*",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36",
    "https://*.slack.com/*",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0",
    "https://docs.google.com/*",
)
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0",
    "https://drive.google.com/*",
)

# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "chrome-devtools://*")
config.set("content.images", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")
config.set("content.notifications.enabled", True, "https://www.reddit.com")
config.set("content.notifications.enabled", True, "https://www.youtube.com")
c.downloads.location.directory = "~/Downloads"
c.tabs.show = "always"
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "li": "https://libgen.is/search.php?req={}",
    "am": "https://www.amazon.com/s?k={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "go": "https://www.google.com/search?q={}",
    "re": "https://www.reddit.com/r/{}",
    "wiki": "https://en.wikipedia.org/wiki/{}",
    "yt": "https://www.youtube.com/results?search_query={}",
}


# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
# Type: List of QtColor, or QtColor
c.colors.completion.fg = ["#9cc4ff", "white", "white"]
c.colors.completion.odd.bg = "#1c1f24"
c.colors.completion.even.bg = "#232429"
c.colors.completion.category.fg = "#e1acff"
c.colors.completion.category.bg = (
    "qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #000000, stop:1 #232429)"
)
c.colors.completion.category.border.top = "#3f4147"
c.colors.completion.category.border.bottom = "#3f4147"
c.colors.completion.item.selected.fg = "#282c34"
c.colors.completion.item.selected.bg = "#ecbe7b"
c.colors.completion.item.selected.match.fg = "#c678dd"
c.colors.completion.match.fg = "#c678dd"
c.colors.completion.scrollbar.fg = "white"
c.colors.downloads.bar.bg = "#282c34"
c.colors.downloads.error.bg = "#ff6c6b"
c.colors.hints.fg = "#282c34"
c.colors.hints.match.fg = "#98be65"
c.colors.messages.info.bg = "#282c34"
c.colors.statusbar.normal.bg = "#282c34"
c.colors.statusbar.insert.fg = "white"
c.colors.statusbar.insert.bg = "#497920"
c.colors.statusbar.passthrough.bg = "#34426f"
c.colors.statusbar.command.bg = "#282c34"
c.colors.statusbar.url.warn.fg = "yellow"
c.colors.tabs.bar.bg = "#1c1f34"
c.colors.tabs.odd.bg = "#282c34"
c.colors.tabs.even.bg = "#282c34"
c.colors.tabs.selected.odd.bg = "#282c34"
c.colors.tabs.selected.even.bg = "#282c34"
c.colors.tabs.pinned.odd.bg = "seagreen"
c.colors.tabs.pinned.even.bg = "darkseagreen"
c.colors.tabs.pinned.selected.odd.bg = "#282c34"
c.colors.tabs.pinned.selected.even.bg = "#282c34"

# Default font families to use. Whenever "default_family" is used in a
# font setting, it's replaced with the fonts listed here. If set to an
# empty value, a system-specific monospace default is used.
# Type: List of Font, or Font
c.fonts.default_family = '"Source Code Pro"'
c.fonts.default_size = "11pt"
c.fonts.completion.entry = '11pt "Source Code Pro"'
c.fonts.debug_console = '11pt "Source Code Pro"'
c.fonts.prompts = "default_size sans-serif"
c.fonts.statusbar = '11pt "Source Code Pro"'

# Bindings to use dmenu rather than qutebrowser's builtin search.
# config.bind('o', 'spawn --userscript dmenu-open')
# config.bind('O', 'spawn --userscript dmenu-open --tab')

# Bindings for normal mode
config.bind("Z", "hint links spawn st -e youtube-dl {hint-url}")
config.bind("t", "set-cmd-text -s :open -t")
config.bind("M", "hint links spawn mpv {hint-url}")
config.bind("af", "hint all tab-fg")
config.bind("ab", "hint all tab-bg")
config.bind("xb", "config-cycle statusbar.show always never")
config.bind("xt", "config-cycle tabs.show always never")
config.bind(
    "xx",
    "config-cycle statusbar.show always never;; config-cycle tabs.show always never",
)

# Bindings for cycling through CSS stylesheets from Solarized Everything CSS:
# https://github.com/alphapapa/solarized-everything-css
config.bind(
    ",ap",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/apprentice/apprentice-all-sites.css ""',
)
config.bind(
    ",dr",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/darculized/darculized-all-sites.css ""',
)
config.bind(
    ",gr",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/gruvbox/gruvbox-all-sites.css ""',
)
config.bind(
    ",sd",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css ""',
)
config.bind(
    ",sl",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-light/solarized-light-all-sites.css ""',
)
