require "pry"
require "net/http"
require "nokogiri"

class GetEaGlobalYoutubeUrls
  attr_reader :base_url, :page

  def initialize(base_url: "https://www.eaglobal.org/talks/", page: 1)
    @base_url = base_url
    @page = page
  end

  def call
    internal_child_pages.map(&:youtube_url)
  end

  private

  def internal_child_pages
    internal_child_paths.map { |path|
      Thread.new { Net::HTTP.get(URI.join("https://www.eaglobal.org", path)) }
    }
    threads.map { |thread| InternalPage.new(thread.join.value) }
  end

  def internal_child_paths
    index_page.css(".card-talk h4.card-title a").map { |node| node["href"] }
  end

  def index_page
    @index_page ||= Nokogiri::HTML(Net::HTTP.get(url))
  end

  def url
    URI.join(base_url, "#{page}/")
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
