class Accion
  def initialize(nombreEmpresa, cantidad, cotizacion, fecha)
    @nombreEmpresa = nombreEmpresa
    @cantidad = cantidad
    @cotizacion = cotizacion
    @fecha = fecha
  end

  def nombreEmpresa
    @nombreEmpresa
  end

  def cantidad
    @cantidad
  end
end

class Agente
  def initialize(efectivo)
    @efectivo = efectivo
    @acciones = Set.new
  end

  def efectivo
    @efectivo
  end

  def comprar(nombreEmpresa, cantidad, cotizacion, fecha)
    @efectivo -= (cantidad*cotizacion)
    @acciones.add(Accion.new(nombreEmpresa, cantidad, cotizacion, fecha))
  end

  def vender(nombreEmpresa, cotizacion)
    @efectivo += (cantidadAccionesDe(nombreEmpresa)*cotizacion)
    @acciones.delete_if { |accion| accion.nombreEmpresa == nombreEmpresa }
  end

  def cantidadAccionesDe(nombreEmpresa)
    #Ver como hacer con inject
    #accionesDeEmpresa = (@acciones.keep_if {|accion| accion.nombreEmpresa == nombreEmpresa})
    #accionesDeEmpresa.inject { |sum, accion| sum + accion.cantidad }
    sum = 0
    @acciones.each do |accion|
      if accion.nombreEmpresa == nombreEmpresa
        sum += accion.cantidad
      end
    end
    sum
  end
end