require 'active_support/inflector'

module DecentPresenter
  module Factory
    
    extend self

    def presenter_for(model)
      presenter_class_name = "#{model.class}Presenter"
      begin
        presenter_class_name.constantize
      rescue NameError
        raise PresenterForModelDoesNotExist.new(
          "expected #{presenter_class_name} presenter to exist"
        )
      end
    end

    class PresenterForModelDoesNotExist < StandardError ; end

  end
end