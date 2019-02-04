# frozen_string_literal: true

module PodcastTools
  class BulkDownloadYoutubeAudio
    attr_reader :urls

    def self.call(urls)
      new(urls).call
    end

    def initialize(urls)
      @urls = urls
    end

    def call
      threads = urls.map { |url| Thread.new { DownloadYoutubeAudio.new(url).call } }
      threads.each(&:join)
    end
  end
end
