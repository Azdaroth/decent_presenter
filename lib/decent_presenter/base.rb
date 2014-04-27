require "decent_presenter/exposable"

module DecentPresenter
  class Base < SimpleDelegator

    include DecentPresenter::Exposable

    attr_reader :view_context
    private :view_context

    def initialize(object, view_context)
      super(object)
      @view_context = view_context
    end    

    def model
      __getobj__
    end

    alias :object :model

    def helpers
      view_context
    end

    alias :h :helpers    


  end
end