module Comercial

 ##VARIABLES GLOBALES##

  # $token = datos[0]["token"]
  # $estacion = datos[0]["estacion"]
  # #canal
  # $canal = datos[0]["canal"]
  # $tiempo = datos[0]["tiempo"].to_i
  # $variable = datos[0]["variable"].to_i
  # #curvas crear
  # $fecha = datos[0]["fecha"]
  # $mppt = datos[0]["mppt"]
  # $muestras = datos[0]["muestras"]
  # #curva historico
  # $fecha1 = datos[0]["fecha1"]
  # $fecha2 = datos[0]["fecha2"]
  # #muestras
  # $mediciones = datos[0]["mediciones"]



def dataestadocomercial

@usuario = Usuario.where(mail: @mailvalidacion)
@phinet = Phinet.where(asociado: @usuario[0].nombre)
@array = Array.new

@phinet.each do |a|

@array.push(a.canal.order(:numero))

end

render json: {data: @phinet, canal: @array, usuario: @usuario}

end







end