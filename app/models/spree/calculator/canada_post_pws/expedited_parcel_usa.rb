require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class ExpeditedParcelUSA < Calculator::CanadaPostPWS::Base
        def self.description
          I18n.t("canada_post_pws.expedited_parcel_usa")
        end
      end
    end
  end
end
