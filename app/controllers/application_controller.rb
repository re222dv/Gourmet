require 'application_responder'
require 'json'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :xml, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def record_not_found
    respond_with 'not found', status: 404
  end

  # Overrides responders gem to generate data for html page
  def respond_with(content, settings = {}, &block)
    response = {}
    puts block.inspect
    puts settings.inspect
    if settings[:status] && settings[:status] >= 400
      response[:status] = 'error'
      response[:message] = content
    else
      response[:status] = 'success'
      response[:data] = content
    end

    mimes = collect_mimes_from_class_level
    collector = ActionController::MimeResponds::Collector.new(mimes, request.variant)
    if collector.negotiate_format(request) == 'text/html'
      @content = JSON.generate response, indent: '  ', space: ' ', object_nl: "\n", array_nl: "\n"
    end
    super response, settings, &block
  end
end
