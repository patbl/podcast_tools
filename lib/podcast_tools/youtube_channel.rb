# frozen_string_literal: true

require "open-uri"
require "google/apis/youtube_v3"

module PodcastTools
  class YoutubeChannel
    attr_reader :channel_id, :limit

    Video = Struct.new(:url, :title, :description, keyword_init: true)
    MAX_RESULTS = 50

    def initialize(channel_id, limit: nil)
      @channel_id = channel_id
      @limit = (limit || MAX_RESULTS).clamp(1, MAX_RESULTS)
    end

    def name
      @name ||= service.
        list_channels("snippet", id: channel_id).
        items.
        first.
        snippet.
        title
    end

    def urls
      videos.map(&:url)
    end

    def videos
      return @videos if defined?(@videos)

      response = service.list_playlist_items(
        "snippet",
        playlist_id: uploads_playlist,
        max_results: limit,
      )
      @videos = response.items.map { |playlist_item|
        snippet = playlist_item.snippet
        video_id = snippet.resource_id.video_id
        Video[
          title: snippet.title,
          description: snippet.description,
          url: "https://www.youtube.com/watch?v=#{video_id}"
        ]
      }
    end

    private

    def service
      @service ||=
        Google::Apis::YoutubeV3::YouTubeService.new.tap { |service|
          service.key = CONFIG.fetch(:youtube_api_key)
        }
    end

    def uploads_playlist
      service.
        list_channels("contentDetails", id: channel_id).
        items.
        first.
        content_details.
        related_playlists.
        uploads
    end
  end
end
