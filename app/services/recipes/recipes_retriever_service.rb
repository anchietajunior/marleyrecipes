# frozen_string_literal: true

module Recipes
  class RecipesRetrieverService < ApplicationService
    def call
      result(true, nil, recipes)
    rescue StandardError => e
      result(false, e.message, nil)
    end

    private

    def recipes
      raise 'No data was found' if items.blank?

      items.map do |item|
        Recipe.new recipe_params(item)
      end
    end

    def recipe_params(item)
      {}.tap do |hash|
        hash[:id] = item.dig('sys', 'id')
        hash[:title] = item.dig('fields', 'title')
        hash[:image_id] = item.dig('fields', 'photo', 'sys', 'id')
      end
    end

    def items
      @items ||= JSON.parse(
        client.get(
          path: "/spaces/#{ENV['CONTENTFUL_SPACE_ID']}/entries/?select=sys.id,fields&content_type=recipe&access_token=#{ENV['CONTENTFUL_TOKEN']}"
        ).body
      ).with_indifferent_access[:items]
    end
  end
end
