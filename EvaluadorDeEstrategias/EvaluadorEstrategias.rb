$LOAD_PATH << '.'
require 'test/unit'
require 'date'
require 'set'
require 'Cotizaciones.rb'
require 'Agente.rb'
require 'Estrategia.rb'

def condicionCompra1 
	lambda { |agente, nombreEmpresa, fecha|   
			cotizacionDiaAnterior = Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha-1)
			cotizacionActual = Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha)
			diferencia = cotizacionActual - cotizacionDiaAnterior
			porcentaje = (diferencia.to_f*100)/cotizacionDiaAnterior.to_f
			porcentaje < -1
	}
end		

def condicionVenta1 
	lambda {|agente, nombreEmpresa, fecha|   
			cotizacionDiaAnterior = Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha-1)
			cotizacionActual = Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha)
			diferencia = cotizacionActual - cotizacionDiaAnterior
			porcentaje = (diferencia.to_f*100)/cotizacionDiaAnterior.to_f
			porcentaje > 2
	}
end

def condicionCompra2 
	lambda { |agente, nombreEmpresa, fecha|   
			cotizacionDiaAnterior = Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha-1)
			cotizacionActual = Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha)
			diferencia = cotizacionActual - cotizacionDiaAnterior
			porcentaje = (diferencia.to_f*100)/cotizacionDiaAnterior.to_f
			porcentaje < -1
			condicion2 = cotizacionActual >= 2*Cotizaciones.promedioDeCotizacionesHastaLaFecha(nombreEmpresa, fecha)
			
			condicionCompra1.call(agente, nombreEmpresa, fecha) || condicion2
		}
end		

def condicionVenta2 
	lambda {|agente, nombreEmpresa, fecha|   	
		(fecha - agente.fechaDeAccionMasAntigua(nombreEmpresa)) >= 5
	}
end


class XXX < Test::Unit::TestCase

  def test_agente_comprar
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

  def test_agente_vender
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

  def test_agente_accion_mas_antigua
    nombreEmpresa = "GGAL"
    efectivoInicial = 1000000
    agente = Agente.new(efectivoInicial)
    cantidad = 75
    cotizacionCompra = 13
    cotizacionVenta = 12
    fecha = Date.new(2014, 4, 1)

    agente.comprar(nombreEmpresa, cantidad, cotizacionCompra, fecha)
	agente.comprar(nombreEmpresa, cantidad, cotizacionCompra, fecha+1)
	agente.comprar(nombreEmpresa, cantidad, cotizacionCompra, fecha+2)
	
    assert_equal(fecha, agente.fechaDeAccionMasAntigua(nombreEmpresa))
  end


  def test_cotizacion_empresa
    nombreEmpresa = "YPF"
    fecha = Date.new(2014, 4, 1)

    assert_equal(290, Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha))
  end

  def test_cotizacion_fecha
    nombreEmpresa = "TS"
    fecha = Date.new(2014, 4, 2)

    assert_equal(216.5, Cotizaciones.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha))
  end

   def test_cotizacion_promedio_hasta_fecha
    nombreEmpresa = "TS"
    fecha = Date.new(2014, 4, 5)

    assert_equal(215.25, Cotizaciones.promedioDeCotizacionesHastaLaFecha(nombreEmpresa, fecha))
  end
  
  def test_estrategia1_compra
    nombreEmpresa = "GGAL"
    fecha = Date.new(2014, 4, 2)
    agente = Agente.new(1000000)

    estrategia = Estrategia.new(condicionCompra1, condicionVenta1)

    assert_kind_of(Compra, estrategia.operacion_a_realizar(agente, nombreEmpresa, fecha))
  end

  def test_estrategia1_venta
    nombreEmpresa = "YPF"
    fecha = Date.new(2014, 4, 4)
    agente = Agente.new(1000000)
    estrategia = Estrategia.new(condicionCompra1, condicionVenta1)

    assert_kind_of(Venta, estrategia.operacion_a_realizar(agente, nombreEmpresa, fecha))
  end

  def test_estrategia1_sin_opreaciones
    nombreEmpresa = "YPF"
    fecha = Date.new(2014, 4, 2)
    agente = Agente.new(1000000)
    estrategia = Estrategia.new(condicionCompra1, condicionVenta1)

    assert_kind_of(SinOperacion, estrategia.operacion_a_realizar(agente, nombreEmpresa, fecha))
  end
  
  def test_estrategia2_compra
    nombreEmpresa = "GGAL"
    fecha = Date.new(2014, 4, 2)
    agente = Agente.new(1000000)

    estrategia = Estrategia.new(condicionCompra2, condicionVenta2)

    assert_kind_of(Compra, estrategia.operacion_a_realizar(agente, nombreEmpresa, fecha))
  end

 def test_estrategia2_venta
    nombreEmpresa = "GGAL"
    fecha = Date.new(2014, 4, 8)
    agente = Agente.new(1000000)
	cantidad = 1
	cotizacion = 2
	agente.comprar(nombreEmpresa, cantidad, cotizacion, Date.new(2014, 4, 2))
	
    estrategia = Estrategia.new(condicionCompra2, condicionVenta2)

    assert_kind_of(Venta, estrategia.operacion_a_realizar(agente, nombreEmpresa, fecha))
  end

  def test_estrategia2_sin_opreaciones
    nombreEmpresa = "TS"
    fecha = Date.new(2014, 4, 3)
    agente = Agente.new(1000000)
	cantidad = 1
	cotizacion = 2	
	agente.comprar(nombreEmpresa, cantidad, cotizacion, Date.new(2014, 4, 2))
    estrategia = Estrategia.new(condicionCompra2, condicionVenta2)

    assert_kind_of(SinOperacion, estrategia.operacion_a_realizar(agente, nombreEmpresa, fecha))
  end
end



