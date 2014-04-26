require 'spec_helper'

class DummyModelForFactoryPresenter ; end
class DummyModelForFactory ; end
class OtherDummyModel ; end


describe DecentPresenter::Factory do

  subject { DecentPresenter::Factory }

  it "implements DecentPresenter Factory interface" do
    expect(subject).to respond_to :presenter_for
  end

  describe ".presenter_for" do

    it "gives presenter class based on object's class in convention: KlassPresenter" do
      model = DummyModelForFactory.new
      expect(subject.presenter_for(model)).to eq DummyModelForFactoryPresenter
    end

    it "raises PresenterForModelDoesNotExist error if presenter class is not defined" do
      model = OtherDummyModel.new
      expect do 
        subject.presenter_for(model) 
      end.to raise_error DecentPresenter::Factory::PresenterForModelDoesNotExist,
        "expected OtherDummyModelPresenter presenter to exist"
    end

  end

end