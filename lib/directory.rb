require "fileutils"
require_relative "./episode"

class Directory
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def rename_episodes
    back_up

    Dir.foreach(path) { |file_path|
      next if File.directory?(file_path)
      episode = Episode.new(file_path)
      episode.rename if episode.needs_cleanup?
    }
  end

  def back_up
    FileUtils.cp_r(path, "#{path}.bak")
  end
end
