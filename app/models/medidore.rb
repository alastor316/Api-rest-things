class Medidore < ApplicationRecord

  validates_presence_of :nombre
  validates_presence_of :token
  validates_numericality_of :token, :only_integer => true
  #scope :status, -> (status) { where status: status }
  #scope :location, -> (location_id) { where location_id: location_id }
  #scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
  
      # t.string :nombre
      # t.string :token
      # t.string :ubicacion
      # t.string :estado
      # t.datetime :ultimaconexion
      # t.integer :tiempoconexion
      # t.integer :tiempomuestra
      # t.string :asociado
      # t.timestamps

  def init
    self.estado  		  = "Desactivada"
    self.ubicacion 		||= "Santiago"
    self.asociado   	||= "oscar@gmail.com"
	self.tiempoconexion   = 60
	self.tiempomuestra    = 5
  end

  def create(datos)
    self.nombre         =  datos["nombre"]
    self.token          =  datos["token"]
    self.ubicacion    	=  datos["ubicacion"]
    self.asociado	  	=  datos["asociado"]
    init
    return true if self.save
  end

  def errors_medidor
    self.errors.full_messages
  end
  
  def update_ultimaconexion
  	self.update_columns(ultimaconexion: Time.zone.now)
  end

  def asociar_usuario(mail)
  	self.update_columns(asociado: mail)
  end

  def desasociar_usuario
  	self.update_columns(asociado: '')
  end

##Metodos de la Clase##

  def self.nombre_existe?(nombre)
    Medidore.exists?(nombre: nombre) 
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
	  array.push('token')
	  return array
  end


end
