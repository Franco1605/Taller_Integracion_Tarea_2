class CreateHamburgers < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :hamburgers do |t|
      t.text :nombre
      t.integer :precio
      t.text :descripcion
      t.text :imagen
      t.hstore :ingredientes, :array => true, default: [], null: false

      t.timestamps
    end
  end
end
