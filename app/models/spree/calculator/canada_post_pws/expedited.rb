require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class Expedited < Calculator::CanadaPostPWS::Base
        def self.description
          I18n.t("canada_post_pws.expedited")
	end
      end
    end
  end
end
