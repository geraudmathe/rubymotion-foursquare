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
end
