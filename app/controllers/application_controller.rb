require 'application_responder'
require 'json'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :xml, :json

  before_action :validate_key
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected

  def bad_request(message = 'bad request', options = {})
    options[:status] = 400
    respond_with message, options
  end

  def not_found
    respond_with 'not found', status: 404
  end

  # Overrides responders gem to generate JSEND responses and data for html page
  def respond_with(content, settings = {})
    response = {}

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
      response[:data] = response[:data].as_json if response[:data].respond_to? :as_json
      @content = JSON.generate response, indent: '  ', space: ' ', object_nl: "\n", array_nl: "\n"
    end

    # Send block to make rails not force a 204 no content on update even if validation fails
    # or an exceptions is thrown
    super response, settings  do |format|
      format.json { render json: response }
      format.xml { render xml: response }
    end
  end

  private

  def validate_key
    begin
      Locksmith::ApiHelper.validate_key params[:key]
    rescue Locksmith::ApiHelper::InvalidKey
      bad_request('Invalid API key')
    end
  end
end
