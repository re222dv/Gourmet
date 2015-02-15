class CreateInitialModels < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      # t.integer :type
      t.float :rating
      t.float :latitude
      t.float :longitude
      t.string :telephone
      t.string :homepage
      t.string :street
      t.string :zip
      t.string :city
      t.string :image_url
      t.text :description

      t.timestamps null: false
    end

    create_table :reviews do |t|
      t.belongs_to :place, index: true
      t.belongs_to :user, index: true
      t.float :rating
      t.text :description

      t.timestamps null: false
    end

    create_table :users do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :cuisines do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :cuisines_places, id: false do |t|
      t.belongs_to :cuisine, index: true
      t.belongs_to :place, index: true
    end
  end
end
