require 'application_responder'
require 'json'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :xml, :json

  before_action :validate_key
  before_action :validate_user, except: [:index, :show]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def bad_request(message = 'bad request', options = {})
    options[:status] = 400
    respond_with message, options
  end

  def not_found
    respond_with 'not found', status: 404
  end

  def forbidden
    respond_with 'authorizaton required', status: 401
  end

  def paginate(items)
    offset = params[:offset].to_i
    offset = 0 if offset < 0
    limit = params[:limit].to_i
    limit = 10 if limit < 1
    limit = 100 if limit > 100
    query = request.query_parameters.select do |key, value|
      not %w(offset limit).include? key
    end.map { |key, value| "&#{key}=#{value}" }.join
    url = "#{url_for only_path: true}?offset=#{offset + limit}&limit=#{limit}#{query}"
    Pagination.new items, offset, limit, url
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
      format.json { render json: response, status: settings[:status] }
      format.xml { render xml: response, status: settings[:status] }
    end
  end

  private

  def validate_key
    begin
      key = request.headers['Key'] || params[:key]
      Locksmith::ApiHelper.validate_key key
      $key = params[:key]
    rescue Locksmith::ApiHelper::InvalidKey
      bad_request('Invalid API key')
    end
  end

  def validate_user
    user = User.where(name: request.headers['Username']).first

    if user.nil? or not user.authenticate request.headers['Password']
      forbidden
    else
      @current_user = user
    end
  end
end
