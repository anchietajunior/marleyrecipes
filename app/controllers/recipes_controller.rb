# frozen_string_literal: true

class RecipesController < ApplicationController
  caches_page :show

  def index
    result = Recipes::RecipesRetrieverService.call
    flash[:notice] = result.error unless result.success?
    @recipes = result.value
  end

  def show
    result = Recipes::RecipeRetrieverService.call(allowed_params[:id])
    flash[:notice] = result.error unless result.success?
    @recipe = result.value
  end

  private

  def allowed_params
    params.permit!
  end
end
