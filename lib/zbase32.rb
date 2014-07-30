class ZBase32
  def initialize
    @zbase32 = %w( y b n d r f g 8 e j k m c p q x o t 1 u w i s z a 3 4 5 h 7 6 9 )
    @masks   = [0x1f, 0x3e, 0x7c, 0xf8, 0xf0, 0xe0, 0xc0, 0x80]
    @masks2  = [0x1, 0x3, 0x7, 0xf]
    @zB2N = {}; q=0;
    @zbase32.each { |z| @zB2N[z] = q; q+=1}
  end

  def encode string
    ret = ""
    (split_string string).each do |part|
      raise "There is no #{part}" unless part < 32
      ret = ret + @zbase32[part]
    end
    return ret
  end
  
  def decode string
    join_string string.downcase.split('').map{ |s| @zB2N[s] }
  end

  def self.random length
    length = 5 if (length.is_a? String) && (length == "")
    length = length.to_i
    abort("You gave me wrong input. I'm upset.") unless length.is_a? Integer
    zbase32 = %w( y b n d r f g 8 e j k m c p q x o t 1 u w i s z a 3 4 5 h 7 6 9 )
    out = ''
    while length > 0
      out += zbase32.sort_by { rand }[0]
      length -= 1
    end
    out
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
      chunk = (part & @masks[suboffset]) >> suboffset
      suboffset = suboffset - 4
      if suboffset >= 0
        if ((q + 5) > length)
          part = 0 
        else
          part = string[offset+1, 1][0].ord
        end
        chunk |= (part & @masks2[suboffset]) << (4 - suboffset)
      end
      output.push chunk
      q = q + 5
    end
    return output
  end
  
  def join_string output
    length = 5 * output.size
    ret = Array.new((length / 8).to_i, 0)
    part      = 0  ; chunk  = 0
    suboffset = 0  ; offset = 0
    n         = 0  ; q      = 0
    while (q < length) do
      offset = (q / 8).to_i
      suboffset = q % 8
      part = output[n]
      chunk = (part << suboffset ) & @masks[suboffset]
      ret[offset] |= chunk
      suboffset = suboffset - 4
      if suboffset >= 0 
        ret[offset+1] |= (part >> (4-suboffset) ) & @masks2[suboffset]
      end
      n = n + 1
      q = q + 5
    end
    puts "ret: #{ret}"
    string =  ret.select{|x| x.class == Fixnum}.map{|x| x.chr }.join('')
    string[-1,1,''] if string[-1][0].ord == 0
    return string
  end
end