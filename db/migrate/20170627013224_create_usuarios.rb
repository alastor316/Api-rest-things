class CreateUsuarios < ActiveRecord::Migration[5.1]
  def change

    create_table :usuarios do |t|
      t.string :nombre
      t.string :apellido
      t.string :mail
      t.string :direccion
      t.string :telefono
      t.string :password_hash
      t.string :auth_token
      t.datetime :token_created_at
      t.string :privilegio
      t.string :preferencia
      t.datetime :ultimaconexion
      t.string :medidores , array: true

      t.timestamps
    end
  end
end
