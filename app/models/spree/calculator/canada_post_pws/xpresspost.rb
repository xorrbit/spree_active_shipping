require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class Xpresspost < Calculator::CanadaPostPWS::Base
        def self.description
          I18n.t("canada_post_pws.xpresspost")
	end
      end
    end
  end
end
