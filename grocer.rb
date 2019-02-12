def consolidate_cart(cart)
  # code here
  final = {}
  cart.each do |item_index|
    item_index.each do |item, info|
      if final[item]
        final[item][:count] += 1
      else
        final[item] = info
        final[item][:count] = 1
      end
    end
  end
  return final
end

def apply_coupons(cart, coupons)
  # code here
  if coupons.length == 0
    return cart
  else

    coupons.each do |index|
      #index = coupon
      #item = cart item
      name = index[:item]
      item = cart[name]

      if(item != nil)
        #update curent item
        if(item[:count] >= index[:num])
          item[:count] = item[:count] - index[:num]
          #add coupon item
          couponkey = "#{name} W/COUPON"
          if(cart[couponkey] == nil)
            couponitem = {:price => index[:cost], :clearance => item[:clearance], :count => 1}
            cart[couponkey] = couponitem
          else
            couponitem = cart[couponkey];
            couponitem[:count] +=1;
          end
        end
      end
    end
   end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, details|
    if details[:clearance]
      new_price = details[:price] - (details[:price]*0.2)
      cart[item][:price] = new_price
    end
  end
  cart 
end



def checkout(cart = [], coupons = [])
  # code here
  cart = consolidate_cart(cart)
  cart_total = 0 

  if cart.length == 1 
    cart = apply_coupons(cart,coupons)
    apply_clearance(cart) 

    if cart.length > 1 
      cart.each do |name, info|
        if info[:count] < 1
          next 
        else 
          cart_total += info[:price]*info[:count]
        end 
      end
    else
      cart.each do |name, info|
        if info[:count] > 1
          cart_total+= info[:price]*info[:count]
        else 
          cart_total+= info[:price]
        end 
      end
    end 
  else  
    cart = apply_coupons(cart,coupons)
    cart = apply_clearance(cart)
    cart.each do |name, info|
      if info[:count] > 0 
        cart_total += info[:price]
      end 
    end 
  end 
      if cart_total < 100 
      return cart_total
    else 
      return cart_total - (cart_total*0.1)
    end 
  
end

# it "charges full price for items that fall outside of coupon count" do
#     beer = find_item('BEER')
#     cart = Array.new(3, beer)
#     coupons = [find_coupon("BEER")]
#     expect(checkout(cart, coupons)).to eq(33.00)


items = [
      # {"AVOCADO" => {:price => 3.00, :clearance => true}},
      # {"KALE" => {:price => 3.00, :clearance => false}},
      # {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
      # {"ALMONDS" => {:price => 9.00, :clearance => false}},
      # {"TEMPEH" => {:price => 3.00, :clearance => true}},
      # {"CHEESE" => {:price => 6.50, :clearance => false}},
      # {"CHEESE" => {:price => 6.50, :clearance => false}},
      # {"CHEESE" => {:price => 6.50, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}}
      # {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
      # {"BEETS" => {:price => 2.50, :clearance => false}},
      # {"BEETS" => {:price => 2.50, :clearance => false}},
      # {"SOY MILK" => {:price => 4.50, :clearance => true}}
    ]
coupons = [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]
checkout(items, [])
