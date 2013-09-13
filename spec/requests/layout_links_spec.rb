require 'spec_helper'

describe "LayoutLinks" do

	it "devrait trouver une page Home a '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
	end

	it "devrait trouvzer unee page Contact a '/contact'" do
		get '/contact'
		response.should have_selector('title', :content => "Contact")
	end

	it "devrait trouver une page About a '/about'" do
		get '/about'
		response.should have_selector('title', :content => "About")
	end

	it "devrait trouver une page Aide a '/help'" do
		get '/help'
		response.should have_selector('title', :content => "Help")
	end

	it "devrait trouver une page d'inscription a '/signup'" do
		get '/signup'
		response.should have_selector('title', :content => "Inscription")
	end
end
