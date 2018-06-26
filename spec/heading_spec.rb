require 'spec_helper'
require 'shared_examples_for_tags_with_styles'

describe 'heading' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:tag) { 'Scene Heading' }
  let(:inner_text) { 'HEADING' }
  let(:element_text_on_fountain) { "EXT #{inner_text}" }
  let(:heading_on_fdx) { element_text_on_fountain }
  let(:post_text) { 'DIA' }
  let(:fdx_result) { fdx_tag_with_content(tag, heading_on_fdx) }
  let(:fountain) do
    <<-FOUNTAIN
      \n#{element_text_on_fountain}\n
    FOUNTAIN
  end

  context 'when text starts with reserved heading prefix' do
    heading_prefix = ['INT', 'EXT', 'EST', 'INT./EXT', 'INT/EXT', 'I/E']
    heading_prefix.each do |prefix|
      context "and prefix is #{prefix}" do
        let(:element_text_on_fountain) { "#{prefix}. #{inner_text}" }

        it 'returns the fdx heading type' do
          expect(subject).to match fdx_result
        end
      end
    end
  end

  context 'when text starts with ". "' do
    let(:inner_text) { 'heading' }
    let(:heading_on_fdx) { inner_text }
    let(:element_text_on_fountain) { ". #{inner_text}" }

    it 'returns the fdx heading type' do
      expect(subject).to match fdx_result
    end
  end
end
