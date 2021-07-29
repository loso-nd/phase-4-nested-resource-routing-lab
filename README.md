# Nested Resource Routing Lab

## Learning Goals

- Create nested routes
- Use params in nested routes

## Introduction

In this lab, we'll continue working on our Craigslist-style marketplace API, and
build out some nested routes to give users easier access to our data.

```txt
User -< Item
```

Get the lab set up by running:

```sh
bundle install
rails db:migrate db:seed
```

There is seed data in place so you can test your solution out in Postman. You
can also run `learn test` to run the tests.

## Instructions

You will need to handle the requests listed below and return the appropriate
JSON data in the response.

**Note:** watch out for [Rails' `DoubleRenderError`][double render error] as you
work. The error is fairly straightforward: Rails only allows `render` to be
called once in an action. We have seen one way to avoid this error: by using
conditional code to ensure that only one `render` executes. A second way to
avoid the error is to include an explicit `return`, eg: `return render json:
...` to keep any later `render` statements from executing.

[double render error]: https://api.rubyonrails.org/classes/AbstractController/DoubleRenderError.html

### Nested Items Index Route

This route should show all items for one individual user.

```txt
GET /users/:user_id/items

Response Body
-------
[
  {
    "id": 1,
    "name": "Non-stick pan",
    "description": "Sticks a bit",
    "price": 10,
    "user_id": 1
  },
  {
    "id": 1,
    "name": "Ceramic plant pots",
    "description": "Plants not included",
    "price": 31,
    "user_id": 1
  }
]
```

### Nested Item Show Route

This route should show one item matching the `:id` from the URL.

```txt
GET /users/:user_id/items/:id

Response Body
-------
{
  "id": 1,
  "name": "Non-stick pan",
  "description": "Sticks a bit",
  "price": 10,
  "user_id": 1
}
```

### Nested Item Create Route

This route should create a new item that belongs to a user.

```txt
POST /users/:user_id/items

Headers:
-------
Content-Type: application/json

Request Body:
-------
{
  "name": "Garden gnomes",
  "description": "No refunds",
  "price": 23
}

Response Body:
-------
{
  "id": 2,
  "name": "Garden gnomes",
  "description": "No refunds",
  "price": 23,
  "user_id": 1
}
```

## Resources

- [Routing: Nested Resources](https://guides.rubyonrails.org/routing.html#nested-resources)



<!-- class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = find_item
    render json: item
  end

  def create
    user = find_user
    item = user.items.create(item_params)
    render json: item, status: :created
  end

  private

  def find_item
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

end -->