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
      Cotizacion.new("GGAL", Date.new(2014, 4, 4), 13)

  ]

  def self.cotizacionDeEmpresaEnFecha(nombreEmpresa, fecha)
    COTIZACIONES.select {
        |cotizacion| cotizacion.nombreEmpresa==nombreEmpresa && cotizacion.fecha==fecha
    }.first.cotizacion
  end
end

