require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class Regular < Calculator::CanadaPostPWS::Base
        def self.description
          I18n.t("canada_post_pws.regular")
	end
      end
    end
  end
end
