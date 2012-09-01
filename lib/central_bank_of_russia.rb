require 'open-uri'
require 'nokogiri'
require 'money'

class CentralBankOfRussia < Money::Bank::VariableExchange

  CBR_RATES_URL = 'http://www.cbr.ru/scripts/XML_daily.asp'

  def update_rates(date=Date.today)
    rates = parse_rates(open(CBR_RATES_URL + '?date_req=' + date.strftime('%d/%m/%Y')))
    rates.each do |currency, rate|
      begin
        add_rate currency, 'RUB', rate
        add_rate 'RUB', currency, 1/rate
      rescue Money::Currency::UnknownCurrency
        # skip
      end
    end
    self
  end

  def parse_rates(doc_string)
    doc = Nokogiri::XML(doc_string)
    rates = {}
    doc.xpath('//Valute').each do |valute|
      currency = valute.xpath('CharCode').text.upcase
      nominal = valute.xpath('Nominal').text.to_i
      rate = valute.xpath('Value').text.gsub(',', '.').to_f / nominal
      rates[currency] = rate
    end
    rates
  end
  private :parse_rates

end
