require "test_helper"
require "zbase32"
require "rantly/shrinks"

describe ZBase32 do
  before do
    Rantly.gen.reset
  end

  it "only returns encoded string within charset" do
    str = Rantly { sized(25) {string} }
    out = ZBase32.encode(str)
    assert(out.match(/[^#{ZBase32::CHARSET.map(&:to_s)}]+/).nil?)
  end

  it "encodes very long strings" do
    str = Rantly { sized(25000) {string} }
    out = ZBase32.encode(str)
    assert(out.size > 25000)
    assert_equal(ZBase32.decode(out), str)
  end

  it "handles non-ascii characters" do
    num = Rantly.map(1) { integer }.pack("N")
    out = ZBase32.encode(num)
    assert(out.size > 5)
    assert_equal(ZBase32.decode(out), num)
  end

  # This is probably the wrong way to be using Rantly..
  it "despite input length returns decodable output" do
    Rantly { array(250) { sized(80) {string} } }.each do |string|
      while string.shrinkable? do
        output = ZBase32.decode(ZBase32.encode(string))
        assert_equal output, string
        string = string.shrink
      end
    end
  end
end
