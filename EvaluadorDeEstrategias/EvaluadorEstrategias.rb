require 'test/unit'
require 'date'
require 'set'

class XXX < Test::Unit::TestCase
  def testComprar
	efectivoInicial = 1000000
	agente = Agente.new(efectivoInicial)
	
	agente.comprar(100.5, "GGAL", 75, Date.new(2014, 3, 1))
	
    assert_equal(999899.5, agente.efectivo)
	assert_equal(75, agente.cantidadAccionesDe("GGAL"))
  end
  
    def testVender
	 efectivoInicial = 1000000
	 agente = Agente.new(efectivoInicial)
	
	 agente.comprar(100.5, "GGAL", 75, Date.new(2014, 3, 1))
	 agente.vender(70.3, "GGAL", 22, Date.new(2014, 3, 2))
	
    assert_equal(999969.8, agente.efectivo)
  	assert_equal(53, agente.cantidadAccionesDe("GGAL"))
  end
end

class Accion
  def initialize(nombreEmpresa, monto, cantidad, fecha)
    @nombreEmpresa = nombreEmpresa
    @monto = monto
    @cantidad = cantidad
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
	
	def comprar(monto, nombreEmpresa, cantidadAcciones, fecha)
		@efectivo -= monto
		@acciones.add(Accion.new(nombreEmpresa, monto, cantidadAcciones, fecha))
	end
	
	def vender(monto, nombreEmpresa, cantidadAcciones, fecha)
		@efectivo += monto
		@acciones.delete_if {|accion| accion.nombreEmpresa == nombreEmpresa}
	end
	
	def cantidadAccionesDe(nombreEmpresa)
		(@acciones.keep_if {|accion| accion.nombreEmpresa == nombreEmpresa}).inject { |sum, accion| sum + accion.cantidad }
	end
end