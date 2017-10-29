class Episode
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def rename
    new_name = normalized_name
    puts name
    puts new_name

    while (input = gets.chomp) == "m"
      new_name = self.class.new(new_name).normalized_name
      puts name
      puts new_name
    end

    FileUtils.mv(name, new_name) if input == "y"
  end

  def normalized_name
    filename = name.downcase
    extension = File.extname(filename)
    basename = File.basename(filename, extension)
    basename = basename.sub(/-+[[:alnum:]]+$/, "") # Remove trailing alphanumeric slug
    basename = basename.gsub(/[^\w\s]/, " ") # Replace punctuation and the like with spaces
    basename = basename.gsub(/[-\s]+/, " ")
    basename = basename.strip
    basename = basename.tr(" ", "-")
    basename + extension
  end

  def needs_cleanup?
    name[/\s/]
  end
end
