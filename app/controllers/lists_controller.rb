# frozen_string_literal: true

# Purpose: ListsController is responsible for handling requests for the List model.
class ListsController < ApplicationController
  before_action :set_list, only: %i[show update destroy add_list_item list_items vote]

  # GET /lists
  def index
    binding.pry
    @lists = List.where(user_id: params[:user_id])
    if @lists
      render json: { lists: @lists }, status: :ok
    else
      render json: { message: 'No lists found' }, status: :not_found
    end
  end

  # GET /lists/1
  def show
    render json: { list: @list, list_items: @list_items }
  end

  # POST /lists
  def create
    binding.pry
    list = List.create(name: params[:name], user_id: params[:user_id])

    params[:items].each do |item|
      list_item = ListItem.new(name: item[:name])
      list_item.list = list
      list_item.save
    end

    if list.save
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    puts e
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def add_list_item
    @list_item = ListItem.create(name: params[:name], list: @list)
    @list_item.list = @list

    if @list_item.save
      render json: @list_item, status: :created, location: @list_item
    else
      render json: @list_item.errors, status: :unprocessable_entity
    end
  end

  def vote
    @list.completed = params[:completed]
    @list.save

    params[:sorted].each do |list_item|
      @list_item = ListItem.find(list_item[:id])
      @list_item.votes_count = list_item[:votes]
      @list_item.save
    end
    # render ok status
    render json: {  message: 'Everything has saved and your list has been prioritized', status: :ok }
  rescue StandardError => e
    puts e
    render json: { message: 'something went wrong, try again another time', status: :unprocessable_entity }
  end

  def list_items
    @list_items = @list.list_items

    render json: @list_items
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = List.find(params[:id])
    @list_items = @list.list_items.order(votes_count: :desc) if @list
  end

  # Only allow a list of trusted parameters through.
  def list_params
    params.require(:list).permit(:name, :completed)
  end
end
