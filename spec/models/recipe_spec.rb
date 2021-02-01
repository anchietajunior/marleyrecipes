# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe do
  before do
    Rails.cache.clear
    mock = MockRedis.new
    allow(Redis).to receive(:new).and_return(mock)
  end

  after(:all) do
    Rails.cache.clear
  end

  subject { described_class.new params }

  context 'when initializing with all attributes', :vcr do
    let(:params) do
      {
        title: 'Eggs with bacon',
        image_id: '5mFyTozvSoyE0Mqseoos86',
        tags_ids: %w[61Lgvo6rzUIgIGgcOAMgQ8 gUfhl28dfaeU6wcWSqs0q],
        description: 'You have to cook it with a pan',
        chef_id: 'NysGB8obcaQWmq0aQ6qkC'
      }
    end

    it 'has the correct attributes' do
      expect(subject.title).to eq 'Eggs with bacon'
      expect(subject.image_id).to eq '5mFyTozvSoyE0Mqseoos86'
      expect(subject.tags_ids).to eq %w[61Lgvo6rzUIgIGgcOAMgQ8 gUfhl28dfaeU6wcWSqs0q]
      expect(subject.description).to eq 'You have to cook it with a pan'
      expect(subject.chef_id).to eq 'NysGB8obcaQWmq0aQ6qkC'
    end

    it 'has a image_url' do
      expect(subject.image_url).to eq 'https://images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg'
      expect(Rails.cache.read('5mFyTozvSoyE0Mqseoos86')).to eq 'https://images.ctfassets.net/kk2bw5ojx476/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg'
    end

    it 'has two tags' do
      expect(subject.tags).to eq ['gluten free', 'healthy']
      expect(Rails.cache.read('61Lgvo6rzUIgIGgcOAMgQ8')).to eq 'gluten free'
      expect(Rails.cache.read('gUfhl28dfaeU6wcWSqs0q')).to eq 'healthy'
    end

    it 'has a chef_name' do
      expect(subject.chef_name).to eq 'Jony Chives'
      expect(Rails.cache.read('NysGB8obcaQWmq0aQ6qkC')).to eq 'Jony Chives'
    end
  end

  context 'when initializing without photo, chef and tags' do
    let(:params) do
      {
        title: 'Eggs with bacon',
        description: 'You have to cook it with a pan'
      }
    end

    it 'has the correct attributes' do
      expect(subject.title).to eq 'Eggs with bacon'
      expect(subject.image_id).to eq nil
      expect(subject.tags_ids).to eq nil
      expect(subject.description).to eq 'You have to cook it with a pan'
      expect(subject.chef_id).to eq nil
    end

    it 'has a image_url' do
      expect(subject.image_url).to eq nil
    end

    it 'has two tags' do
      expect(subject.tags).to eq []
    end

    it 'has a chef_name' do
      expect(subject.chef_name).to eq nil
    end
  end
end
