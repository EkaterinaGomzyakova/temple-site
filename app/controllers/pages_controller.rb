class PagesController < ApplicationController
  def education
    @clubs = Club.all
  end

  def culture
  end

  def shop
    @products = Product.all.order(:position) # все товары
  end

  def cafe
  end
end
