require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class SmallPacketInternationalSurface < Calculator::CanadaPostPWS::Base
        def self.description
          I18n.t("canada_post_pws.small_packet_international_surface")
        end
      end
    end
  end
end
