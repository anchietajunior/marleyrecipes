# frozen_string_literal: true

class Recipe
  attr_accessor :id, :title, :image_id, :tags_ids, :description, :chef_id

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def image_url
    return nil if image_id.blank?

    Rails.cache.fetch(image_id, expires_in: 24.hours) do
      JSON.parse(
        client.get(
          path: "/spaces/#{ENV['CONTENTFUL_SPACE_ID']}/assets/#{image_id}?access_token=#{ENV['CONTENTFUL_TOKEN']}"
        ).body
      ).dig('fields', 'file', 'url').gsub('//', 'https://')
    end
  end

  def tags
    return [] if tags_ids.blank?

    tags_ids.map do |tag_id|
      Rails.cache.fetch(tag_id, expires_in: 24.hours) do
        JSON.parse(
          client.get(
            path: "/spaces/#{ENV['CONTENTFUL_SPACE_ID']}/entries/#{tag_id}?access_token=#{ENV['CONTENTFUL_TOKEN']}"
          ).body
        ).dig('fields', 'name')
      end
    end
  end

  def chef_name
    return nil if chef_id.blank?

    Rails.cache.fetch(chef_id, expires_in: 24.hours) do
      JSON.parse(
        client.get(
          path: "/spaces/#{ENV['CONTENTFUL_SPACE_ID']}/entries/#{chef_id}?access_token=#{ENV['CONTENTFUL_TOKEN']}"
        ).body
      ).dig('fields', 'name')
    end
  end

  private

  def client
    Excon.new(ENV['CONTENTFUL_BASE_URL'])
  end
end
