require File.dirname(__FILE__) + '/../../test_helper'

module Spec
  module Api

    class MockTest < Test::Unit::TestCase

      def setup
        @mock = Mock.new("test mock")
      end

      def test_two_in_order_calls
        @mock.should.receive(:one).ordered
        @mock.should.receive(:two).ordered
        @mock.one
        @mock.two
        @mock.__verify
      end

      def test_two_out_of_order_calls
        @mock.should.receive(:one).ordered
        @mock.should.receive(:two).ordered
        assert_raise(MockExpectationError) do
          @mock.two
        end
      end
      
      def test_three_linear_calls
        @mock.should.receive(:one).ordered
        @mock.should.receive(:two).ordered
        @mock.should.receive(:three).ordered
        @mock.one
        @mock.two
        @mock.three
        @mock.__verify
      end

      def test_three_out_of_order_calls
        @mock.should.receive(:one).ordered
        @mock.should.receive(:two).ordered
        @mock.should.receive(:three).ordered
        @mock.one
        assert_raise(MockExpectationError) do
          @mock.three
        end
      end
      
      def test_two_ordered_calls_with_others_between
        @mock.should.receive(:zero)
        @mock.should.receive(:one).ordered
        @mock.should.receive(:two).ordered
        @mock.should.receive(:one_and_a_half)
        @mock.one
        @mock.one_and_a_half
        @mock.zero
        @mock.two
        @mock.__verify
      end
      
    end
  end
end