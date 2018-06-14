require 'spec_helper'

describe 'character' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:character_text_on_fountain) { 'PAUL' }
  let(:character_text) { character_text_on_fountain }
  let(:tag) { 'Character' }
  let(:fdx_result) { fdx_tag_with_content(tag, character_text) }
  let(:fountain) do
    <<-FOUNTAIN
      \n#{character_text_on_fountain}
      What was it you said?
    FOUNTAIN
  end

  it 'returns the fdx character type' do
    expect(subject).to match fdx_result
  end

  context 'when text starts with "@ "' do
    let(:character_text) { 'space and lowercase' }
    let(:character_text_on_fountain) { "@#{character_text}" }

    it 'returns the fdx character type' do
      expect(subject).to match fdx_result
    end
  end
end
