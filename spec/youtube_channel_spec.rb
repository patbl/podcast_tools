# frozen_string_literal: true

require "spec_helper"
require "support/vcr_config"
require_relative "../lib/podcast_tools/youtube_channel"

module PodcastTools
  RSpec.describe YoutubeChannel do
    let(:channel) {
      described_class.new(
        channel_url: "https://www.youtube.com/channel/UCEfASxwPxzsHlG5Rf1-4K9w/videos"
      )
    }

    describe "#urls" do
      it "returns a list of YouTube video URLs" do
        VCR.use_cassette("YouTube channel videos page") do
          expect(channel.urls.length).to eq 30

          aggregate_failures do
            channel.urls.each do |url|
              expect(url).to match(%r{/watch\?v=[^&]{5,}})
            end
          end
        end
      end
    end
  end
end
