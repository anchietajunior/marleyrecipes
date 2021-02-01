# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipes::RecipesRetrieverService do
  subject { described_class.call }

  describe '#call', :vcr do
    context 'on success' do
      it 'retrieves reciples from the api' do
        expect(subject.success?).to eq true
        expect(subject.error).to eq nil
        expect(subject.value).to_not eq nil
        expect(subject.value.length).to eq 4
      end
    end

    context 'on failure' do
      it 'does not retrieve anything from the api' do
        expect(subject.success?).to eq false
        expect(subject.error).to eq 'No data was found'
        expect(subject.value).to eq nil
      end
    end
  end
end
