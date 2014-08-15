require 'test/unit'
require 'date'
 
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

class Agente
	def initialize(efectivo)
		@efectivo = efectivo
		@acciones = Hash.new(0)
	end
	
	def efectivo
		@efectivo
	end
	
	def comprar(monto, nombreEmpresa, cantidadAcciones, fecha)
		@efectivo -= monto
		@acciones[nombreEmpresa] += cantidadAcciones
	end
	
	def vender(monto, nombreEmpresa, cantidadAcciones, fecha)
		@efectivo += monto
		@acciones[nombreEmpresa] -= cantidadAcciones
	end
	
	def cantidadAccionesDe(nombreEmpresa)
		@acciones[nombreEmpresa]
	end
end