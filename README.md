octopress-gemoji
================

octopress-gemoji provides "gemoji" tag to use emoji in Octopress.

:memo:
There is a similar plugin, [jekyll-emoji](https://github.com/chriskempson/jekyll-emoji), which provides filter for emoji description (such `:smile:`).

# Installation

1. Copy `plugins/gemoji.rb` to your `plugins` directory,
and `sass/plugins/_gemoji.scss` to your `sass/plugins/` directory.

1. Add a following line to `sass/plugins/_plugins.scss`:

    @import "gemoji";

1. Add a line like `emoji_dir: /images/emoji` to your `_config.yml`

1. Add `gem 'gemoji'` to Gemfile and do `bundle install`.

Done!

:memo: `_egmoji.scss` has settings for `emoji` class which is used by [jekyll-emoji](https://github.com/chriskempson/jekyll-emoji), too.
`emoji_dir` and `gemoji` are also used by [jekyll-emoji](https://github.com/chriskempson/jekyll-emoji).

If you already have these settings for [jekyll-emoji](https://github.com/chriskempson/jekyll-emoji), you don't need to add them.

# Usage
Use tag `gemoji` + `emoji names`:

    {%gemoji smile%}
will be :smile:.

See [EMOJI CHEAT SHEET](http://www.emoji-cheat-sheet.com/) for more emojis.
