require 'spec_helper'
require 'shared_examples_for_tags_with_styles'

describe 'general' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:tag) { 'General' }
  let(:inner_text) { 'general' }
  let(:element_text_on_fountain) { "#{inner_text}" }
  let(:general_text) { inner_text }
  let(:fountain) { element_text_on_fountain }
  let(:fdx_result) { fdx_tag_with_content(tag, general_text) }

  it 'returns the fdx general type' do
    expect(subject).to match fdx_result
  end

  # this is the same behavior for other tags too
  it "does not wrap file content on a <Text>" do
    expect(subject).not_to match %r{<Content>\n*<Text>}
    expect(subject).not_to match %r{</Text>\n*</Content>}
  end

  context "when text contains '--'" do
    let(:general_text) { 'Line with - -- --- ---' }
    let(:inner_text) { "#{general_text}" }

    it "returns the text without escape the '--'" do
      expect(subject).to match fdx_result
    end
  end

  it_behaves_like 'tags with styles', 'General', 'general'
end
