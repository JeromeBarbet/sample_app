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
		@attr = { :nom => "ExampleUser", :email => "user@example.com" }
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

end
