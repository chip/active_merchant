require File.join(File.dirname(__FILE__),'smart_ps.rb')
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class BraintreeGateway < SmartPs
      def api_url 
        'https://secure.braintreepaymentgateway.com/api/transact.php'
      end
      
      def add_recurring(money, creditcard, options = {})
        post = {}
        add_invoice(post, options)
        add_payment_source(post, creditcard,options)        
        add_address(post, options[:billing_address]||options[:address])
        add_address(post, options[:shipping_address],"shipping")
        add_customer_data(post, options)
        add_start_date(post, options)
        add_sku(post, options)
        commit('add_recurring', money, post)
      end
      self.supported_countries = ['US']
      self.supported_cardtypes = [:visa, :master, :american_express, :discover]
      self.homepage_url = 'http://www.braintreepaymentsolutions.com'
      self.display_name = 'Braintree'
    end
    BrainTreeGateway = BraintreeGateway
  end
end

