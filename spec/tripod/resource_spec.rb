require "spec_helper"

describe Tripod::Resource do

  describe "#initialize" do

    it "should raise an error if the URI is given as nil" do
      lambda { Person.new(nil) }.should raise_error(Tripod::Errors::UriNotSet)
    end

    context 'with a URI' do
      let(:person) do
        Person.new('http://foobar')
      end

      it 'sets the uri instance variable' do
        person.uri.should == RDF::URI.new('http://foobar')
      end

      it 'sets the graph_uri instance variable from the class by default' do
        person.graph_uri.should == RDF::URI.new('http://graph')
      end

      it "sets the rdf type from the class" do
        person.rdf_type.should == 'http://person'
      end

      it "initialises a repo" do
        person.repository.class.should == RDF::Repository
      end
    end

    context 'with a URI and a graph URI' do
      let(:person) do
        Person.new('http://foobar', 'http://foobar/graph')
      end

      it "overrides the default graph URI with what's given" do
        person.graph_uri.should == RDF::URI.new('http://foobar/graph')
      end
    end
  end
end