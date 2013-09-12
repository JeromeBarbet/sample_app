module ApplicationHelper

	def titre
		base_titre = "SampleApp du tutoriel Ruby on Rails"
		if @titre.nil?
			base_titre
		else
			"#{base_titre} | #{@titre}"
		end
		
	end

end
