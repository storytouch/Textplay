require 'spec_helper'
require 'shared_examples_for_tags_with_styles'

describe 'character' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:inner_text) { 'VITO' }
  let(:element_text_on_fountain) { inner_text }
  let(:pre_text) { '' }
  let(:post_text) { '' }
  let(:tag) { 'Character' }
  let(:fdx_result) { fdx_tag_with_content(tag, inner_text) }
  let(:force_prefix) { '@' }
  let(:fountain) do
    <<-FOUNTAIN
      \n#{element_text_on_fountain}
      I'm gonna make him an offer he can't refuse
    FOUNTAIN
  end

  it 'returns the fdx character type' do
    expect(subject).to match fdx_result
  end

  context 'when text starts with "@ "' do
    let(:inner_text) { 'space and lowercase' }
    let(:element_text_on_fountain) { "@#{inner_text}" }

    it 'returns the fdx character type' do
      expect(subject).to match fdx_result
    end
  end

end
