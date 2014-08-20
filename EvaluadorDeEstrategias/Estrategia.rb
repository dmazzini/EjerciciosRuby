class Estrategia	
	def initialize(condicionCompra, condicionVenta)
		@condicionCompra = condicionCompra
		@condicionVenta = condicionVenta
	end
	
	def operacion_a_realizar(agente, nombreEmpresa, fecha)
		if @condicionCompra.call(agente, nombreEmpresa, fecha)
			Compra.new
		elsif @condicionVenta.call(agente, nombreEmpresa, fecha)
			Venta.new
		else
			SinOperacion.new
		end
	end
end

class Compra

end

class Venta

end

class SinOperacion
end