class API::V1::CurrencyController < API::V1::ApplicationController
  def index
    url : String = "https://www.cbar.az/currency/rates" + (
      params["language"]? ? 
      "?language=" + params["language"] : 
      ""
      )
    page = Crystagiri::HTML.from_url(url)
    parsed_codes, parsed_rates, parsed_currency =  Array(String).new, Array(String).new, Array(String).new
    page.where_class("kod") { |tag| parsed_codes << tag.node.text }
    page.where_class("kurs") { |tag| parsed_rates << tag.node.text }
    page.where_class("valuta") { |tag| parsed_currency << tag.node.text }
    response = Hash(String, Hash(String, String)).new
    parsed_currency.zip(parsed_rates).zip(parsed_codes).each do |cur, code|
      response[code] = {
        "rate" => cur.last,
        "currency" => cur.first
      }
    end
    response.to_json
  end
end