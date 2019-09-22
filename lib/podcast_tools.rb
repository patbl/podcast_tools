# frozen_string_literal: true

require "podcast_tools/bulk_download_youtube_audio"
require "podcast_tools/directory"
require "podcast_tools/download_youtube_audio"
require "podcast_tools/episode"
require "podcast_tools/youtube_channel"

module PodcastTools
  CONFIG = YAML.safe_load(File.read("config/secrets.yml"), symbolize_names: true)
end
