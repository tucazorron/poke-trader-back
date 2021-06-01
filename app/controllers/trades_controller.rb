class TradesController < ApplicationController
    skip_before_action :verify_authenticity_token

    require 'rest-client'

    def index
        @trades = Trade.all
        render json: @trades, status: :ok
    end

    def create
        trade_service = TradeService.new(trade_params[:player1], trade_params[:player2])
        @trade = Trade.new(trade_service.trade_params_service)
        if @trade.save
            render json: @trade, status: :created
        else
            render json: { errors: @trades.erros.full_message },
            status: :unprocessable_entity
        end
    end

    private

    def trade_params
        params.require(:trade).permit(:player1, :player2)
        params
    end
end
