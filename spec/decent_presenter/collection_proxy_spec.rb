require 'spec_helper'

TEST_COLLECTION_PROXY_PAGINATION_METHODS = [
  :current_page, :total_pages,
  :limit_value, :model_name, :total_count,
  :total_entries, :per_page, :offset
]

class DummyOriginalForCollectionProxy
  
  TEST_COLLECTION_PROXY_PAGINATION_METHODS.each do |method|
    define_method method do 
      "original"
    end
  end


end

class DummyPresentedForCollectionProxy

  def presented_method
    "presented"
  end

  def other_presented_method
    "presented"
  end

end

describe DecentPresenter::CollectionProxy do


  subject { DecentPresenter::CollectionProxy.new(
    DummyOriginalForCollectionProxy.new, DummyPresentedForCollectionProxy.new
    )
  }

  it "delegates pagination-related methods to original collection" do

    TEST_COLLECTION_PROXY_PAGINATION_METHODS.each do |pagination_method|
      expect(subject.send(pagination_method)).to eq "original"
    end

    
  end

  it "delegates other methods to presented collection" do
    [:presented_method, :other_presented_method].each do |presented_method|
      expect(subject.send(presented_method)).to eq "presented"
    end
  end

end