require 'date'
require 'set'

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
      Cotizacion.new("GGAL", Date.new(2014, 4, 1), 13.45),
      Cotizacion.new("YPF", Date.new(2014, 4, 2), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 2), 216.5),
      Cotizacion.new("GGAL", Date.new(2014, 4, 2), 13.25),
      Cotizacion.new("YPF", Date.new(2014, 4, 3), 288),
      Cotizacion.new("TS", Date.new(2014, 4, 3), 216),
      Cotizacion.new("GGAL", Date.new(2014, 4, 3), 12.8),
      Cotizacion.new("YPF", Date.new(2014, 4, 4), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 4), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 4), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 5), 292),
      Cotizacion.new("TS", Date.new(2014, 4, 5), 215),
      Cotizacion.new("GGAL", Date.new(2014, 4, 5), 14),
      Cotizacion.new("YPF", Date.new(2014, 4, 6), 290),
      Cotizacion.new("TS", Date.new(2014, 4, 6), 212),
      Cotizacion.new("GGAL", Date.new(2014, 4, 6), 13.5),
      Cotizacion.new("YPF", Date.new(2014, 4, 7), 293),
      Cotizacion.new("TS", Date.new(2014, 4, 7), 214),
      Cotizacion.new("GGAL", Date.new(2014, 4, 7), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 8), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 8), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 8), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 9), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 9), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 9), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 10), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 10), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 10), 13)	  

  ]

  def self.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha)
    COTIZACIONES.select {
        |cotizacion| cotizacion.nombreEmpresa==nombreEmpresa && cotizacion.fecha==fecha
    }.first.cotizacion
  end
  
  def self.promedioDeCotizacionesHastaLaFecha(nombreEmpresa, fecha)
	sumatoria = 0
	cantidad = 0
	COTIZACIONES.each { |cotizacion|
		if cotizacion.nombreEmpresa==nombreEmpresa && cotizacion.fecha < fecha
			sumatoria += cotizacion.cotizacion
			cantidad +=1
		end	
	}
	promedio = 0
	if cantidad > 0
		promedio = sumatoria.to_f/cantidad.to_f
	end
	promedio
  end
end

