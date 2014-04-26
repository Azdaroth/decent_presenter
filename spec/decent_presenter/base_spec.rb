require 'spec_helper'

class DummyModelForBaseClassTest

  def name
    "dummy_model_name"
  end

  def stuff
    "stuff"
  end

end

class DummyViewContext ; end


class DummyModelPresenter < DecentPresenter::Base

  def name
    "presented #{model.name}"
  end

end


describe DecentPresenter::Base do

  let(:model) { DummyModelForBaseClassTest.new }
  let(:view_context) { DummyViewContext.new }
  
  
  context "base" do

    subject { DecentPresenter::Base.new(model, view_context) }

    it "exposes model as model" do
      expect(subject.model).to eq model
    end

    it "exposes model as object" do
      expect(subject.object).to eq model
    end

    it "exposes view context as h" do
      expect(subject.h).to eq view_context
    end

    it "exposes view context as helpers" do
      expect(subject.helpers).to eq view_context
    end

  end

  context "subclass" do

    subject { DummyModelPresenter.new(model, view_context) }

    it "decorates model's methods" do
      expect(subject.name).to eq "presented dummy_model_name"
    end

    it "delegates method calls to model when the method is not defined
      within presenter" do
      expect(subject.stuff).to eq "stuff"
    end

    it "raises error on model's instance when method is defined
      neither in presenter nor in model" do
      expect { subject.not_defined_method }.to raise_error
    end

    it "implements presentable interface" do
      expect(subject).to respond_to :present
    end

  end


end