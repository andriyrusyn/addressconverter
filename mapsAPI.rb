require 'rest_client'
require 'Nokogiri'

class GoogleAPI

	def initalize()
		@address = ""
		@lat = 0
		@lon = 0
		@mileage = 0.00
	end
	
	def getAddress
		print "what's the address?"
		@address = gets.chomp.gsub(' ','+').concat("+CA")
	end
	
	
	def grabHTMLDistance
		urlStart = "https://maps.googleapis.com/maps/api/distancematrix/xml?units=imperial&origins=888+Tennessee+St+San+Francisco&destinations="
		urlEnd = "&mode=driving&language=en-EN&key=AIzaSyBi69D922WJ5UPPm_5-FfORvPhagXttu-I"
		data = RestClient.get(urlStart+@address+urlEnd)
		distanceTemp = Nokogiri::XML(data)
		@mileage = distanceTemp.css("distance text").inner_text().to_f()

	end
	
	def grabHTMLCoordinates
		urlStart = "https://maps.googleapis.com/maps/api/geocode/xml?address="
		urlEnd = "&key=AIzaSyBi69D922WJ5UPPm_5-FfORvPhagXttu-I"
		data = RestClient.get(urlStart+@address+urlEnd)
		latlonTemp = Nokogiri::XML(data)
		@lat = latlonTemp.css("location lat").inner_text().to_f()
		@lon = latlonTemp.css("location lng").inner_text().to_f()
	end
	
	def printMileage
		puts "mileage = " + @mileage.to_s
	end
	
	def printLatLon
		puts "lat = " + @lat.to_s + " lon = " + @lon.to_s
	end

end

grabber = GoogleAPI.new()
grabber.getAddress()
grabber.grabHTMLCoordinates()
grabber.grabHTMLDistance()
grabber.printMileage()
grabber.printLatLon()



