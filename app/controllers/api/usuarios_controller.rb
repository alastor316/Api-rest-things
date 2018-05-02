class Api::UsuariosController < ApplicationController
include Json
#before_action :require_login!
#before_action :require_admin!, only: [:create, :update, :destroy]
before_action :jsonparser , except:[:index, :show]
before_action :set_usuario, only: [:show, :update, :destroy]

swagger_controller :users, "User Management"
swagger_api :create do
  summary "To create user"
  notes "Implementation notes, such as required params, example queries for apis are written here."
  param :form, "user[name]", :string, :required, "Name of user"
  param :form, "user[last_name]", :string, :required, "Last name of user"
  param :form, "user[email]", :string, :required, "Mail of user"
  param :form, "user[password]", :string, :required, "Password of user"
  param_list :form, "user[status]", :string, :required, "Status of user, can be active or inactive"
  response :success
  response :unprocessable_entity
 # response :500, "Internal Error"
end


 # GET /usuarios
  def index
    buscar_por_mail if params_present?
    @response ||= Usuario.all.select(*params_permitidos_enviar)
    json_response(@response)
  end

  # # POST /usuarios
  def create

    usuario = Usuario.new
    if Usuario.parametros_estan?(@params)
       jsonerror_response("Faltan datos de registro")
    elsif Usuario.nombre_existe?(@nombre)
       jsonerror_response("Usuario ya está registrado")
    elsif Usuario.mail_existe?(@mail)
       jsonerror_response("Mail ya está registrado")
    elsif Usuario.password_confirmacion?(@password,@password_confirmacion)
      jsonerror_response("Passwords no coinciden")
    elsif usuario.create(@datos)
          jsonok_response(usuario,"Usuario creado")
    else
          jsonerror_response(usuario.errors_usuario)
    end

  end

  # GET /usuarios/:id
  def show
    json_response(@usuario.attributes.slice(*params_permitidos_enviar))
  end

  ## Metodos especiales ##
  def last_user
    object = Usuario.last.attributes.slice(*params_permitidos_enviar)
    json_response(object,"Ultimo Usuario Creado")
  end

  def medidores  
    if params_present?
    buscar_medidores_por_mail
    json_response(@response)
    else
    set_usuario
    json_response(@usuario.medidores_asociados)
    end
  end



  # # PUT /usuarios/:id
  def update
    case @variable
    when "privilegio"      
    if params_privilegios.include?(@dato)
      @usuario.update_columns(Hash[@variable, @dato])
      jsonok_response(@usuario.attributes.slice(*params_permitidos_enviar),"Privilegio cambiado con exito")
    else
      jsonerror_response("Privilegio no valido, prueba Administrado, Tecnico o Comercial")
    end

    when "mail"
    if Usuario.mail_existe?(@mail) 
      jsonerror_response("Mail ya existe")  
    else
      if es_correo_valido?(@dato)
      @usuario.update_columns(Hash[@variable, @dato]) 
      jsonok_response(@usuario.attributes.slice(*params_permitidos_enviar),"Mail cambiado con exito")
      else
      jsonerror_response("Mail no valido")
      end
    end

    when "nombre"
     if Usuario.nombre_existe?(@nombre)
      jsonerror_response("Nombre ya existe")
     else
      if Medidore.exists?(asociado: @usuario[:nombre])
      @medidore = Medidore.find_by!(asociado: @usuario[:nombre])
      @medidore.update_columns(asociado: @dato)    
      end 
      @usuario.update_columns(Hash[@variable, @dato]) 
      jsonok_response(@usuario.attributes.slice(*params_permitidos_enviar),"Nombre cambiado con exito")
     end
    else
      @usuario.update_columns(Hash[@variable, @dato]) 
      jsonok_response(@usuario.attributes.slice(*params_permitidos_enviar),"Parametro cambiado con exito")
    end
  end

  # # DELETE /usuarios/:id
  def destroy
    json_response("Usuario Eliminado") if @usuario.destroy
  end


private

def params_permitidos_enviar
   return params_permitidos_enviar = ['id',
                                  'nombre',
                                  'apellido',
                                  'mail',
                                  'privilegio']
end

def params_privilegios
   return params_privilegios = ['Administrador','Usuario']
end


def set_usuario
    @usuario ||= Usuario.find(params[:id])
end


def  es_correo_valido? (correoE)
(correoE =~ /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z])+$/)==0
end

  def params_present?
    true if params[:mail].present?     
  end


  def buscar_por_mail
      if Usuario.mail_existe?(params[:mail]) 
        @response = Usuario.usuario_por_mail(params[:mail]).select(*params_permitidos_enviar)
      else
        @response = "Usuario no está registrado"
      end
  end

  def buscar_medidores_por_mail
      if Usuario.mail_existe?(params[:mail])
        @response = Usuario.usuario_por_mail(params[:mail])[0].medidores_asociados
      else
        @response = "Usuario no está registrado"
      end
  end


end
