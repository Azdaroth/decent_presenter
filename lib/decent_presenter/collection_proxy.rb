require 'active_support/core_ext/module/delegation'


module DecentPresenter
  class CollectionProxy

    delegate :current_page, :total_pages, :limit_value, :model_name, :total_count,
      :total_entries, :per_page, :offset, to: :original_collection
      
    attr_reader :original_collection, :presented_collection
    private :original_collection, :presented_collection

    def initialize(original_collection, presented_collection)
      @original_collection = original_collection
      @presented_collection = presented_collection
    end

    def method_missing(method, *args, &block)
      presented_collection.send(method, *args, &block)
    end

  end
end