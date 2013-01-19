require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class Base < Spree::Calculator::ActiveShipping::Base
        def carrier
          canada_post_pws_options = {
            :api_key => Spree::ActiveShipping::Config[:canada_post_pws_api_key],
            :secret => Spree::ActiveShipping::Config[:canada_post_pws_secret]
          }
          ActiveMerchant::Shipping::CanadaPostPWS.new(canada_post_pws_options)
	end
      end
    end
  end
end
