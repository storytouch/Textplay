require 'spec_helper'
require 'shared_examples_for_tags_with_styles'

describe 'parenthetical' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:tag) { 'Parenthetical' }
  let(:inner_text) { 'starting the engine' }
  let(:element_text_on_fountain) { inner_text }
  let(:parenthetical_on_fdx) { /\(#{element_text_on_fountain}\)/ }
  let(:fdx_result) { fdx_tag_with_content(tag, parenthetical_on_fdx) }

  # we need to have a character before it
  let(:fountain) do
    <<-FOUNTAIN
      \nPAUL
      \(#{element_text_on_fountain}\)
    FOUNTAIN
  end

  it 'returns the fdx parenthetical type' do
    expect(subject).to match fdx_result
  end

  it_behaves_like 'tags with styles', 'Parenthetical', '\(starting the engine\)'
end
