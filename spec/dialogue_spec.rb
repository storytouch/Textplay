require 'spec_helper'

describe 'dialogue' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:dialogue_text) { 'I am gonna say something' }
  let(:tag) { 'Dialogue' }
  let(:fdx_result) { fdx_tag_with_content(tag, dialogue_text) }

  # we need to have a character or a parenthetical before of it
  let(:fountain) do
    <<-FOUNTAIN
      \nPAUL
      #{dialogue_text}
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
        #{dialogue_text}
      FOUNTAIN
    end

    it 'returns the fdx dialogue type' do
      expect(subject).to match fdx_result
    end
  end
end
