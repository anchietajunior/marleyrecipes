# frozen_string_literal: true

module Recipes
  class RecipeRetrieverService < ApplicationService
    def initialize(id)
      @id = id
    end

    def call
      result(true, nil, recipe)
    rescue StandardError => e
      result(false, e.message, nil)
    end

    private

    attr_reader :id

    def recipe
      raise "No data was found for id #{id}" if item['fields'].blank?

      Recipe.new recipe_params
    end

    def recipe_params
      {}.tap do |hash|
        hash[:title] = item.dig('fields', 'title')
        hash[:image_id] = item.dig('fields', 'photo', 'sys', 'id')
        hash[:tags_ids] = tags_ids
        hash[:description] = item.dig('fields', 'description')
        hash[:chef_id] = item.dig('fields', 'chef', 'sys', 'id')
      end
    end

    def tags_ids
      return nil if item.dig('fields', 'tags').blank?

      item.dig('fields', 'tags').map do |tag|
        tag.dig('sys', 'id')
      end
    end

    def item
      @item ||= Rails.cache.fetch(id, expires_in: 24.hours) do
        JSON.parse(
          client.get(
            path: "/spaces/#{ENV['CONTENTFUL_SPACE_ID']}/entries/#{id}?access_token=#{ENV['CONTENTFUL_TOKEN']}"
          ).body
        )
      end
    end
  end
end
