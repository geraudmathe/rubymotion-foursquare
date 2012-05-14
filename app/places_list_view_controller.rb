class PlacesListViewControllerOne < UITableViewController
  def init
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("list",image:UIImage.imageNamed("list.png"),tag:0)
    @places ||= UIApplication.sharedApplication.delegate.foursquare_handler.fetch_nearby_places
    self
  end


  def viewDidLoad
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

end