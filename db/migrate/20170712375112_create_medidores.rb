class CreateMedidores < ActiveRecord::Migration[5.1]
  def change
    create_table :medidores do |t|
      t.string :nombre
      t.integer :token
      t.string :token_hash
      t.string :ubicacion
      t.string :estado
      t.datetime :ultimaconexion
      t.integer :tiempoconexion
      t.integer :tiempomuestra
      t.string :asociado
      t.timestamps
    end
  end
end
