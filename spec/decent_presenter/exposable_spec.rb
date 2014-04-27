require 'spec_helper'

class DummyModelForExposableTest 

  def name
    "name"
  end

end

class DummyModelForExposableTestPresenter < DecentPresenter::Base 

  def name
    "presented name"
  end

end

class DummyModelForExposableOtherPresenter < DecentPresenter::Base 

  def name
    "other presented name"
  end

  def name_from_default_presenter
    present(model).name
  end

end

class DummyObjectErrorPresenterExposable

  include DecentPresenter::Exposable

  def present_model(model)
    present(model)
  end

end

class DummyObjectPresenterExposable


  def view_context ; end 

  include DecentPresenter::Exposable

  def present_model(model)
    present(model)
  end

  def present_model_with_options(model, options)
    present(model, options)
  end

  def present_collection(collection)
    present(collection)
  end

  def present_collection_with_options(collection, options)
    present(collection, options)
  end

end



describe DecentPresenter::Exposable do

  context "view_context prerequisite" do

    it "raises DoesNotImplementViewContextError if view_context method
      is not defined" do
      model = DummyModelForExposableTest.new
      expect do 
        DummyObjectErrorPresenterExposable.new.present_model(model)
      end.to raise_error DecentPresenter::Exposable::DoesNotImplementViewContextError,
        "Object must implement :view_context method to handle presentation"
    end

    it "doesn't raise DoesNotImplementViewContextError if view_context method
      is defined" do
      model = DummyModelForExposableTest.new
      expect do 
        DummyObjectPresenterExposable.new.present_model(model)
      end.not_to raise_error
    end

  end

  context "presentation" do

    let(:model) { DummyModelForExposableTest.new }
    let(:collection) { [model] }

    subject { DummyObjectPresenterExposable.new }

    it "presents model with default presenter" do
      expect(subject.present_model(model).name).to eq "presented name"
    end

    it "presents model with specified presenter" do
      expect(subject.present_model_with_options(
          model,
          with: DummyModelForExposableOtherPresenter
        ).name
      ).to eq "other presented name"
    end

    it "presents models collection with default presenter" do
      expect(subject.present_collection(collection).first.name).to eq "presented name"
    end

    it "presents models collection with specified presenter" do
      expect(subject.present_collection_with_options(
          collection,
          with: DummyModelForExposableOtherPresenter
        ).first.name
      ).to eq "other presented name"
    end

    it "handles presentation within presenters" do
      expect(subject.present_model_with_options(
          model,
          with: DummyModelForExposableOtherPresenter
        ).name_from_default_presenter
      ).to eq "presented name"
    end

  end


end