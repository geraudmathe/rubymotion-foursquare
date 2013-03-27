class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds) 

    viewsArray = [PlacesListViewControllerOne.alloc.init, PlacesMapViewController.alloc.init]
    tabController = UITabBarController.alloc.init
    tabController.setViewControllers(viewsArray, animated: false)


    @window.rootViewController = tabController
    @window.backgroundColor = UIColor.whiteColor
    @window.makeKeyAndVisible
    true
  end

  def foursquare_handler
    @foursquare ||= Foursquare.new("AEZJNBUTTGBL0RENEGRLL5K2LKO4MAPHUPEWWP5TP522R5CB","3QN2Q2GV3QWHVYZ0HRQGGPVKT1EBI1RKX1PZ5LIIF1R4YDBQ")
  end

  def position
    @location_manager ||= CLLocationManager.alloc.init.tap do |lm|
      lm.desiredAccuracy = KCLLocationAccuracyNearestTenMeters
      lm.startUpdatingLocation
      lm.delegate = self
    end
    if not Device.simulator?
      @location_manager.location.coordinate
    else 
      SimulatePosition.new
    end
  end
end
