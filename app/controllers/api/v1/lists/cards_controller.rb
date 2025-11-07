class Api::V1::Lists::CardsController < ActionController::API
  before_action :set_list

  # GET /api/v1/lists/:list_id/cards
  # (Bu da ListSerializer içinde zaten geliyor olabilir, ama API bütünlüğü için önemli)
  def index
    render json: @list.cards
  end

  # POST /api/v1/lists/:list_id/cards
  def create
    @card = @list.cards.new(card_params)
    @card.position = @list.cards.count

    if @card.save
      render json: @card, status: :created
    else
      render json: @card.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "List not found" }, status: :not_found
  end

  def card_params
    params.require(:card).permit(:content, :position)
  end
end