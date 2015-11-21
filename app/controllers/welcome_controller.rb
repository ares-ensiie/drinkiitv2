class WelcomeController < ApplicationController

	def index
	end

	def equipe
	year = params[:year].to_i
	if year == 0
		year = 2014
	end
	@team = []
	year_dir = "equipe/" + year.to_s + "-" + (year + 1).to_s 
    filenames=Dir["app/assets/images/" + year_dir + "/*.png"].sort.reverse
	filenames.each do |filename|
		@team << { "image" => year_dir + "/" + File.basename(filename), "name" => File.basename(filename, ".png")}	
	end
  end
end
