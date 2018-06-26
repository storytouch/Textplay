require 'spec_helper'
require 'shared_examples_for_tags_with_styles'

describe 'transition' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:inner_text) { 'CUT TO:' }
  let(:element_text_on_fountain) { inner_text }
  let(:tag) { 'Transition' }
  let(:fdx_result) { fdx_tag_with_content(tag, inner_text) }
  let(:post_text) { 'TO:' }
  let(:fountain) do
    <<-FOUNTAIN
      \n#{element_text_on_fountain}\n
    FOUNTAIN
  end

  it 'returns the fdx transition type' do
    expect(subject).to match fdx_result
  end

  context 'when text starts with "> "' do
    let(:inner_text) { 'CORTAR PARA' }
    let(:element_text_on_fountain) { "> #{inner_text}" }

    it 'returns the fdx transition type' do
      expect(subject).to match fdx_result
    end
  end
end
