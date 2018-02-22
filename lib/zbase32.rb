module ZBase32
  def self.is_integer?(str)
    true if Integer(str) rescue false
  end

  ALLOWED_CHARS = %w( y b n d r f g 8 e j k m c p q x o t 1 u w i s z a 3 4 5 h 7 6 9 ).freeze
  MASKS   = [0x1f, 0x3e, 0x7c, 0xf8, 0xf0, 0xe0, 0xc0, 0x80].freeze
  MASKS2  = [0x1, 0x3, 0x7, 0xf].freeze
  SEED_ENV_VAR = "ZBASE32_SEED".freeze
  if ENV[SEED_ENV_VAR].nil? then
    seed = 1
  elsif ! is_integer?(ENV[SEED_ENV_VAR]) then
    $stderr.puts "NOTICE: '#{SEED_ENV_VAR}' environment variable is not an integer! Using '1' as seed."
    seed = 1
  else
    seed = Integer(ENV[SEED_ENV_VAR])
  end
  CHARSET = ALLOWED_CHARS.shuffle(random: Random.new(seed)).freeze
  ZB2N = CHARSET.each_with_index.inject({}) { |acc, (a, b)| acc[a] = b; acc }.freeze

  extend self

  def encode(bytes)
    ret = ""
    (split_string(bytes)).each do |part|
      raise "There is no #{part}" unless part < 32
      ret = ret + CHARSET[part]
    end
    ret
  end

  def decode(bytes)
    join_string(bytes.downcase.split('').map { |s| ZB2N[s] })
  end

  private

  def split_string string
    output    = [] ; chunk  = 0
    part      = 0  ; offset = 0
    suboffset = 0  ; q      = 0
    length    = 8 * string.length

    while (q < length) do
      offset = (q / 8).to_i
      suboffset = q % 8
      part = string[offset, 1][0].ord
      chunk = (part & MASKS[suboffset]) >> suboffset
      suboffset = suboffset - 4
      if suboffset >= 0
        if ((q + 5) > length)
          part = 0
        else
          part = string[offset+1, 1][0].ord
        end
        chunk |= (part & MASKS2[suboffset]) << (4 - suboffset)
      end
      output.push chunk
      q = q + 5
    end
    output
  end

  def join_string output
    length    = 5 * output.size
    ret       = Array.new((length / 8.0).ceil, 0)
    part      = 0  ; chunk  = 0
    suboffset = 0  ; offset = 0
    n         = 0  ; q      = 0
    while (q < length) do
      offset = (q / 8).to_i
      suboffset = q % 8
      part = output[n]
      chunk = (part << suboffset ) & MASKS[suboffset]
      ret[offset] |= chunk
      suboffset = suboffset - 4
      if suboffset >= 0
        ret[offset+1] |= (part >> (4-suboffset) ) & MASKS2[suboffset]
      end
      n = n + 1
      q = q + 5
    end
    string = ret.map(&:chr).join('')
    string.chomp!("\0")
    string
  end
end
