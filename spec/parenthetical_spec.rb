require 'spec_helper'

describe 'parenthetical' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:tag) { 'Parenthetical' }
  let(:parenthetical_text) { 'starting the engine' }
  let(:parenthetical_on_fdx) { /\(#{parenthetical_text}\)/ }
  let(:fdx_result) { fdx_tag_with_content(tag, parenthetical_on_fdx) }

  # we need to have a character before it
  let(:fountain) do
    <<-FOUNTAIN
      \nPAUL
      (#{parenthetical_text})
    FOUNTAIN
  end

  it 'returns the fdx parenthetical type' do
    expect(subject).to match fdx_result
  end
end
