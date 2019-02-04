# frozen_string_literal: true

require "nokogiri"
require "open-uri"

module PodcastTools
  class YoutubeVideo
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def description
      html.at_css("#eow-description").children.map(&:to_s).join("\n")
    end

    def title
      html.at_css("#eow-title").content.strip
    end

    private

    def html
      @html ||= Nokogiri::HTML(URI(url).open.read)
    end
  end
end
