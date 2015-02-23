module Hateoas
  include ActionDispatch::Routing::PolymorphicRoutes

  # noinspection RubySuperCallWithoutSuperclassInspection
  def as_json(options = {})
    json = super options

    return json if (options[:except] and options[:except].include? :url) or
                   (options[:only] and not options[:only].include? :url)

    if self.instance_of? Review
      json['url'] = Rails.application.routes.url_helpers.place_review_path self, place_id: self.place_id
    else
      json['url'] = polymorphic_path self
    end

    json['url'] += "?key=#{$key}" unless $key.nil?

    json
  end

  # polymorphic_path will call the other url helpers on us, delegate them to url_helpers
  def method_missing(method, *args)
    Rails.application.routes.url_helpers.send(method, *args)
  end
end
