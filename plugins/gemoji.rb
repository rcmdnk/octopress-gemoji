# gemoji
# rcmdnk (https://github.com/rcmdnk/octopress-gemoji)

require 'gemoji'

module Jekyll
  class Gemoji < Liquid::Tag
    def initialize(name, markup, tokens)
      @emoji = markup
    end

    def render(context)
      if @emoji != ""
        config = context.registers[:site].config
        if config['emoji_dir']
          if config['emoji_dir'].start_with?('http')
            emoji_dir = config['emoji_dir']
          else
            emoji_dir = '/' + File.join(config['source'], config['emoji_dir'])
          end
        end

        if Emoji.names.include?(@emoji) and emoji_dir
          '<img alt="' + @emoji + '" src="' + config['emoji_dir'] + "/#{@emoji}.png" + '" class="emoji" />'
        else
          ""
        end
      else
        ""
      end
    end
  end

  class GemojiGenerator < Generator
    def generate(site)
      config = site.config
      return false if not config['emoji_dir']
      return false if config['emoji_dir'].start_with?('http')
      emoji_dir = File.join(config['source'], config['emoji_dir'])
      return false if File.exist?(emoji_dir + '/smiley.png')

      # Make Emoji directory
      FileUtils.mkdir_p(emoji_dir)

      # Copy Gemoji files
      Dir["#{Emoji.images_path}/emoji/*.png"].each do |src|
        FileUtils.cp src, emoji_dir
      end
    end
  end

end

Liquid::Template.register_tag('gemoji', Jekyll::Gemoji)
