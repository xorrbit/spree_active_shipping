require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class InternationalParcelSurface < Calculator::CanadaPostPWS::Base
        def self.description
          I18n.t("canada_post_pws.international_parcel_surface")
        end
      end
    end
  end
end
