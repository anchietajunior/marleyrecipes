# frozen_string_literal: true

class ApplicationService
  Result = Struct.new(:success?, :error, :value)

  def self.call(*args)
    new(*args).call
  end

  protected

  def result(success, error, value)
    Result.new(success, error, value)
  end

  def client
    Excon.new(ENV['CONTENTFUL_BASE_URL'])
  end
end
