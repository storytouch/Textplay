require 'spec_helper'
require 'shared_examples_for_tags_with_styles'

describe 'fallback' do
  subject { convert_from_fountain_to_fdx(fountain, cmd_options) }
  let(:fountain) { 'text without type' }

  context "when no fallback is specified" do
    let(:cmd_options) { ['-f'] }

    it 'used GENERAL as fallback' do
      expect(subject).to match fdx_tag_with_content('General', fountain)
    end
  end

  context "when a fallback is specified" do
    let(:fallback_element) { 'action' }
    let(:cmd_options) { ['-f', "--fallback=#{fallback_element}"] }

    it 'used the given fallback element' do
      expect(subject).to match fdx_tag_with_content('Action', fountain)
    end
  end
end
