class Route < ActiveRecord::Base
  has_many(
    :buses,
    class_name: "Bus",
    foreign_key: :route_id,
    primary_key: :id
  )

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    buses_with_drivers = buses.includes(:drivers)

    all_drivers = {}

    buses_with_drivers.each do |bus_with_drivers|
      drivers = []
      bus_with_drivers.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus_with_drivers.id] = drivers
    end

    all_drivers
  end
end
