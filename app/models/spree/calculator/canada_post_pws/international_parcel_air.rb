require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class InternationalParcelAir < Calculator::CanadaPostPWS::Base
        def self.description
          I18n.t("canada_post_pws.international_parcel_air")
        end
      end
    end
  end
end
