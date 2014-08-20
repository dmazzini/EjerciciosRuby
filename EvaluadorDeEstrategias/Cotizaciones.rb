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
      Cotizacion.new("GGAL", Date.new(2014, 4, 10), 13),	  
      Cotizacion.new("YPF", Date.new(2014, 4, 11), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 11), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 11), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 12), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 12), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 12), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 13), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 13), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 13), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 14), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 14), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 14), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 15), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 15), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 15), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 16), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 16), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 16), 13),
      Cotizacion.new("YPF", Date.new(2014, 4, 17), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 17), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 17), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 18), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 18), 213),	  
      Cotizacion.new("GGAL", Date.new(2014, 4, 18), 13),	  
	  Cotizacion.new("YPF", Date.new(2014, 4, 19), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 19), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 19), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 20), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 20), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 20), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 21), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 21), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 21), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 22), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 22), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 22), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 23), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 23), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 23), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 24), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 24), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 24), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 25), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 25), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 25), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 26), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 26), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 26), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 27), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 27), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 27), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 28), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 28), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 28), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 29), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 29), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 29), 13),
	  Cotizacion.new("YPF", Date.new(2014, 4, 30), 294),
      Cotizacion.new("TS", Date.new(2014, 4, 30), 213),
      Cotizacion.new("GGAL", Date.new(2014, 4, 30), 13)	  
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

