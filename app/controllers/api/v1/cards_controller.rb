class Api::V1::CardsController < ApplicationController
  def index
    if params[:category_id].present?
      @cards = Card.joins(:category).where(category_id: params[:category_id])
    else
      @cards = Card.joins(:category)
    end
    render json: @cards.all, include: ['category'], except: ['category_id']
  end

  def show
    @card = Card.find(params[:id])
    render json: @card, include: ['category'], except: ['category_id'], methods: [ 'next' ]
  end

  def next
    current_card = Card.find(params[:id])
    @card = current_card.next
    render json: @card, include: ['category'], except: ['category_id']
  end

  def create
    @card = Card.create(card_params)
    render json: @card, status: :created
  end

  def update
    @card = Card.find(params[:id])
    @card.update(card_params)
    render json: @card
  end

private

  def card_params
    params.require(:card).permit(:title, :body)
  end
end
