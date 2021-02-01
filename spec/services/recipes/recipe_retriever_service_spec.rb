# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipes::RecipeRetrieverService do
  subject { described_class.call(id) }

  before do
    Rails.cache.clear
    mock = MockRedis.new
    allow(Redis).to receive(:new).and_return(mock)
  end

  describe '#call', :vcr do
    context 'on success' do
      let(:id) { '437eO3ORCME46i02SeCW46' }

      let(:expected_params) do
        {"sys"=>{"space"=>{"sys"=>{"type"=>"Link", "linkType"=>"Space", "id"=>"kk2bw5ojx476"}}, "id"=>"437eO3ORCME46i02SeCW46", "type"=>"Entry", "createdAt"=>"2018-05-07T13:32:04.593Z", "updatedAt"=>"2018-05-07T13:36:41.741Z", "environment"=>{"sys"=>{"id"=>"master", "type"=>"Link", "linkType"=>"Environment"}}, "revision"=>3, "contentType"=>{"sys"=>{"type"=>"Link", "linkType"=>"ContentType", "id"=>"recipe"}}, "locale"=>"en-US"}, "fields"=>{"title"=>"Crispy Chicken and Rice twith Peas & Arugula Salad", "photo"=>{"sys"=>{"type"=>"Link", "linkType"=>"Asset", "id"=>"5mFyTozvSoyE0Mqseoos86"}}, "calories"=>785, "description"=>"Nice description", "chef"=>{"sys"=>{"type"=>"Link", "linkType"=>"Entry", "id"=>"NysGB8obcaQWmq0aQ6qkC"}}, "tags"=>[{"sys"=>{"type"=>"Link", "linkType"=>"Entry", "id"=>"61Lgvo6rzUIgIGgcOAMgQ8"}}, {"sys"=>{"type"=>"Link", "linkType"=>"Entry", "id"=>"gUfhl28dfaeU6wcWSqs0q"}}]}}
      end

      it 'retrieves the recipe from the api' do
        expect { subject }.to change { Rails.cache.read('437eO3ORCME46i02SeCW46') }
          .from(nil).to(expected_params)
        expect(subject.success?).to eq true
        expect(subject.error).to eq nil
        expect(subject.value.title).to eq 'Crispy Chicken and Rice twith Peas & Arugula Salad'
        expect(subject.value.image_id).to eq '5mFyTozvSoyE0Mqseoos86'
        expect(subject.value.tags_ids).to eq %w[61Lgvo6rzUIgIGgcOAMgQ8 gUfhl28dfaeU6wcWSqs0q]
        expect(subject.value.description).to eq 'Nice description'
        expect(subject.value.chef_id).to eq 'NysGB8obcaQWmq0aQ6qkC'
      end
    end

    context 'on failure' do
      let(:id) { '192873918723981' }

      it 'does not retrieve anything from the api' do
        expect(subject.success?).to eq false
        expect(subject.error).to eq 'No data was found for id 192873918723981'
        expect(subject.value).to eq nil
      end
    end
  end
end
