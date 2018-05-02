class Api::DataController < ApplicationController

require 'date'
require 'json'
require 'http'

include Json

before_action :require_login!
before_action :jsonparser

# before_action :comprobacionmedidor  , :except => [:dataestado]


def comprobacionmedidor

if @privilegio == 'Administrador'

p "Tienes todos los permisos"

else

@medidor = Medidore.find_by(token: @token)
if @medidor[:asociado] == Usuario.find_by(mail: @mailvalidacion).nombre
else

p "No tienes asociada esta phinet"
jsonerror_response("No tienes asociada este Medidor #{@medidor[:nombre]}")

end


end




end


def datahistorico


@phinet = Phinet.find_by!(token: @token)
@canal = @phinet.canal.order(numero: :asc)
f1 =@fecha1.split('-')
year1 = f1[0].to_i
month1 = f1[1].to_i  
day1 = f1[2].to_i
f2 =@fecha2.split('-')
year2 = f2[0].to_i
month2 = f2[1].to_i  
day2 = f2[2].to_i 

start_period = Date.new(year1, month1, day1)
end_period = Date.new(year2, month2, day2)

@array = Array.new


@canal.each do |a|

#buscar curvas por fechas
rawcurva = a.curva.where(:fecha => start_period..end_period).pluck(:mppt, :fecha, :id, :temperatura, :radiacion)

@array.push(rawcurva)


end





render json: {canal: @canal, curva: @array}

end



#este metodo hay que dejarlo porque tiene que ver con inicar la conexión a los equipos phinets.
def dataconectarse

#reemplazar por token
phinet = Phinet.find_by(token: @token)

ip = phinet.ip
port = phinet.port
date = Time.new
time = date.strftime("%Y-%m-%d %H:%M:%S")

#este metodo esta bien porque tiene que ser inmediata el tiempo de conexión.
begin

modo = 0
canal = ''
tiempo = ''
variable = ''
s = conexionget(ip,port,canal,modo,tiempo,variable)
recv = s.body.readpartial
data =  JSON.parse(recv)
token = data["token"]


if Phinet.find_by(token: token).nil?

puts "token no coincide" 
jsonerror_response("Token no coincide")

else

puts "token coincide" 
phinet.estado = 'Ok'
phinet.ultimaconexion = time
phinet.save
render json: {estado: 'OK', time: time}


end


rescue HTTP::TimeoutError => e

phinet.estado = 'Sin conexión'
phinet.save
puts e
jsonerror_response("No se pudo establecer la conexión")

rescue Exception => e

phinet.estado = 'Sin conexión'
phinet.save
puts e
jsonerror_response("Conexión rechazada")

end


sleep 1



end



def dataestado

@medidores = Medidore.all.order(:id)
@usuario = Usuario.all.order(:id)

render json: {data: @medidores, usuario: @usuario}


end



end