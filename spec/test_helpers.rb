require 'open3'

module TestHelpers
  CONVERT_COMMAND = 'textplay'.freeze

  def convert_from_fountain_to_fdx(fountain_data, cmd_options = ['-f'])
    Open3.capture2("#{CONVERT_COMMAND} #{cmd_options.join(" ")}", stdin_data: fountain_data)[0]
  end

  def fdx_tag_with_content(tag, inner_content)
    %r{.*Type=\"#{tag}\"><Text>#{inner_content}</Text>.*}
  end
end
