# frozen_string_literal: true

require "open-uri"
require "nokogiri"

module PodcastTools
  class YoutubeChannel
    attr_reader :channel_url

    Video = Struct.new(:url, :title, keyword_init: true)

    def initialize(channel_url: nil, html: nil)
      if channel_url
        @channel_url = channel_url
      elsif html
        @html = html
      else
        raise ArgumentError
      end
    end

    def urls
      videos.map(&:url)
    end

    def html
      @html ||= URI(channel_url).open.read
    end

    def videos
      @videos ||= begin
        anchor_elements = Nokogiri::HTML(html).css("h3 a")
        anchor_elements.map { |element|
          href = element[:href] or next
          url = URI.join("https://www.youtube.com", href).to_s
          Video[url: url, title: element.content]
        }.compact
      end
    end
  end
end
