require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module CanadaPostPWS
      class Base < Spree::Calculator::ActiveShipping::Base
        @customer_number = ""

        def carrier
          @customer_number = Spree::ActiveShipping::Config[:canada_post_pws_customer_number]
          canada_post_pws_options = {
            :api_key => Spree::ActiveShipping::Config[:canada_post_pws_api_key],
            :secret => Spree::ActiveShipping::Config[:canada_post_pws_secret],
          }
          ActiveMerchant::Shipping::CanadaPostPWS.new(canada_post_pws_options)
        end

      private
        def retrieve_rates(origin, destination, packages)
          begin
            options = {:customer_number => @customer_number}
            response = carrier.find_rates(origin, destination, packages, options)
            # turn this beastly array into a nice little hash
            rates = response.rates.collect do |rate|
              # decode html entities for xml-based APIs, ie Canada Post
              if RUBY_VERSION.to_f < 1.9
                service_name = Iconv.iconv('UTF-8//IGNORE', 'UTF-8', rate.service_name).first
              else
                service_name = rate.service_name.encode("UTF-8")
              end
              [CGI.unescapeHTML(service_name), rate.price]
            end
            rate_hash = Hash[*rates.flatten]
            return rate_hash
          rescue ActiveMerchant::ActiveMerchantError => e

            if [ActiveMerchant::ResponseError, ActiveMerchant::Shipping::ResponseError].include?(e.class) && e.response.is_a?(ActiveMerchant::Shipping::Response)
              params = e.response.params
              if params.has_key?("Response") && params["Response"].has_key?("Error") && params["Response"]["Error"].has_key?("ErrorDescription")
                message = params["Response"]["Error"]["ErrorDescription"]
              # Canada Post specific error message
              elsif params.has_key?("eparcel") && params["eparcel"].has_key?("error") && params["eparcel"]["error"].has_key?("statusMessage")
                message = e.response.params["eparcel"]["error"]["statusMessage"]
              else
                message = e.message
              end
            else
              message = e.message
            end

            error = Spree::ShippingError.new("#{I18n.t(:shipping_error)}: #{message}")
            Rails.cache.write @cache_key, error #write error to cache to prevent constant re-lookups
            raise error
          end
        end
      end
    end
  end
end
