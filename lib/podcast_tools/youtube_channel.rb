# frozen_string_literal: true

require "open-uri"
require "nokogiri"

module PodcastTools
  class YoutubeChannel
    attr_reader :channel_url

    Video = Struct.new(:url, :title, keyword_init: true)

    def initialize(channel_url)
      @channel_url = channel_url
    end

    def urls
      videos.map(&:url)
    end

    def page
      @page ||= Nokogiri::HTML(URI(channel_url).open.read)
    end

    def videos
      @videos ||= begin
        anchor_elements = page.css(".yt-lockup-title a")
        anchor_elements.map { |element|
          url = URI.join("https://www.youtube.com", element[:href]).to_s
          Video[url: url, title: element.content]
        }
      end
    end
  end
end
