require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_titre = "SampleApp du tutoriel Ruby on Rails"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    it "should have the good title" do
      get 'home'
      response.should have_selector("title",
                                    :content => @base_titre + " | Home")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    it "should have the good title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => @base_titre + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    it "should have the good title" do
      get 'about'
      response.should have_selector("title",
                                    :content => @base_titre + " | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    it "should have the good title" do
      get 'help'
      response.should have_selector("title",
                                    :content => @base_titre + " | Help")
    end
    
  end

end
