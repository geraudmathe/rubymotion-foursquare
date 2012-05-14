class Place

  attr_accessor :name, :lat, :lng, :address

  def initialize(options)
    self.name = options[:name]
    self.lat = options[:location][:lat]
    self.lng = options[:location][:lng]
    self.address = options[:location][:address]
    @coordinate = CLLocationCoordinate2D.new
    @coordinate.latitude = self.lat
    @coordinate.longitude = self.lng
  end

  def title
    [@name, @address].join(' - ')
  end

  def coordinate
    @coordinate
  end

end