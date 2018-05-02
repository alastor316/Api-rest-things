class Usuario < ApplicationRecord
include BCrypt
validates :nombre, uniqueness: true, length: { minimum: 2 }
validates :mail, uniqueness: true, presence: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
validates :password_hash, presence: true

scope :usuario_por_nombre, -> (nombre) { where nombre: nombre }
scope :usuario_por_mail, -> (mail) { where mail: mail }

# User.active.inactive
# # SELECT "users".* FROM "users" WHERE "users"."state" = 'active' AND "users"."state" = 'inactive'

  def init
      self.direccion   ||= "Santiago"
      self.telefono    ||= 0000000
      self.privilegio  ||= "Usuario"
      self.preferencia ||= "Ninguna"
      self.direccion   ||= "Las condes"
      self.medidores   ||= [0,0]

  end

  def create(datos)  
    self.nombre        =  datos["nombre"]
    self.apellido      =  datos["apellido"]
    self.mail          =  datos["mail"]
    self.direccion     =  datos["direccion"]
    self.telefono      =  datos["telefono"]
    self.password      =  datos["password"]
    self.privilegio    =  datos["privilegio"]
    self.preferencia   =  datos["preferencia"]
    self.medidores     =  datos["medidores"]
    init
    return true if self.save
 
  end

  def errors_usuario
    self.errors.full_messages
  end


  def generate_auth_token
    token = SecureRandom.hex
    self.update_columns(auth_token: token, token_created_at: Time.zone.now)
    token
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil, token_created_at: nil)
  end


  def update_ultimaconexion
  	self.update_columns(ultimaconexion: Time.zone.now)
  end

  def password=(password)
    self.password_hash = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_hash) == password
  end

##Metodos de busqueda del objeto##

  def medidores_asociados

   Medidore.where(asociado: self.mail).select(:id,:nombre,:ultimaconexion,:tiempoconexion,:tiempomuestra)

  end


##Metodos de la Clase##


  def self.nombre_existe?(nombre)
    Usuario.exists?(nombre: nombre) 
  end

  def self.mail_existe?(mail)

    Usuario.exists?(mail: mail)
              
  end

  def self.password_confirmacion?(password,password_confirmacion)


    return false if password == password_confirmacion
    return true 


  end

  def self.parametros_estan?(params)
    if (parametros_creacion - params).empty?
      return false 
    else
      return true 
    end        
  end

  def self.parametros_creacion

  array = []
  array.push('nombre')
  array.push('mail')
  array.push('password')
  array.push('password_confirmacion')

  return array

  end

##Metodos de busqueda de la clase##

  def self.buscar_por_medidor(nombre)
    Usuario.exists?(nombre: nombre) 
  end

end
