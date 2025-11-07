class Api::V1::BoardsController < ActionController::API
  before_action :set_board, only: [:show, :update, :destroy]

  # GET /api/v1/boards
  def index
    @boards = Board.all
    render json: @boards
  end

  # GET /api/v1/boards/:id
  def show
    # set_board metodu panoyu buldu
    # Frontend'in tüm listelere ve kartlara ihtiyacı var.
    # Serializer bunu bizim için halledecek (Aşama 4)
    render json: @board, include: 'lists.cards'
  end

  # POST /api/v1/boards
  def create
    @board = Board.new(board_params)
    if @board.save
      render json: @board, status: :created
    else
      render json: @board.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/boards/:id
  def update
    if @board.update(board_params)
      render json: @board
    else
      render json: @board.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/boards/:id
  def destroy
    @board.destroy
    head :no_content # Cevap olarak body dönme, sadece 204 (No Content)
  end

  private

  def set_board
    @board = Board.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Board not found" }, status: :not_found
  end

  def board_params
    params.require(:board).permit(:name)
  end
end