# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/podcast_tools/download_ea_global_audio"

module PodcastTools
  RSpec.describe DownloadEaGlobalAudio do
    it "downloads the stuff" do
      downloader = described_class.new(page: 1)
      allow(downloader).to receive(:youtube_urls).
        and_return(%w[http://www.youtube.com/watch?v=123 http://www.youtube.com/watch?v=456])
      expect(Kernel).to receive(:system).with(%r{/watch\\\?v\\=123})
      expect(Kernel).to receive(:system).with(%r{/watch\\\?v\\=456})

      downloader.call
    end
  end
end
