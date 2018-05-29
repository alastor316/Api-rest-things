class Api::MedidoresController < ApplicationController

include Json
#before_action :require_login!
# before_action :require_admin!, only: [:create, :update, :destroy]
before_action :jsonparser , except:[:index, :show] 
before_action :set_medidor, only: [:show, :update, :destroy]

  # GET /Medidores
  def index
    @medidores = Medidore.all
    json_response(@medidores)
  end

  # POST /Medidores
  def create
    medidor = Medidore.new
    if Medidore.parametros_estan?(@params)
      jsonerror_response("Faltan parametros")
    elsif Medidore.nombre_existe?(@nombre)
      jsonerror_response("Medidor ya está registrado")
    elsif medidor.create(@datos)
      jsonok_response(medidor,"Medidor creado")
    else 
      jsonerror_response(medidor.errors_medidor)
    end
  end

  # GET /Medidores/:id
  def show
    json_response(@medidor.attributes.slice(*params_permitidos_enviar))
  end

  # PUT /Medidores/:id
  def update
    unless @variable.nil?
    case @variable 
      when "nombre" 
        if Medidore.nombre_existe?(@dato)
          jsonerror_response("Medidor ya está registrado")
        else
          @medidor.update_columns(Hash[@variable, @dato])
          jsonok_response(@medidor.attributes.slice(*params_permitidos_enviar),"Nombre cambiado con exito")
        end 
      when "asociado"    
        if Usuario.mail_existe?(@dato)
         @medidor.desasociar_usuario
         @medidor.asociar_usuario(@dato)
         jsonok_response(@medidor.attributes.slice(*params_permitidos_enviar),"Asociado cambiado con exito")
         # Usuario.find_by(mail: @medidor.asociado).desasociar_medidor(@medidor.token)
         # @medidor.asociar_usuario(@dato)
         # if medidores.nil?
         #  #desasociar phinet
         #  @medidor.desasociar_usuario
         #  #asociar phinet
         #  @medidor.asociar_usuario(@dato)
         #  jsonerror_response("Medidor asociado a #{@dato}")
         #  else
         #   if @a.include? @phinet[:token]
         #   jsonerror_response("Phinet ya esta asociada a #{@dato}")
         #   else
         #   #desasociar phinet
         #   @user= Usuario.find_by(nombre: @phinet[:asociado]) if Usuario.find_by(nombre: @phinet[:asociado])
         #   s = @phinet[:token].to_s if @user
         #   i = @user[:phinets].index(s) if @user
         #   @user[:phinets].delete(@user[:phinets][i]) if @user
         #   @user.save if @user
         #   #asocio phinet
         #   @user = Usuario.find_by(nombre: @dato)
         #   @user[:phinets] << @phinet[:token]
         #   @user.save
         #   @valid = true 
         #   end    
         # end
        elsif @dato == ''
         @medidor.desasociar_usuario
         @medidor.asociar_usuario("oscar@gmail.com")
         jsonok_response(@medidor.attributes.slice(*params_permitidos_enviar),"Asociado a administrado")
        else
          jsonerror_response("Usuario no esta registrado")
        end
      when "estado"
          if params_estado.include?(@dato)
            @medidor.update_columns(Hash[@variable, @dato])
            jsonok_response(@medidor.attributes.slice(*params_permitidos_enviar),"Estado cambiado con exito")
          else
            jsonerror_response("Debe probar con Activada o Desactivada")
          end
      
      else
          if params_permitidos_update.include?(@variable)
            @medidor.update_columns(Hash[@variable, @dato])
            jsonok_response(@medidor.attributes.slice(*params_permitidos_enviar),"#{@variable} cambiada con exito")
          else
            jsonerror_response("Variable no conocida")
          end
    end
    else
      jsonerror_response("Debes enviar correctamente los parametros")
    end
  end

  # DELETE /Medidores/:id
  def destroy
    json_response("Medidor Eliminado") if @medidor.destroy
  end

  private

  def params_permitidos_enviar
     return params_permitidos_enviar = ['nombre',
                                        'ubicacion',
                                        'estado',
                                        'ultimaconexion',
                                        'tiempoconexion',
                                        'tiempomuestra',
                                        'asociado']
  end

  def params_permitidos_update
     return params_permitidos_enviar = ['nombre',
                                        'ubicacion',
                                        'estado',
                                        'ultimaconexion',
                                        'tiempoconexion',
                                        'tiempomuestra',
                                        'asociado']
  end


  def params_estado
     return params_estado = ['Activada','Desactivada']
  end

  def set_medidor
    @medidor = Medidore.find(params[:id])
  end


end