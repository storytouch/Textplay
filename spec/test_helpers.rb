require 'open3'

module TestHelpers
  CONVERT_COMMAND = 'textplay -f'.freeze

  def convert_from_fountain_to_fdx(fountain_data)
    Open3.capture2(CONVERT_COMMAND, stdin_data: fountain_data)[0]
  end

  def fdx_tag_with_content(tag, content)
    %r{.*Type=\"#{tag}\"><Text>#{content}</Text>.*}
  end
end
