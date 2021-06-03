require "carrierwave/qrcode/version"
require 'carrierwave/qrcode/file_io'
require 'carrierwave/qrcode/adapter'

module Carrierwave
  module Qrcode
    class Error < StandardError; end
    class Railtie < Rails::Railtie
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.extend Carrierwave::Qrcode::Adapter
      end

      ActiveSupport.on_load :mongoid do
        Mongoid::Document::ClassMethods.send :include, Carrierwave::Qrcode::Adapter
      end
    end

    def generate_qrcode(size)
      qrcode_value = self.model.send(self.model.class.uploader_option(self.mounted_as, :column))
      data = RQRCode::QRCode.new(qrcode_value).as_png(size: size, border_modules: 0)
      IO.binwrite(current_path, data.to_s)
    end

  end
end
