module Json

  def json_response(object = '', message = '', status = 200)
       render json: {
          object: object,
          message: message,
          status: status
          }, status: status
  end

 def jsonnotfound_response(object = '')

    render json: {
          object: object,
          message: 'Recurso no encontrado',
          status: 404
          }, status: 404

  end

  def jsonerror_response(object = '',message = '')

    render json: {
          object: object,
          error: message,
          status: 400
          }, status: 400

  end

  def jsonok_response(object = '',message = '')

    render json: {
          object: object,
          message: message,
          status: 200
          }, status: 200

  end



def json_requestall(object)

  @datos = []
  @datos = JSON.parse(object) if valid_json?(object)
  @params = []
  @params_data = []
  @datos.each do |datos|

    unless datos[0].nil?  || datos [1].nil?
      symbol = datos[0]
      @params.push(symbol)
      @params_data.push(datos [1])
      instance_variable_set("@#{symbol}", datos[1])
    end

  end 
 

end



def jsonparser

data = request.body.read
json_requestall(data)

end


def valid_json?(json)
    JSON.parse(json)
    return true
  rescue JSON::ParserError => e
    return false
end




end