class Foursquare
  @@token_secret,@@token_id = nil

  def initialize client_id,client_secret
    #Foursquare::TOKEN_ID  client_id
    @token_id = client_id
    @token_secret = client_secret
  end

  def fetch_nearby_places
    url = NSURL.alloc.initWithString(fetch_url)
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

  def fetch_url
    string_url  = "https://api.foursquare.com/v2/venues/search"
    string_url += "?client_id=AEZJNBUTTGBL0RENEGRLL5K2LKO4MAPHUPEWWP5TP522R5CB"
    string_url += "&client_secret=3QN2Q2GV3QWHVYZ0HRQGGPVKT1EBI1RKX1PZ5LIIF1R4YDBQ"
    string_url += "&ll=48.861101,2.351074"
    string_url += "&locale=fr"
    string_url += "&v=20120510"
    string_url
  end
end