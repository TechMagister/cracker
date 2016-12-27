require "./spec_helper"

describe Cracker::CompletionContext do

  it "should match true boolean" do
    ctx = Cracker::CompletionContext.new "test = true\n test"
    ctx.get_type.should eq "Bool"
  end

  it "should match false boolean" do
    ctx = Cracker::CompletionContext.new "test = false\n test"
    ctx.get_type.should eq "Bool"
  end

  it "should match Integers" do
    ctx = integer_ctx 'a'
    ctx.get_type.should eq "Int32"

    ctx = integer_ctx 'b'
    ctx.get_type.should eq "Int8"

    ctx = integer_ctx 'c'
    ctx.get_type.should eq "Int16"

    ctx = integer_ctx 'd'
    ctx.get_type.should eq "Int32"

    ctx = integer_ctx 'e'
    ctx.get_type.should eq "Int64"

    ctx = integer_ctx 'f'
    ctx.get_type.should eq "UInt8"

    ctx = integer_ctx 'g'
    ctx.get_type.should eq "UInt16"

    ctx = integer_ctx 'h'
    ctx.get_type.should eq "UInt32"

    ctx = integer_ctx 'i'
    ctx.get_type.should eq "UInt64"

    ctx = integer_ctx 'j'
    ctx.get_type.should eq "Int32"

    ctx = integer_ctx 'k'
    ctx.get_type.should eq "Int32"

  end

end
