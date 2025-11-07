class Api::V1::Boards::ListsController < ActionController::API
  before_action :set_board

  # GET /api/v1/boards/:board_id/lists
  # (Bu rotayı kullanmayabiliriz çünkü BoardSerializer zaten listeleri getiriyor,
  # ama API bütünlüğü için eklemek iyi bir pratik)
  def index
    render json: @board.lists
  end

  # POST /api/v1/boards/:board_id/lists
  def create
    @list = @board.lists.new(list_params)
    if @list.save
      render json: @list, status: :created
    else
      render json: @list.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Board not found" }, status: :not_found
  end

  def list_params
    params.require(:list).permit(:title)
  end
end