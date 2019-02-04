# frozen_string_literal: true

require "spec_helper"
require "support/vcr_config"
require_relative "../lib/podcast_tools/youtube_video"

module PodcastTools
  RSpec.describe YoutubeVideo do
    let(:video) { described_class.new("https://www.youtube.com/watch?v=yf9GljlqjI4") }

    describe "#description" do
      it "returns the description" do
        VCR.use_cassette("YouTube Video: An Introduction to Normative Uncertainty") do
          expect(video.description).to start_with("If you want to have the highest possible impact")
        end
      end

      it "removes YouTube crap from URLs" do
        VCR.use_cassette("YouTube Video: An Introduction to Normative Uncertainty") do
          expect(video.description).not_to match %r{/redirect\?}
          anchor = '<a href="https://www.effectivealtruism.org">https://www.effectivealtruism.org</a>'
          expect(video.description).to include(anchor)
        end
      end
    end

    describe "#title" do
      it "returns the title" do
        VCR.use_cassette("YouTube Video: An Introduction to Normative Uncertainty") do
          expect(video.title).to eq "An Introduction to Normative Uncertainty"
        end
      end
    end
  end
end
