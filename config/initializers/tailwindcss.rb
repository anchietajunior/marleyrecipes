# frozen_string_literal: true

Rails.application.config.assets.configure do |env|
  env.cache = ActiveSupport::Cache.lookup_store(:null_store)
end
