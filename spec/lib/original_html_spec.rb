require 'rails_helper'

describe '#preprosess' do
  subject(:result) { text.gsub(/#(?<num>\d+)/, '[#\k<num>](#comment-\k<num>)') }

  context "when full_document is a comment's reference" do
    let(:text) { "#1" }

    it "shold convert to link" do
      expect(result).to eq("[#1](#comment-1)")
    end
  end

  context "when full_document is headline" do
    let(:text) { "# 1" }

    it "shold ignore gsub" do
      expect(result).to eq("# 1")
    end
  end

  context "when insert a comment's reference" do
    let(:text) { "hello #1 world" }

    it "shold convert to link" do
      expect(result).to eq("hello [#1](#comment-1) world")
    end
  end
end
