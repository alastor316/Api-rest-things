module Server


def conexiontoken (metodo,request)

username_CORS = "phinet20"
password_CORS = "phinet20@123"
request[:username_CORS] = username_CORS
request[:password_CORS] = password_CORS
#request = request.to_json
url = 'http://localhost/OTP_phiNet20/OTPfunctions_phiNet20.php'
p url
p request

return HTTP.timeout(:write => 20, :connect => 20, :read => 20).post(url,  
	:json => request)

end

#POST
def conexion (ip,port,canal,modo,tiempo,envio)

url = "http://"+ip.to_s+":"+port.to_s

puts url 

request = [{ 'modo' => modo, 'canal' => canal, 'tiempo' => tiempo , 'envio' => envio }].to_json


return HTTP.timeout(:write => 200, :connect => 10, :read => 200).post(url, :body => request)

end

#GET
def conexionget (ip,port,canal,modo,tiempo,op)

url = "http://"+ip.to_s+":"+port.to_s
puts url 

request = { 'modo' => "Hola mundo" }.to_json

return HTTP.timeout(:write => 200, :connect => 5, :read => 200).get(url, :body => request)

end


end