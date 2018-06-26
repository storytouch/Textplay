require 'spec_helper'
require 'shared_examples_for_tags_with_styles'

describe 'action' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:tag) { 'Action' }
  let(:inner_text) { 'action' }
  let(:element_text_on_fountain) { inner_text }
  let(:action_text) { inner_text }
  let(:fountain) { element_text_on_fountain }
  let(:fdx_result) { fdx_tag_with_content(tag, action_text) }

  it 'returns the fdx action type' do
    expect(subject).to match fdx_result
  end

  context "when text starts with '! '" do
    let(:action_text) { 'INT. HEADING' }
    let(:inner_text) { "!#{action_text}" }

    it 'returns the fdx action type' do
      expect(subject).to match fdx_result
    end
  end

  it_behaves_like 'tags with styles', 'Action', 'action'
end
