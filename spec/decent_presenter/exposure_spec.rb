require 'spec_helper'

class DummyModelForExposureTest

  def size ; end

end

class DummyModelForExposureTestPresenter < DecentPresenter::Base ; end

class DummyModelForExposureTestOtherPresenter < DecentPresenter::Base ; end

describe DecentPresenter::Exposure do

  let(:presenter_factory) { double(:presenter_factory) }
  let(:view_context) { double(:view_context) }

  let(:model) { DummyModelForExposureTest.new }
  let(:collection) { [model] } 

  subject { DecentPresenter::Exposure.new(view_context, presenter_factory) }

  before(:each) do
    allow(presenter_factory).to receive(:presenter_for)
      .with(model) { DummyModelForExposureTestPresenter }
  end

  it "presents model with default presenter" do
    presented_model = subject.present(model)
    expect(presented_model).to be_instance_of DummyModelForExposureTestPresenter
  end

  it "presents model with specified presenter" do
    presented_model = subject.present(model, with: DummyModelForExposureTestOtherPresenter)
    expect(presented_model).to be_instance_of DummyModelForExposureTestOtherPresenter
  end

  it "presents models in collection with default presenter" do
    presented_collection = subject.present(collection)
    expect(presented_collection.first).to be_instance_of DummyModelForExposureTestPresenter
  end

  it "presents models in collection with specified presenter" do
    presented_collection = subject.present(collection, with: DummyModelForExposureTestOtherPresenter)
    expect(presented_collection.first).to be_instance_of DummyModelForExposureTestOtherPresenter
  end

  it "wraps collection in CollectionProxy" do
    presented_collection = subject.present(collection)
    expect(presented_collection).to be_instance_of DecentPresenter::CollectionProxy
  end

end