# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  nom        :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do

	before(:each) do
		@attr = { 
			:nom => "ExampleUser", 
			:email => "user@example.com", 
			:password => "foobar", 
			:password_confirmation => "foobar"
		}
	end

	it "devrait creer une nouvelle instance dotee des attributs valides" do
		User.create!(@attr)
	end

	it "exige un nom" do
		no_name_user = User.new(@attr.merge(:nom => ""))
		no_name_user.should_not be_valid
	end

	it "exige une adresse email" do
		no_email_user = User.new(@attr.merge(:email => ""))
		no_email_user.should_not be_valid # equivaut a : no_email_user.valid?.should_not == true
	end

	it "exige un nom de 50 caracteres max" do
		long_name = "a" * 51
		long_name_user = User.new(@attr.merge(:nom => long_name))
		long_name_user.should_not be_valid
	end

	it "devrait accepter une adresse email valide" do
		adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
		adresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			valid_email_user.should be_valid
		end
	end

	it "devrait rejeter une adresse email non valide" do
		adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
		adresses.each do |address|
			invalid_email_user = User.new(@attr.merge(:email => address))
			invalid_email_user.should_not be_valid
		end
	end

	it "devrait rejeter une adresse email double" do
		User.create!(@attr)
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end

	it "devrait rejeter une adresse email double jusqua la casse" do
		upcased_email = @attr[:email].upcase
		User.create!(@attr.merge(:email => upcased_email))
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end

	describe "validations du mot de passe" do

		it "devrait exiger un mot de passe" do
			User.new(@attr.merge(:password => "", :password_confirmation => ""))
			should_not be_valid
		end

		it "devrait exiger une confirmation de mot de passe qui correspond" do
			User.new(@attr.merge(:password_confirmation => "invalid"))
			should_not be_valid
		end

		it "devrait rejeter les mots de passe trop courts" do
			short = "a" * 5
			hash = @attr.merge(:password => short, :password_confirmation => short)
			User.new(hash).should_not be_valid
		end

		it "devrait rejeter les mots de passe trop longs" do
			long = "a" * 41
			hash = @attr.merge(:password => long, :password_confirmation => long)
			User.new(hash).should_not be_valid
		end

	end

	describe "cryptage du mot de passe" do
		
		before(:each) do
			@user = User.create!(@attr)
		end

		it "devrait avoir un attribut mot de passe crypte" do
			@user.should respond_to(:encrypted_password)
		end

		it "devrait definir le mot de passe crypte" do
			@user.encrypted_password.should_not be_blank
		end

		describe "methode has_password?" do

			it "doit retourner true si les mots de passe coincident" do
				@user.has_password?(@attr[:password]).should be_true
			end

			it "doit retourner false si les mots de passe divergent" do
				@user.has_password?("invalide").should be_false
			end

		end

		describe "methode authenticate" do

			it "devrait retourner nul en cas d'inequation email/password" do
				wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
				wrong_password_user.should be_nil
			end

			it "devrait retourner nul en cas d'inexistence de l'utilisateur" do
				nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
				nonexistent_user.should be_nil
			end

			it "devrait retourner l'utilisateur si correspondance email/password" do
				matching_user = User.authenticate(@attr[:email], @attr[:password])
				matching_user.should == @user
			end

		end

	end

end
