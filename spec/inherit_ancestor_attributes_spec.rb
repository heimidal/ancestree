require File.join(File.dirname(__FILE__), 'spec_helper')

module MockConcern
  extend ActiveSupport::Concern

  included do
    inherit_ancestor_attributes :some_method
  end

  def mixin_name
    "mixin_name #{self.name}" if self.name
  end
end

class MockTreeNode
  def self.define_attribute_methods
    attr_accessor :age
  end

  include Ancestree
  include MockConcern

  inherit_ancestor_attributes :name, :age, :company, :active?, :bang!
  attr_accessor :name, :company, :active, :bang

  attr_accessor :parent

  def default_company
    "Apple"
  end

  def active?
    active
  end

  def bang!
    bang
  end
end

class OtherMockClass
  def self.define_attribute_methods
    attr_accessor :name, :other_attr
  end

  include Ancestree
  include MockConcern

  inherit_ancestor_attributes :name, :other_attr

  attr_accessor :parent
end

describe Ancestree do
  context "with parent" do
    subject { node = MockTreeNode.new; node.parent = MockTreeNode.new; node }

    it "inherits a defined method declared in the base class" do
      subject.parent.name = "Bob"
      subject.name.should == "Bob"
    end

    it "returns set value of defined method declared in the base class" do
      subject.parent.name = "Bob"
      subject.name = "Rich"
      subject.name.should == "Rich"
    end

    it "inherits a defined method declared in a mixin" do
      subject.parent.name = "Paul"
      subject.mixin_name.should == "mixin_name Paul"
    end

    it "returns set value for defined method declared in a mixin" do
      subject.parent.name = "Paul"
      subject.name = "Max"
      subject.mixin_name.should == "mixin_name Max"
    end

    it "inherits an attribute that is lazy-loaded by Rails" do
      subject.parent.instance_variable_set(:@age, 16)
      subject.age.should == 16
    end

    it "has a default" do
      subject.company.should == "Apple"
    end

    it "tells us it inherits the value from its parent" do
      subject.parent.name = "Joe"
      subject.inherits_from_ancestor?(:name).should be_true
    end

    it "tells us it doesn't inherit the value from its parent" do
      subject.parent.name = "Joe"
      subject.name = "Ken"
      subject.inherits_from_ancestor?(:name).should be_false
    end

    it "tells us it doesn't inherit the value from its parent when the values are the same" do
      subject.parent.name = "Bill"
      subject.name = "Bill"
      subject.inherits_from_ancestor?(:name).should be_false
    end

    it "inherits properly when a question mark exists in the method name" do
      subject.parent.active = true
      subject.should be_active
      subject.should respond_to(:active_with_parent?)
    end

    it "inherits properly when a bang exists in the method name" do
      subject.parent.bang = true
      subject.bang!.should be_true
      subject.should respond_to(:bang_with_parent!)
    end
  end

  context "without parent" do
    subject { MockTreeNode.new }

    it "returns the value of a defined method declared in the base class" do
      subject.name = "Bob"
      subject.name.should == "Bob"
    end

    it "returns the value of a defined method declared in a mixin" do
      subject.name = "Paul"
      subject.name.should == "Paul"
    end

    it "returns the value of an attribute lazy-loaded by Rails" do
      subject.age = 25
      subject.age.should == 25
    end

    it "returns the set value even if default exists" do
      subject.company = "Factory Labs"
      subject.company.should == "Factory Labs"
    end

    it "has a default" do
      subject.company.should == "Apple"
    end
  end

  context 'with multiple inheriting classes' do
    before do
      @node_1 = MockTreeNode.new
      @node_2 = OtherMockClass.new
    end

    it "should not inherit attrs that aren't part of the specified class" do
      lambda { @node_1.other_attr }.should raise_error
      lambda { @node_2.other_attr }.should_not raise_error
    end

    it "should not inherit attrs that aren't part of the specified class (2)" do
      lambda { @node_1.age }.should_not raise_error
      lambda { @node_2.age }.should raise_error
    end
  end
end
