class Foursquare
  @@token_secret,@@token_id = nil
  token_id = nil
  def initialize client_id,client_secret
    #Foursquare::TOKEN_ID  client_id
    @token_id = client_id
    @token_secret = client_secret
    @position ||= UIApplication.sharedApplication.delegate.position
  end

  def fetch_nearby_places
    @items ||= begin 
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
  end

  def fetch_url
    #puts "token_id #{token_id}"
    string_url  = "https://api.foursquare.com/v2/venues/search"
    string_url += "?client_id=#{@token_id}"
    string_url += "&client_secret=#{@token_secret}"
    string_url += "&ll=#{@position.latitude},#{@position.longitude}"
    string_url += "&locale=fr"
    string_url += "&v=20120510"
    p string_url
    string_url
  end
end