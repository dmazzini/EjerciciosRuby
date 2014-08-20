$LOAD_PATH << '.'
require 'test/unit'
require 'date'
require 'set'
require 'Cotizaciones.rb'
require 'Agente.rb'

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

  def test_estrategia1_compra
    nombreEmpresa = "GGAL"
    fecha = Date.new(2014, 4, 2)
    agente = Agente.new(1000000)
    estrategia = Estrategia1.new()

    assert_kind_of(Compra, estrategia.operacion_a_realizar(agente, nombreEmpresa, fecha))
  end

  def test_estrategia1_venta
    nombreEmpresa = "YPF"
    fecha = Date.new(2014, 4, 4)
    agente = Agente.new(1000000)
    estrategia = Estrategia1.new()

    assert_kind_of(Venta, estrategia.operacion_a_realizar(agente, nombreEmpresa, fecha))
  end

end

class Estrategia1
  def operacion_a_realizar(agente, nombreEmpresa, fecha)
    cotizacionDiaAnterior = Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha-1)
    cotizacionAcutal = Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha)
    diferencia = cotizacionAcutal - cotizacionDiaAnterior
    porcentaje = (diferencia.to_f*100)/cotizacionDiaAnterior.to_f

    if porcentaje < -1
      Compra.new
    elsif porcentaje > 2
      Venta.new
    end

  end
end

class Compra

end

class Venta

end