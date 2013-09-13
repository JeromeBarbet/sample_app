module ApplicationHelper

	# Définit une variable logo
	def logo
		logo = image_tag("logo.png", :alt => "Application Exemple", :class => "round")
	end

	# Retourne un titre basé sur la page
	def titre
		base_titre = "SampleApp du tutoriel Ruby on Rails"
		if @titre.nil?
			base_titre
		else
			"#{base_titre} | #{@titre}"
		end
		
	end

end
