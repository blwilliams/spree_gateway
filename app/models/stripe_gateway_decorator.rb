ActiveMerchant::Billing::StripeGateway.class_eval do
  private

  def add_creditcard(post, creditcard, options)
    card = {}
    if creditcard.respond_to?(:number)
      if creditcard.respond_to?(:track_data) && creditcard.track_data.present?
        card[:swipe_data] = creditcard.track_data
      else
        card[:number] = creditcard.number
        card[:exp_month] = creditcard.month
        card[:exp_year] = creditcard.year
        card[:cvc] = creditcard.verification_value if creditcard.verification_value?
        card[:name] = creditcard.name if creditcard.name
      end

      post[:card] = card
      add_address(post, options)
    elsif creditcard.kind_of?(String)
      if options[:track_data]
        card[:swipe_data] = options[:track_data]
      else
        #card[:number] = creditcard
        card = creditcard
      end
      post[:card] = card
    end
  end

  def add_customer(post, options)
    #post[:customer] = options[:customer] if options[:customer] && post[:card].blank?
    post[:customer] = options[:customer] if options[:customer]
  end
end