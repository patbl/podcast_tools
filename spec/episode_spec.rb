require_relative "../lib/episode"

describe Episode do
  describe "normalized_name" do
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
  end
end
