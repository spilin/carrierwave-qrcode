module Carrierwave
  module Qrcode
    class FileIO < StringIO
      class ArgumentError < StandardError; end
        attr_accessor :filepath

        def initialize(*args)
          super(*args[1..-1])
          @filepath = args[0]
        end

        def original_filename
          File.basename(@filepath)
        end
    end
  end
end
