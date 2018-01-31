class HomeController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    puts current_user.id
    @company = current_user.company
    
    if @company.nil?
      @favorites = []
      if current_user.favorites && current_user.favorites.length > 0
        current_user.favorites.each do |product_id|
          tmp = Product.find(product_id)
          @favorites.push tmp
        end
      end
      
      @reviews = current_user.reviews
    end
  end
  
  def products
     @company = current_user.company

    if @company
      @products = @company.products
      @type = "company"
    else
      @products = Product.all
      @type = "user" 
    end
  end
  
  def add_product
   
    
    if current_user.company.id == params[:ditta].to_i
      product = Product.new(name: params[:nome_prodotto], description: params[:descrizione_prodotto], category: params[:categoria], company_id: params[:ditta], regione: params[:regione], rating_val: 0, rating_count: 0)
      puts product
      if product.save!
        respond_to do |format|
            msg = { :status => "ok", :message => "Prodotto aggiunto!" }
            format.json  { render :json => msg }
        end
      end
    end
  end
  
  def delete_product
    product = Product.find(params[:id])
    if current_user.company.id == product.company_id
      if product.destroy!
        respond_to do |format|
            msg = { :success => 1, :message => "Prodotto eliminato" }
            format.json  { render :json => msg }
        end
      else
        respond_to do |format|
            msg = { :success => 0, :message => "Errore durante l'eliminazione del prodotto" }
            format.json  { render :json => msg }
        end
      end
    else
      respond_to do |format|
        msg = { :success => 0, :message => "Unauthorized" }
        format.json  { render :json => msg }
      end
    end
  end
  
  
  def edit_product
    product = Product.find(params[:id])
    if current_user.company.id == product.company_id
      if product.update!(name: params[:nome_prodotto], description: params[:descrizione_prodotto], category: params[:categoria])
        respond_to do |format|
            msg = { :success => 1, :message => "Prodotto modificato" }
            format.json  { render :json => msg }
        end
      else
        respond_to do |format|
            msg = { :success => 0, :message => "Errore durante la modifica del prodotto" }
            format.json  { render :json => msg }
        end
      end
    else
      respond_to do |format|
        msg = { :success => 0, :message => "Unauthorized" }
        format.json  { render :json => msg }
      end
    end    
  end
  
  def add_review
    if current_user.id == params[:user]
      text = params[:text].strip.gsub("OR", "")
      rating = params[:rating]
      product = params[:id]
      review = Review.new(user_id: current_user.id, text: text, rating: rating, product_id: product)
      product = Product.find(product)
      product.rating_val = (((product.rating_val*product.rating_count) + rating.to_f)/(product.rating_count+1)).round(2)
      product.rating_count += 1
      if product.save!
        
        if review.save!
          respond_to do |format|
            msg = { :status => "ok", :message => "Recensione aggiunta!", :text => review.text, :rating => review.rating, :created_ad => review.created_at, :product_rating => product.rating_val, :product_rating_count => product.rating_count }
            format.json  { render :json => msg }
          end
        end
        
      end
    end
  end
  
  
  def details
    @tab = params[:tab]
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    
    
  end
  
  
  def add_favorite
    if current_user.id == params[:user_id]
      puts "hey"
      if !(current_user.favorites.include? params[:product_id])
        new_favorites = current_user.favorites.push params[:product_id]
        if User.find(params[:user_id]).update!(favorites: new_favorites)
          respond_to do |format|
            msg = { :status => "ok", :message => "Prodotto Aggiunto ai preferiti!"}
            format.json  { render :json => msg }
          end
        end
      else
        
      end
    else
      
    end
  end
  
  def delete_favorite
    if current_user.id == params[:user_id]
      if current_user.favorites.include? params[:product_id]
        
        if current_user.favorites.length == 1
          new_favorites = []
        else
          new_favorites = current_user.favorites - [params[:product_id]]
        end
        if User.find(params[:user_id]).update!(favorites: new_favorites)
          respond_to do |format|
            msg = { :status => "ok", :message => "Prodotto Rimosso dai preferiti!"}
            format.json  { render :json => msg }
          end
        end
      else
        
      end
    else
      
    end
  end
end
