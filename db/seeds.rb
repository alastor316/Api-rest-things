require 'date'

    Usuario.create(nombre: 'Oscar', apellido: 'Castillo', mail: 'oscar@gmail.com', direccion: "Carlos lira 2132", telefono: "5699488576",password_hash: '0002', privilegio: 'Administrador', preferencia: 'otro', auth_token: 123123)
    Usuario.create(nombre: 'Luis', apellido: 'Ibarra', mail: 'luis@gmail.com', direccion: "Avd. San 2132", telefono: "5699218575", password_hash: '0003', privilegio: 'Administrador', preferencia: 'otro', auth_token: 41242121)
    Medidore.create(nombre: 'Md001', token: 146, ubicacion: 'Santiago',  estado: 'OK', tiempoconexion: 1000, ultimaconexion:'0/0/0', asociado: 'oscar@gmail.com')
    Medidore.create(nombre: 'Md002', token: 120, ubicacion: 'Santiago',  estado: 'OK', tiempoconexion: 1000, ultimaconexion:'0/0/0', asociado: 'oscar@gmail.com')

  