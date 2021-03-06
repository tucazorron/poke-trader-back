class TradeService
    require 'rest-client'

    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
    end

    def trade_params_service
        baseexp1 = find_base_exp(@player1)
        baseexp2 = find_base_exp(@player2)
        trade = {
            player1: concat_pokemons(@player1),
            player2: concat_pokemons(@player2),
            baseexp1: baseexp1,
            baseexp2: baseexp2,
            fair: is_fair?(baseexp1, baseexp2)
        }
        trade
    end

    def concat_pokemons(player)
        pokemons = ""
        player.each do |p|
            if pokemons != ""
                pokemons += ", " 
            end
            pokemons += p[:label]
        end
        pokemons
    end

    def find_base_exp(player)
        base_exp = 0
        player.each do |p|
            response = RestClient.get "http://pokeapi.co/api/v2/pokemon/#{p[:value]}"
            response_json = JSON.load(response.body)
            base_exp += response_json["base_experience"]
        end
        base_exp
    end

    def is_fair?(baseexp1, baseexp2)
        is_fair = (baseexp1 - baseexp2).abs
        is_fair < 16
    end
end