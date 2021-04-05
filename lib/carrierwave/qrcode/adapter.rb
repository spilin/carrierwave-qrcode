module Carrierwave
  module Qrcode
    module Adapter
      # rubocop:disable Metrics/MethodLength
      def mount_qrcode_uploader(attribute, uploader_class, options = {})
        mount_uploader attribute, uploader_class, options

        define_method "#{attribute}=" do |value|
          if respond_to?("#{attribute}_will_change!") && value.present?
            send "#{attribute}_will_change!"
          end

          qrcode_value = options[:column] ? self.send(options[:column]) : value&.strip
          data = RQRCode::QRCode.new(qrcode_value).as_png(size: options[:size] || 432).to_s
          super(FileIO.new("#{qrcode_value}.png", data))
        end

      end
    end
  end
end
