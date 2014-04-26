# DecentPresenter

Simple and easy to use presentation layer for your Rails models.

## Installation

Add this line to your application's Gemfile:

    gem 'decent_presenter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install decent_presenter

## Basic usage

In your controller (ApplicationController) include DecentPresenter::Exposable module:

``` ruby
class ApplicationController < ActionController::Base

  include DecentPresenter::Exposable

end
```

and you can start using DecentPresenters!

To decorate your model (e.g. user) just use:

`` ruby
@user = present(User.find(params[:id]))
```

Works the same way with collections:

`` ruby
@users = present(User.all)
```

By default it will use UserPresenter so it must be defined before decorating model. Put it in app/presenters directory. Presenters should inherit from DecentPresenter::Base:

``` ruby
class UserPresenter < DecentPresenter::Base

end
```

If you want other presenter, use with option:

`` ruby
@user = present(User.find(params[:id]), with: OtherUserPresenter)
```

or

`` ruby
@users = present(User.all, with: OtherUserPresenter)
```

To access decorated object within presenter use either model or object method:


``` ruby
class UserPresenter < DecentPresenter::Base

  def name
    "presented #{model.name}"
  end

  def age
    "presented #{object.name}"
  end

end
```

You can access Rails helpers by h or helpers method:

``` ruby
class UserPresenter < DecentPresenter::Base

  def edit_path
    h.edit_user_path(model)
  end

  def path
    helpers.user_path(model)
  end

end
```

All methods not implemented by presenters are automatically delegated to decorated model.

## Paginating collections?

Works with kaminari and will_paginate by default, no need to delegate and hack anything. 

## How to decorate/present other objects within presenters?

The same way as in controllers:

``` ruby

class UserPresenter < DecentPresenter::Base

  def articles 
    present(model.articles)
  end

end

```

## How do I test presenters?

This might be a bit tricky. To access helpers, presenters depend on view_context which is passed from controllers. To instantiate a new presenter, you need two arguments: model and view_context. If you don't need helpers, you can pass nil as a second argument:

``` ruby
presented_user = UserPresenter.new(user, nil)
```

What if you need helpers? You can pass ActionController::Base.helpers as a second argument. The problem with that solution is that you won't have access to url helpers from your routes and your custom helpers. To handle these cases, you can stub url methods or create fake helper module for your tests:

``` ruby
module FakeUrlHelpers

  def articles_path
    # some code
  end

end
```

and extend helpers with these modules:

```ruby
helpers = ActionController::Base.helpers 
helpers.extend FakeUrlHelpers
helpers.extend ApplicaitonHelper

presented_user = UserPresenter.new(user, helpers)
```

Future releases will handle such use cases in a cleaner way.

## TO-DO

* Implement generators 
* Provide better solution for testing

## Contributing

1. Fork it ( https://github.com/[my-github-username]/decent_presenter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
