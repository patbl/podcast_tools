require "spec_helper"
require_relative "../lib/download_youtube_audio"

RSpec.describe DownloadYoutubeAudio do
  describe "#command" do
    it "generates the correct command" do
      expect(described_class.new("https://www.youtube.com/watch?v=81JzQ55jIfQ").command).
        to eq %q[youtube-dl -o data/\%\(title\)s.\%\(ext\)s -x https://www.youtube.com/watch\?v\=81JzQ55jIfQ]
    end
  end
end