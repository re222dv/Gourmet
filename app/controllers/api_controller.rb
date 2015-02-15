class ApiController < ApplicationController

  def initialize
    super
    @versions = {
        1 => 0,
    }
  end

  def index
    respond_with({
        versions: @versions.map{|major, minior| {
            major: major,
            minior: minior,
            url: version_path(major)
        }}
    })
  end

  def show
    unless @versions.include? params[:version].to_i
      return respond_with [], status: :not_found
    end

    version = version_path(params[:version])
    # Get all routes starting with the specified version
    routes = Rails.application.routes.routes.select { |route| route.path.spec.to_s.starts_with? version }
    # Group all routes with the same path (with different methods)
    routes = routes.group_by { |route| route.path.spec.to_s }
    # Matches a method name
    pattern = /([A-Z]{3,6})/
    routes = routes.map do |path, methods|
      # Remove format flag
      path = path[0..-11] if path.end_with? '(.:format)'
      # Rewrite method to normal string name
      methods = methods.map { |route| pattern.match(route.constraints[:request_method].to_s)[1] }
      {
          url: path,
          methods: methods
      }
    end
    respond_with routes
  end
end
