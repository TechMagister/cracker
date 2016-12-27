require "spec"
require "../src/cracker/**"

INTEGER_CTX = "
      a = 1      # Int32

      b = 1_i8   # Int8
      c = 1_i16  # Int16
      d = 1_i32  # Int32
      e = 1_i64  # Int64

      f = 1_u8   # UInt8
      g = 1_u16  # UInt16
      h = 1_u32  # UInt32
      i = 1_u64  # UInt64

      j = +10    # Int32
      k = -20    # Int32

      l = 2147483648          # Int64
      m = 9223372036854775808 # UInt64
      "

def integer_ctx(var)
  Cracker::CompletionContext.new(INTEGER_CTX + var)
end
