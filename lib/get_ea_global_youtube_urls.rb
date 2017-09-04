require "pry"
require "net/http"
require "nokogiri"

class GetEaGlobalYoutubeUrls
  attr_reader :index_url

  def initialize(index_url)
    @index_url = index_url
  end

  def call
    internal_child_pages.map(&:youtube_url)
  end

  private

  def internal_child_pages
    internal_child_paths.map { |path|
      Thread.new { Net::HTTP.get(URI.join("https://www.eaglobal.org", path)) }
    }.map { |thread| InternalPage.new(thread.join.value) }
  end

  def internal_child_paths
    index_page.css(".card-talk h4.card-title a").map { |node| node["href"] }
  end

  def index_page
    @index_page ||= Nokogiri::HTML(Net::HTTP.get(URI(index_url)))
  end

  class InternalPage
    attr_reader :body

    def initialize(body)
      @body = body
    end

    def youtube_url
      "https://www.youtube.com/watch?v=#{youtube_id}"
    end

    private

    def youtube_id
      embed_url.split("/").last
    end

    def embed_url
      Nokogiri::HTML(body).at_css("iframe.embed-responsive-item")["src"]
    end
  end
end
