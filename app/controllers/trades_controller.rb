class TradesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @trades = Trade.all
        puts @trades
        render json: @trades, status: :ok
    end

    def create
        trade_service = TradeService.new(trade_params)
        @trade = Trade.new(trade_service.trade_params_service)
        puts "create"
        p @trade, trade_service
        if @trade.save
            render json: @trade, status: :created
        else
            render json: { errors: @trades.erros.full_message },
            status: :unprocessable_entity
        end
    end

    private

    def trade_params
        params.require(:trade)
    end

end
