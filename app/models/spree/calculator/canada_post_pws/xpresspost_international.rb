require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class XpresspostInternational < Calculator::CanadaPostPWS::Base
        def self.description
          I18n.t("canada_post_pws.xpresspost_international")
        end
      end
    end
  end
end
