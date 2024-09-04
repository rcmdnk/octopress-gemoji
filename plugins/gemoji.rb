# gemoji
# rcmdnk (https://github.com/rcmdnk/octopress-gemoji)

require 'gemoji'

module Jekyll
  class Gemoji < Liquid::Tag
    def initialize(name, markup, tokens)
      @emoji = markup
      @emoji.strip!
    end

    def render(context)
      if @emoji != ""
        emoji_dir = ''
        config = context.registers[:site].config
        if config['emoji_dir']
          emoji_dir = config['emoji_dir']
        end

        emoji = Emoji.find_by_alias(@emoji)
        if emoji != nil
          if ! emoji_dir.start_with?('http') && ! File.exist?(File.join(config['source'], emoji_dir, emoji.image_filename))
            print "\e[31m"
            puts "gemoji warning: Image file for #{@emoji} (#{File.join(config['source'], emoji_dir, emoji.image_filename)}) was not found! @#{context['page']['url']}"
            print "\e[0m"
            emoji.raw
          else
            '<img alt="' + @emoji + '" src="' + File.join(emoji_dir, emoji.image_filename) + '" class="emoji" />'
          end
        else
          print "\e[31m"
          puts "gemoji warning: #{@emoji} was not found! @#{context['page']['url']}"
          print "\e[0m"
          @emoji
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
      return false if File.exist?(emoji_dir)

      # Copy Gemoji files
      p "Copying #{Emoji.images_path} to #{emoji_dir}..."
      FileUtils.cp_r Emoji.images_path + '/emoji', emoji_dir
    end
  end

end

Liquid::Template.register_tag('gemoji', Jekyll::Gemoji)
