class Api::EstadoController < ApplicationController

require 'date'
require 'json'
require 'http'

include Json



before_action :jsonparser


def estadophinet

token = @phinet[0]['token']
ip = @phinet[0]['ip']
date = Time.new
time = date.strftime("%Y-%m-%d %H:%M:%S")

@phinet = Phinet.find_by(token: token)
@phinet.ip = ip
@phinet.ultimaconexion = time
@phinet.save
head :no_content



end






end