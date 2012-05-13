class PlacesMapViewController < UIViewController
  
  def init
    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Map', image:UIImage.imageNamed('map.png'), tag:1)
    self
  end

end