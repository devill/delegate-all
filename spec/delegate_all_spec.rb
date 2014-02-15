require_relative '../lib/delegate_all'


class DelegatorClass
  delegate_all :delegate_object

  def initialize(delegate_object)
    @delegate_object = delegate_object
  end
end

describe :delegate_all do
  context "on method calls" do
    it "should delegate all calls to the delegate class" do
      delegate = double("Delegate")
      delegate.should_receive(:message).with("argument_one", "argument_two")

      DelegatorClass.new(delegate).message("argument_one", "argument_two")
    end

    it "should also delegate the block" do
      class StubDelegateClass
        def method_with_block
          yield
        end
      end

      block_called = false

      DelegatorClass.new(StubDelegateClass.new).method_with_block {  block_called = true }

      block_called.should be_true
    end

    it "should throw an exception when the neither of the objects has the missing method" do
      class Empty

      end

      threw_error = false
      delegator = DelegatorClass.new(Empty.new)

      begin
        delegator.missing
      rescue NoMethodError => e
        e.message.should == "undefined method `missing' for #{delegator}"
        threw_error = true
      end

      threw_error.should be_true
    end
  end

  context "#respond_to?" do
    it "should return true for delegated public methods" do
      class StubDelegateClass
        def delegated_method
        end
      end

      DelegatorClass.new(StubDelegateClass.new).respond_to?(:delegated_method).should be_true
    end

    it "should not return true for private methods of the delegate class" do
      class StubDelegateClass
        private
        def delegated_method
        end
      end

      DelegatorClass.new(StubDelegateClass.new).respond_to?(:delegated_method).should be_false
    end

  end

  context "#public_methods" do
    it "should include the delegated methods as well" do
      class StubDelegateClass
        def delegated_method
        end
      end

      DelegatorClass.new(StubDelegateClass.new).public_methods.should include(:delegated_method)
    end
  end

end