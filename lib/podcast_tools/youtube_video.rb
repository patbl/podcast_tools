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
      html.at_css("#eow-description").children.map { |child|
        if child.name == "a"
          href = CGI.parse(child.attributes["href"].value).fetch("q").fetch(0)
          new_node = Nokogiri::XML::Node.new("a", html)
          new_node.content = child.content
          new_node["href"] = href
          new_node
        else
          child
        end
      }.map(&:to_s).join("\n")
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
