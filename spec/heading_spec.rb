require 'spec_helper'

describe 'heading' do
  subject { convert_from_fountain_to_fdx(fountain) }
  let(:tag) { 'Scene Heading' }
  let(:fdx_result) { fdx_tag_with_content(tag, heading_text) }
  let(:fountain) do
    <<-FOUNTAIN
      \n#{fountain_content}\n
    FOUNTAIN
  end

  context 'when text starts with reserved heading prefix' do
    heading_prefix = ['INT', 'EXT', 'EST', 'INT./EXT', 'INT/EXT', 'I/E']
    heading_prefix.each do |prefix|
      context "and prefix is #{prefix}" do
        let(:heading_text) { "#{prefix}. HEADING" }
        let(:fountain_content) { "#{prefix}. HEADING" }

        it 'returns the fdx heading type' do
          expect(subject).to match fdx_result
        end
      end
    end
  end

  context 'when text starts with ". "' do
    let(:heading_text) { 'heading' }
    let(:fountain_content) { ". #{heading_text}" }

    it 'returns the fdx heading type' do
      expect(subject).to match fdx_result
    end
  end
end
