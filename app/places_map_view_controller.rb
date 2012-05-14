class PlacesMapViewController < UIViewController
  
  def init
    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Map', image:UIImage.imageNamed('map.png'), tag:1)
    @position ||= UIApplication.sharedApplication.delegate.position
    @places ||= UIApplication.sharedApplication.delegate.foursquare_handler.fetch_nearby_places
    self
  end

  def viewDidLoad
    #self.view = MKMapView.alloc.initWithTitle
    #self.delegate = self
    mapView =   MKMapView.alloc.initWithFrame(self.view.bounds)
    mapView.mapType = MKMapTypeHybrid;
    self.view = mapView
    @places.each do |pl|
        pl_obj = Place.new pl
        #annotation = MKPointAnnotation.alloc.coordinate = coordinate
        mapView.addAnnotation(pl_obj)
    end
  end

  def viewWillAppear(animated)
    location = CLLocationCoordinate2D.new(@position.latitude,@position.longitude)
    region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.001, 0.001))
    self.view.setRegion(region)     
  end

  ViewIdentifier = 'ViewIdentifier'
  def mapView(mapView, viewForAnnotation:place)
    if view = mapView.dequeueReusableAnnotationViewWithIdentifier(ViewIdentifier)
      view.annotation = place
    else
      view = MKPinAnnotationView.alloc.initWithAnnotation(place, reuseIdentifier:ViewIdentifier)
      view.canShowCallout = true
      view.animatesDrop = true
      button = UIButton.buttonWithType(UIButtonTypeDetailDisclosure)
      button.addTarget(self, action: :'showDetails:', forControlEvents:UIControlEventTouchUpInside)
      view.rightCalloutAccessoryView = button
    end
    return view 
  end
end