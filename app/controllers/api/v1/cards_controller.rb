class Api::V1::CardsController < ActionController::API
  before_action :set_card

  # GET /api/v1/cards/:id
  def show
    render json: @card
  end

  # PATCH/PUT /api/v1/cards/:id
  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/cards/:id
  def destroy
    @card.destroy
    head :no_content
  end

  private

  def set_card
    @card = Card.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Card not found" }, status: :not_found
  end

  def card_params
    # Sürükle-bırak ile listenin değişebilmesi için list_id'ye izin veriyoruz.
    # Kartın içeriğini düzenlemek için content'e de izin veriyoruz.
    params.require(:card).permit(:content, :list_id, :position)
  end
end