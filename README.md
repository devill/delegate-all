delegate-all
============

Automatically delegate method calls to another object. 

The `delegate_all` function will define `method_missing`, `responds_to?` and `public_methods` so that any function present on the delegate class will be called if a message with the same name is recieved by the delegator class. This is a useful tool for implementing the state pattern, or as an aid during an inheritance to delegation refactor.

## Example

```ruby
class DelegatorClass
  delegate_all :delegate_object

  def initialize(delegate_object)
    @delegate_object = delegate_object
  end
end

class DelegateClass
  def delegated_method
  end
end

DelegatorClass.new(DelegateClass.new).delegated_method
```

In this case the `delegate_all` method call is equivalent to writing a delegator function with the name `delegated_method` and make it call the `delegated_method` on the `DelegateClass`
