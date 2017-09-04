require "spec_helper"
require "support/vcr_config"
require_relative "../lib/get_ea_global_youtube_urls"

RSpec.describe GetEaGlobalYoutubeUrls do
  describe "#call" do
    context "when given a valid URL" do
      it "returns an array of YouTube URLs" do
        VCR.use_cassette("ea_global_talks_index_and_children") do
          expect(described_class.new("https://www.eaglobal.org/talks/1/").call).
            to include("https://www.youtube.com/watch?v=81JzQ55jIfQ", "https://www.youtube.com/watch?v=o8rVscSHJT4")
        end
      end
    end

    context "when given an invalid URL" do
      it "returns an empty array" do
        VCR.use_cassette("ea_global_homepage") do
          expect(described_class.new("https://www.eaglobal.org").call).to eq []
        end
      end
    end
  end
end
