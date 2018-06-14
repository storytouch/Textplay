require 'spec_helper'

describe 'transition' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:transition_text_on_fountain) { 'CUT TO:' }
  let(:transition_text) { transition_text_on_fountain }
  let(:tag) { 'Transition' }
  let(:fdx_result) { fdx_tag_with_content(tag, transition_text) }
  let(:fountain) do
    <<-FOUNTAIN
      \n#{transition_text_on_fountain}\n
    FOUNTAIN
  end

  it 'returns the fdx transition type' do
    expect(subject).to match fdx_result
  end

  context 'when text starts with "> "' do
    let(:transition_text) { 'CORTAR PARA' }
    let(:transition_text_on_fountain) { "> #{transition_text}" }

    it 'returns the fdx transition type' do
      expect(subject).to match fdx_result
    end
  end
end
