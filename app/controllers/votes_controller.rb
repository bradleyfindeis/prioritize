class VotesController < ApplicationController
  before_action :set_list_item

  def create
    @vote = @list_item.votes.new(user_id: current_user.id, value: params[:value])

    if @vote.save
      @list_item.compared_list_item_ids << params[:compared_list_item_id]
      @list_item.save
      render json: @list_item
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vote = @list_item.votes.find_by(user_id: current_user.id)
    @vote.destroy

    render json: @list_item
  end

  private

  def set_list_item
    @list_item = ListItem.find(params[:list_item_id])
  end
end