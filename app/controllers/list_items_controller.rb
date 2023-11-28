# frozen_string_literal: true

# Purpose: ListItemsController is responsible for handling requests for the ListItem model.
class ListItemsController < ApplicationController
  before_action :set_list, only: %i[show update destroy]

  # GET /list_items
  def index
    @list_items = ListItem.all

    render json: @list_items
  end

  # GET /list_items/1
  def show
    render json: @list_item
  end

  # POST /list_items
  def create
    @list_item = ListItem.new(list_params)

    if @list_item.save
      render json: @list_item, status: :created, location: @list_item
    else
      render json: @list_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /list_items/1
  def update
    if @list_item.update(list_params)
      render json: @list_item
    else
      render json: @list_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /list_items/1
  def destroy
    @list_item.destroy
  end

  # GET /list_items/compare
  def compare
    @list_items = current_user.list.list_items.order(votes_count: :desc)

    render json: @list_items
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list_item = ListItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def list_params
    params.require(:list).permit(:name, :id)
  end
end
