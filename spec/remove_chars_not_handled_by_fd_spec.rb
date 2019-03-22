require 'spec_helper'

describe 'remove ASCII chars not handled by Final Draft' do
  subject { convert_from_fountain_to_fdx(fountain) }

  let(:tag) { 'Action' }
  let(:inner_text) { "\x08back\x08space\x08" }
  let(:element_text_on_fountain) { inner_text }
  let(:action_text) { 'backspace' }
  let(:fountain) { element_text_on_fountain }
  let(:fdx_result) { fdx_tag_with_content(tag, action_text) }

  it 'does not export the backspace characters' do
    expect(subject).to match fdx_result
  end
end
