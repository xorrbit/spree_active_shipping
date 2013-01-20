require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class Priority < Calculator::CanadaPostPWS::Base
        def self.description
          I18n.t("canada_post_pws.priority")
	end
      end
    end
  end
end
