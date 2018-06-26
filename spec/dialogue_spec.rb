require 'spec_helper'
require 'shared_examples_for_tags_with_styles'

describe 'dialogue' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:inner_text) { 'Revenge is a dish best served' }
  let(:element_text_on_fountain) { inner_text }
  let(:tag) { 'Dialogue' }
  let(:fdx_result) { fdx_tag_with_content(tag, element_text_on_fountain) }

  # we need to have a character or a parenthetical before of it
  let(:fountain) do
    <<-FOUNTAIN
      \nVITO CORLEONE
      #{element_text_on_fountain}
    FOUNTAIN
  end

  it 'returns the fdx dialogue type' do
    expect(subject).to match fdx_result
  end

  context 'when element that precedes is a parenthetical' do
    let(:fountain) do
      <<-FOUNTAIN
        \nCHARACTER
        (any text)
        #{element_text_on_fountain}
      FOUNTAIN
    end

    it 'returns the fdx dialogue type' do
      expect(subject).to match fdx_result
    end
  end
end
