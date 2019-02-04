# frozen_string_literal: true

module PodcastTools
  class Episode
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def rename
      FileUtils.mv(name, normalized_name)
    end

    def normalized_name
      filename = name.downcase
      extension = File.extname(filename)
      basename = File.basename(filename, extension)
      basename = basename.sub(/-+[[:alnum:]]+$/, "") # Remove trailing alphanumeric slug
      basename = basename.delete("'")
      basename = basename.gsub(/[^[:alpha:]\s]/, " ") # Replace punctuation and the like with spaces
      basename = basename.gsub(/[-\s]+/, " ")
      basename = basename.strip
      basename = basename.tr(" ", "-")
      basename + extension
    end

    def needs_cleanup?
      name[/\s/]
    end
  end
end
