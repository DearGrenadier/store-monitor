module Formtastic
  module Inputs
    class StringInput
      include Base
      include Base::Stringish
      include Base::Placeholder
    end
  end
end
