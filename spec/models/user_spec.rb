require 'spec_helper'

describe User do
  
  it "should create a new user" do
    User.create(username: "mhack", first_name: "Marcos", last_name: "Hack")
  end
  
  it "should not create without username" do
    User.create(first_name: "Marcos").persisted?.should be_false
    lambda { User.create!(first_name: "Marcos") }.should raise_error
  end
  
  it "should update attributes" do
    user = User.create(username: "marcoshack")
    user.update_attributes(first_name: "Marcos", last_name: "Hack")
  end
  
  it "should validate username format" do
    User.new(username: '!@#$%').valid?.should be_false
    User.new(username: "1234567").valid?.should be_false
    User.new(username: "foo4bar").valid?.should be_false
    User.new(username: "foo_bar").valid?.should be_true
  end
  
  it "should protect password from mass assignment" do
    user = User.create(username: "marcoshack", first_name: "Marcos")
    user.password = "abdcde"
    user.update_attributes(last_name: "Hack", password: "123456")
    user.last_name.should == "Hack"
    user.password.should  == "abdcde"
  end
end

