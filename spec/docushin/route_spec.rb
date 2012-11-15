require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Docushin::Route do
  let(:route_set) { Docushin::RouteSet.new }
  let(:route) { route_set.routes.first }

  describe 'create a new Route' do
    it 'should have name, verb, path, requirements, data, content as attr' do 
      route.should respond_to(:name)
      route.should respond_to(:verb)
      route.should respond_to(:path)
      route.should respond_to(:requirements)
      route.should respond_to(:base)
      route.should respond_to(:data)
      route.should respond_to(:content)
    end
  end

  describe 'inspect the new Route' do 
    it 'should have attr defined' do 
      route.base.should == File.join(Rails.root, 'doc', 'docushin')
      route.instance_variable_get(:@file_name).should == Digest::MD5.hexdigest(route.verb.to_s + route.path) + '.md'
      route.name.should == "foo_index"
      route.path.should == "/foo"
      route.requirements.should == {:action=>"index", :controller=>"foo"}
      route.verb.should == "GET"
    end    
  end

  describe 'read markdown file' do
    it 'should generate data and content' do 
      binding.pry
      route.data.should == {"tags"=>["Awesome"]}
      route.content.should == "{\"id\":\"4f3a296ac8de6732fe000003\",\"first_name\":\"Todor\",\"last_name\":\"Grudev\",\"username\":null,\"bio\":null,\"gender\":\"male\",\"email\":\"tagrudev@gmail.com\"}"
    end
  end
end