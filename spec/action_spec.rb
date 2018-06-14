require 'spec_helper'

describe 'action' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:tag) { 'Action' }
  let(:fountain_text) { 'action' }
  let(:action_text) { fountain_text }
  let(:fountain) { fountain_text }
  let(:fdx_result) { fdx_tag_with_content(tag, action_text) }

  it 'returns the fdx action type' do
    expect(subject).to match fdx_result
  end

  context "when text starts with '! '" do
    let(:action_text) { 'INT. HEADING' }
    let(:fountain_text) { "!#{action_text}" }

    it 'returns the fdx action type' do
      expect(subject).to match fdx_result
    end
  end
end
