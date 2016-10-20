```ruby
  class Post < ActiveRecord::Base
    uses_integer_inheritance
  end

  class Article < Post
  end

  class Publication < Post
  end

  # Add to initializers or to some script that is not reloaded:
  # (this adds support for reloading in development mode. See ActionDispatch::Reloader)
  IntegerInheritance.describe do

    # Use full class name here (only strings!)
    with 'Post' do
      map 1, to: 'Post'
      map 2, to: 'Article'

      # You can specify more than one type
      map 3, 4, to: 'Publication'
    end
  end
```

## Gemfile
```ruby
gem 'integer-inheritance', '~> 1.0'
```
