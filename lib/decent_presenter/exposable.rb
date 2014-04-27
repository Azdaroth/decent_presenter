require "decent_presenter/exposure"

module DecentPresenter
  module Exposable
 
    def present(presentable, options = {})
      if respond_to? :view_context, true
        DecentPresenter::Exposure.new(
          view_context, DecentPresenter::Factory
        ).present(presentable, options)
      else
        raise DecentPresenter::Exposable::DoesNotImplementViewContextError.new(
          "Object must implement :view_context method to handle presentation"
        )
      end
    end

    class DoesNotImplementViewContextError < StandardError ; end
        
  end
end