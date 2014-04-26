require "decent_presenter/collection_proxy"

module DecentPresenter
  class Exposure
    
    attr_reader :view_context, :presenter_factory
    private :view_context, :presenter_factory

    def initialize(view_context, presenter_factory)
      @view_context = view_context
      @presenter_factory = presenter_factory
    end

    def present(presentable, options = {})
      if presentable_is_a_collection?(presentable)
        present_collection(presentable, options)
      else
        present_model(presentable, options)
      end
    end

    private

      def present_model(presentable, options = {})
        presenter = options.fetch(:with) do
          presenter_factory.presenter_for(presentable)
        end
        presenter.new(presentable, view_context)
      end

      def present_collection(collection, options = {})
        presented_collection = collection.map { |el| present_model(el, options) }
        DecentPresenter::CollectionProxy.new(collection, presented_collection)
      end      

      def presentable_is_a_collection?(presentable)
        [:size, :to_a, :first].all? { |method| presentable.respond_to? method }
      end

  end
end