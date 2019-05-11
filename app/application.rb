class Application
  
  @@items = [
    Item.new("Milk", 2.99), 
    Item.new("Cheese", 1.99)             
  
  ]
  
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      
      
      item_name = req.path.split("/items/").last
      item = @@items.find{|item| item.name == item_name}
      #handle_search(item)
      
      if item == nil
        resp.status = 400
        resp.write "Item not found"
      else 
        resp.write item.price
      end
      
    #elsif !req.path.match(/items/)
     # resp.status = 400
     
    else
      resp.write "Route not found"
      resp.status = 404
   
    end
   
    resp.finish
    
   
  end

  def handle_search(search_item)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      resp.status = 400
      return "Couldn't find #{search_term}"
    end
  end


end
