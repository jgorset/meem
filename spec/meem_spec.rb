require "meem"

describe Meem do
  describe "#parse" do

    it "accepts a meme" do
      options = subject.parse ["y-u-no"]

      expect(options.meme).to eq "y-u-no"
    end

    it "sets text" do
      options = subject.parse ["y-u-no", "--top", "foo", "--bottom", "bar"]

      expect(options.top).to eq "foo"
      expect(options.bottom).to eq "bar"
    end

  end
end
