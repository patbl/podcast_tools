# frozen_string_literal: true

require_relative "./download_youtube_audio"
require_relative "./get_ea_global_youtube_urls"

class DownloadEaGlobalAudio
  attr_reader :page

  def initialize(page:)
    @page = page
  end

  def call
    youtube_urls.map { |url|
      Thread.new { DownloadYoutubeAudio.new(url).call }
    }.each(&:join)
  end

  def youtube_urls
    GetEaGlobalYoutubeUrls.new("https://www.eaglobal.org/talks/#{page}/").call
  end
end
