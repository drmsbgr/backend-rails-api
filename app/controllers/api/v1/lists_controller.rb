class Api::V1::ListsController < ActionController::API
  before_action :set_list

  # PATCH/PUT /api/v1/lists/:id
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/lists/:id
  def destroy
    @list.destroy
    head :no_content # Her şey yolunda, içerik dönmüyorum
  end

  private

  def set_list
    @list = List.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "List not found" }, status: :not_found
  end

  def list_params
    params.require(:list).permit(:title)
  end
end