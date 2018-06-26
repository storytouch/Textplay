# a FDX tag with style is something like it:
# <Text Style="Bold"><Text Style="Italic">text with formatting</Text>
#   <Text>without formatting</Text></Paragraph>

shared_examples_for "tags with styles" do |tag, element_on_fdx|
  let(:fdx_result) { fdx_tag_with_content(tag, element_on_fdx) }

  context 'when has formatting' do
    let(:previous_style) { '' }

    context 'and it is bold' do
      let(:style) { 'Bold' }
      let(:text_with_formatting) { "**#{inner_text}**" }

      it 'returns the tag with formatting' do
        expect(subject).to match fdx_result
      end
    end

    context 'and it is italic' do
      let(:text_with_formatting) { "*#{inner_text}*" }
      let(:style) { 'Italic' }

      it 'returns the tag with formatting' do
        expect(subject).to match fdx_result
      end
    end

    context 'and it is bold and italic' do
      let(:text_with_formatting) { "***#{inner_text}***" }
      let(:previous_style) { /<Text Style=\"Bold\">/ }
      let(:style) { 'Italic' }

      it 'returns the tag with formatting' do
        expect(subject).to match fdx_result
      end
    end

    context 'and it is underline' do
      let(:text_with_formatting) { "_#{inner_text}_" }
      let(:style) { 'Underline' }

      it 'returns the tag with formatting' do
        expect(subject).to match fdx_result
      end
    end
  end

  context 'when has part of text with formatting' do
    formatting = {
      'bold' => { 'style' => 'Bold', 'fountain_mark' => '**' },
      'italic' => { 'style' => 'Italic', 'fountain_mark' => '*' },
      'underline' => { 'style' => 'Underline', 'fountain_mark' => '_' }
    }

    formatting.each do |style, data|
      context "and style is #{style}" do
        let(:pre_text) { '' }
        let(:post_text) { '' }
        let(:inner_text_escaped) { Regexp.escape(inner_text) }
        let(:pre_text_escaped) { Regexp.escape(pre_text) }
        let(:post_text_escaped) { Regexp.escape(post_text) }
        let(:style_type) { data['style'] }
        let(:mark) { data['fountain_mark'] }

        context 'and is applied in beginning of sentence' do
          let(:post_text) { 'post text ' }
          let(:element_text_on_fountain) { "#{mark}#{inner_text}#{mark}#{post_text}" }
          let(:fdx_with_style_beginning) {
            %r{
              #{pre_text_escaped}</Text>
              <Text\sStyle=\"#{style_type}\">
              \(?
              #{inner_text_escaped}</Text>
              <Text>#{post_text_escaped}
              \)?
              </Text>
            }x
          }

          # we need to ensure each part is in a <Text> otherwise FD will mess the text
          it 'returns the the bold inside <Text> and the rest in other <Text>' do
            expect(subject).to match fdx_with_style_beginning
          end
        end

        context 'and is applied in middle of sentence' do
          let(:pre_text) { 'pre text ' }
          let(:post_text) { ' post text' }
          let(:element_text_on_fountain) { "#{pre_text}#{mark}#{inner_text}#{mark}#{post_text}" }
          let(:fdx_with_mixed_styles) {
            %r{
              <Text>
              \(?
              #{pre_text_escaped}</Text>
              <Text\sStyle=\"#{style_type}\">#{inner_text_escaped}</Text>
              <Text>#{post_text_escaped}
              \)?
              </Text>
            }x
          }

          it 'returns only the middle text with formatting' do
            expect(subject).to match fdx_with_mixed_styles
          end
        end

        context 'and is applied at the end of sentence' do
          let(:post_text) { ' post text' }
          let(:element_text_on_fountain) { "#{mark}#{inner_text}#{mark}#{post_text}" }
          let(:fdx_with_style_end) {
            %r{
              <Text\sStyle=\"#{style_type}\">
              \(?
              #{inner_text_escaped}</Text>
              <Text>#{post_text_escaped}
              \)?
              </Text>
            }x
          }

          it 'returns only the end text with formatting' do
            expect(subject).to match fdx_with_style_end
          end
        end

        context 'and has text without formatting between text with formatting in both sides' do
          let(:pre_text) { 'pre text ' }
          let(:post_text) { ' post text' }
          let(:element_text_on_fountain) { "#{mark}#{pre_text}#{mark}#{inner_text}#{mark}#{post_text}#{mark}" }
          let(:fdx_with_style_beginning_end) {
            %r{
              <Text\sStyle="#{style_type}">
              \(?
              #{pre_text_escaped}</Text>
              <Text>#{inner_text_escaped}</Text>
              <Text\sStyle="#{style_type}">#{post_text_escaped}
              \)?
              </Text>
            }x
          }

          it 'applies the style only in the border texts' do
            expect(subject).to match fdx_with_style_beginning_end
          end
        end
      end
    end
  end

  context 'when text has fountain special chars escaped' do
    let(:text) { 'a text without style' }
    let(:text_escaped) { Regexp.escape(text) }
    let(:element_text_on_fountain) { "\\*\\*#{text}\\*\\* \\*#{text}\\* \\_#{text}\\_" }
    # &#42; = '*' &#95; = '_'
    let(:result) {
      %r{
        <Text>
        \(?
        &#42;&#42;#{text_escaped}&#42;&#42;\
        &#42;#{text_escaped}&#42;\
        &#95;#{text_escaped}&#95\
        \)?\
        </Text></Paragraph></Text>
      }x
    }

    it 'exports the chars encoded to fdx' do
      expect(subject).to match result
    end
  end

  context 'when a text without formatting is between texts with formatting' do
    let(:element_text_on_fountain) { '**b** wof *i* wof _u_ wof ' }
    let(:bold) { %r{.*<Text Style="Bold">\(?b</Text>.*} }
    let(:italic) { %r{.*<Text Style="Italic">i</Text>.*} }
    let(:without_formatting) { %r{.*<Text> wof \)?</Text>.*} }
    let(:underline) { %r{.*<Text Style="Underline">u</Text>.*} }
    let(:result) { %r{#{bold}#{without_formatting}#{italic}#{without_formatting}#{underline}#{without_formatting}} }

    it 'exports the text without formatting wrapped by <Text>' do
      expect(subject).to match result
    end
  end

  # TODO: we have to ensure we handle "**b****xb***i*" as "**b**" "**xb**" "*i*"
  # maybe we can use a fountain with "<b><i><u>" when we need to export to FDX
  context 'when a word has a mix of formatting' do
    let(:element_text_on_fountain) { '**b****xb***i*' }
    let(:bold) { %r{.*<Text Style="Bold">\(?b</Text>.*} }
    let(:inner_bold) { %r{.*<Text Style="Bold">xb</Text>.*} }
    let(:italic) { %r{.*<Text Style="Italic">i\)?</Text>.*} }
    let(:result) { %r{#{bold}#{inner_bold}#{italic}} }

    xit 'returns the the tag with the right formatting' do
      expect(subject).to match result
    end
  end
end
