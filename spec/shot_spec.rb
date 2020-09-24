require 'spec_helper'
require 'shared_examples_for_tags_with_styles'

describe 'shot' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:tag) { 'Shot' }
  let(:inner_text) { 'SHOT' }
  let(:element_text_on_fountain) { "!/*SHOT*/#{inner_text}" }
  let(:shot_text) { inner_text }
  let(:fountain) { element_text_on_fountain }
  let(:fdx_result) { fdx_tag_with_content(tag, shot_text) }

  it 'returns the fdx shot type' do
    expect(subject).to match fdx_result
  end

  # this is the same behavior for other tags too
  it "does not wrap file content on a <Text>" do
    expect(subject).not_to match %r{<Content>\n*<Text>}
    expect(subject).not_to match %r{</Text>\n*</Content>}
  end

  it_behaves_like 'tags with styles', 'Shot', 'SHOT'
end
