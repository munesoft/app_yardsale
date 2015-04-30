class HomeController < ApplicationController

  around_filter :shopify_session

  def index
    @products = ShopifyAPI::Product.all
    @product_map = @products.each_with_object(Hash.new("not found")) { |e, a| a["#{e.attributes[:id]}"] = e.attributes[:title] }
    # XXX find the right shop, not the first!!!
    @product_buyers = Shop.first.products
  end

  def modal
  end

  def modal_buttons
  end

  def regular_app_page
  end

  def buttons
  end

  def help
  end

  def error
    raise "An error page"
  end

  def form_page
    if request.post?
      if params[:name].present?
        flash[:notice] = "Created #{ params[:colour] } unicorn: #{ params[:name] }."
      else
        flash[:error] = "Name must be set."
      end
    end
  end

  def pagination
    @total_pages = 3
    @page = (params[:page].presence || 1).to_i
    @previous_page = "/pagination?page=#{ @page - 1 }" if @page > 1
    @next_page = "/pagination?page=#{ @page + 1 }" if @page < @total_pages
  end

end
