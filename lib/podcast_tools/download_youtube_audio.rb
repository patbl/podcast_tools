# frozen_string_literal: true

module PodcastTools
  class DownloadYoutubeAudio
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def call
      Kernel.system(command)
    end

    def command
      "youtube-dl -o #{"data/%(title)s.%(ext)s".shellescape} -x #{url.shellescape} --audio-format wav"
    end
  end
end
