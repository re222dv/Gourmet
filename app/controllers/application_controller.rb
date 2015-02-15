require 'application_responder'
require 'json'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :xml, :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # Overrides responders gem to generate data for html page
  def respond_with(content, *resources, &block)
    mimes = collect_mimes_from_class_level
    collector = ActionController::MimeResponds::Collector.new(mimes, request.variant)
    if collector.negotiate_format(request) == 'text/html'
      @content = JSON.generate content, indent: '  ', space: ' ', object_nl: "\n", array_nl: "\n"
    end
    super content, *resources, &block
  end
end
