require 'elasticsearch/rails/tasks/import'

namespace :elasticsearch do
  task place: :environment do
    Place.__elasticsearch__.create_index! force: true
    Place.__elasticsearch__.refresh_index!
  end
end
