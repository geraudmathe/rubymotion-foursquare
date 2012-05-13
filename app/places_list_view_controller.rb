class PlacesListViewControllerOne < UITableViewController
  def init
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("list",image:UIImage.imageNamed("list.png"),tag:0)
    self
  end


  def viewDidLoad
    @places ||= fetch_nearby_places
    view.dataSource = view.delegate = self
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @places.size
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    80
  end

  CELLID = "Foursquareplace"

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    
    cell = tableView.dequeueReusableCellWithIdentifier(CELLID) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CELLID)
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
      cell
    end
    place = @places[indexPath.row]
    cell.textLabel.text = place["name"]
    return cell
  end

  def fetch_nearby_places

    url = NSURL.alloc.initWithString(generate_fetch_url)
    request =  NSURLRequest.alloc.initWithURL(url)
    #TODO : implement queued request
    #queue = NSOperationQueue.alloc.init
    #queue.setName "com.foursquare-rubymotion.pingQueue"

    error = Pointer.new(:object)
    response = Pointer.new(:object)
    connection  = NSURLConnection.sendSynchronousRequest(request,returningResponse: response, error:error )
    serialization  = NSJSONSerialization.JSONObjectWithData(connection, options:0 , error:error)
    serialization.first[1]["venues"]
  end

  def generate_fetch_url
    client_id = ""
    client_secret = ""
    url_string  = "https://api.foursquare.com/v2/venues/search?"
    url_string += "client_id=#{client_id}"
    url_string += "&client_secret=#{client_secret}"
    url_string += "&ll=48.861101,2.351074"
    url_string += "&locale=fr"
    url_string += "&v=20120510"
    url_string
  end
end