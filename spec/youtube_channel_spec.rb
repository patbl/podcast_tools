# frozen_string_literal: true

require "spec_helper"
require "support/vcr_config"
require_relative "../lib/podcast_tools/youtube_channel"

module PodcastTools
  RSpec.describe YoutubeChannel do
    let(:channel) { described_class.new("UCEfASxwPxzsHlG5Rf1-4K9w") }

    describe "#urls" do
      it "returns a list of YouTube video URLs" do
        VCR.use_cassette("YouTube channel videos page") do
          expect(channel.urls.length).to eq 50

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
