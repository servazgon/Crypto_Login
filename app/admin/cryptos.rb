ActiveAdmin.register Crypto do
  
  actions :all , except: [:new, :edit, :delete, :destroy]
  
  config.sort_order = 'id_asc'
  config.filters = false

  index :title => "CryptoCurrencies" do
    column "Crypto_id",:crypto_id
    column "Name",:name
    column "Symbol",:symbol
    column "Market cap",:market_cap do |m|
      div :class => 'col_right' do
        m.market_cap
      end
    end
    column "Price USD", :price do |p|
      div :class => 'col_right' do
        p.price.to_s + " $"
      end
    end
    actions
  end  
  
  controller do
    def initialize
      
      require 'net/http'
      require 'uri'
      require 'json'

      begin
        uri = URI.parse("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?sort=market_cap&sort_dir=desc&start=1&limit=10&convert=USD")
        request = Net::HTTP::Get.new(uri)
        request["X-Cmc_pro_api_key"] = "aebc9e83-347a-47a7-8f64-22e6269bbd8b"

        req_options = {
          use_ssl: uri.scheme == "https",
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
           http.request(request)
        end
        
        if response.code == "200"
          Crypto.delete_all
          
          @obj = JSON.parse(response.body)
          @obj["data"].each do |coin|
            @currency = Crypto.new(
                crypto_id: coin["id"],
                symbol: coin["symbol"],
                name: coin["name"],
                market_cap: coin["quote"]["USD"]["market_cap"],
                price: coin["quote"]["USD"]["price"]
              )
              @currency.save
          end
        else
          puts "Error : Coinmarketcap API is not operative now. Try it later please."
        end
      rescue SocketError => e
        puts "Error : #{e}"
      end
    end
  end
end  
