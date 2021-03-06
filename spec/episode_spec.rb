# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/podcast_tools/episode"

module PodcastTools
  RSpec.describe Episode do
    describe "#normalized_name" do
      it "lower-cases" do
        episode = described_class.new("Lol.mp4")
        expect(episode.normalized_name).to eq "lol.mp4"
      end

      it "replaces spaces with hyphens" do
        episode = described_class.new("lol test-3tabdf.mp4")
        expect(episode.normalized_name).to eq "lol-test.mp4"
      end

      it "strips garbage at the end of the base name" do
        episode = described_class.new("talk--mTN8Sal2Ug.opus")
        expect(episode.normalized_name).to eq "talk.opus"
      end

      it "doesn't strip hyphens used as dashes" do
        episode = described_class.new("Alison Fahey - Is universal basic.m4a")
        expect(episode.normalized_name).to eq "alison-fahey-is-universal-basic.m4a"
      end

      it "preserves unicode characters" do
        episode = described_class.new("Global Challenges - Kristian Rönn.m4a")
        expect(episode.normalized_name).to eq "global-challenges-kristian-rönn.m4a"
      end

      it "doesn't strip hyphenated words that are part of the title" do
        episode = described_class.new("big-talk--mTN8Sal2Ug.opus")
        expect(episode.normalized_name).to eq "big-talk.opus"
      end

      it "handles isolated hyphens" do
        episode = described_class.new("Basic Income - The GiveDirectly Experiment-41RhSYQw5Nc.m4a")
        expect(episode.normalized_name).to eq "basic-income-the-givedirectly-experiment.m4a"
      end

      it "removes punctuation" do
        episode = described_class.new("altruism & the good life.mp4")
        expect(episode.normalized_name).to eq "altruism-the-good-life.mp4"
      end

      it "removes apostrophes without replacing them with anything" do
        episode = described_class.new("Peter Singer's productivity tips.mp4")
        expect(episode.normalized_name).to eq "peter-singers-productivity-tips.mp4"
      end
    end
  end
end
