require 'test/unit'
require 'date'
require 'set'

class XXX < Test::Unit::TestCase
  def testComprar
    nombreEmpresa = "GGAL"
    efectivoInicial = 1000000
    agente = Agente.new(efectivoInicial)
    cantidad = 75
    cotizacionCompra = 13
    fecha = Date.new(2014, 4, 1)

    agente.comprar(nombreEmpresa, cantidad, cotizacionCompra, fecha)

    assert_equal(999025, agente.efectivo)
    assert_equal(75, agente.cantidadAccionesDe(nombreEmpresa))
  end

  def testVender
    nombreEmpresa = "GGAL"
    efectivoInicial = 1000000
    agente = Agente.new(efectivoInicial)
    cantidad = 75
    cotizacionCompra = 13
    cotizacionVenta = 12
    fecha = Date.new(2014, 4, 1)

    agente.comprar(nombreEmpresa, cantidad, cotizacionCompra, fecha)
    agente.vender(nombreEmpresa, cotizacionVenta)

    assert_equal(999925, agente.efectivo)
    assert_equal(0, agente.cantidadAccionesDe(nombreEmpresa))
  end

  def testCotizacionEmpresa
    nombreEmpresa = "YPF"
    fecha = Date.new(2014, 4, 1)

    assert_equal(290, Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha))
  end

  def testCotizacionFecha
    nombreEmpresa = "TS"
    fecha = Date.new(2014, 4, 2)

    assert_equal(216.5, Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha))
  end

end

class Cotizacion

  def initialize(nombreEmpresa, fecha, cotizacion)
    @nombreEmpresa = nombreEmpresa
    @fecha = fecha
    @cotizacion = cotizacion
  end

  def nombreEmpresa
    @nombreEmpresa
  end

  def fecha
    @fecha
  end

  def cotizacion
    @cotizacion
  end
end

class Cotizaciones
   COTIZACIONES = [
       Cotizacion.new("YPF", Date.new(2014, 4, 1), 290),
       Cotizacion.new("TS", Date.new(2014, 4, 1), 215.5),
       Cotizacion.new("YPF", Date.new(2014, 4, 1), 13.45),
       Cotizacion.new("YPF", Date.new(2014, 4, 2), 294),
       Cotizacion.new("TS", Date.new(2014, 4, 2), 216.5),
       Cotizacion.new("YPF", Date.new(2014, 4, 2), 13.25),
	   Cotizacion.new("YPF", Date.new(2014, 4, 3), 288),
       Cotizacion.new("TS", Date.new(2014, 4, 3), 216),
       Cotizacion.new("YPF", Date.new(2014, 4, 3), 12.8),
   ]

  def self.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha)
    COTIZACIONES.select {
        |cotizacion| cotizacion.nombreEmpresa==nombreEmpresa && cotizacion.fecha==fecha
    }.first.cotizacion
  end
end

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