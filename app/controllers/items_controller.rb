class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
    items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end
#creates a new item belonging to a user
#to create an item that belongs to user, a user must exist, so we find a user first
#to create user.items we set item to user.items.create(attr)
  def create
    user =  User.find(params[:user_id])
    item = user.items.create(item_params)
    render json: item, status: :created
  end

private

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

end

