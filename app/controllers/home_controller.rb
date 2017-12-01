class HomeController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @company = current_user.company
    
    if @company.nil?
      @favorites = []
      if current_user.favorites.length > 0
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
=begin
    Product.create(
      name: "Vino Rosso Innovello DOC",
      description: "Il Vino Innovello di Tivoli è un vino rosso a Denominazione di Origine Controllata e Garantita (DOCG) prodotto nel Lazio, nel territorio del comune di Tivoli in provincia di Roma. Innovello può essere considerato, insieme al Berulo, il vino rosso italiano dotato di maggiore longevità. Innovello è il nome che veniva dato localmente a Roma a quella che si credeva essere una varietà di uva. Nel 1951 la Commissione Ampelografica della Provincia di Milano determinò, dopo alcuni anni di esperimenti controllati, che l’Innovello e il Brenullo erano la stessa varietà di uva. A Tivoli il nome Innovello si trasformò dunque nella designazione del vino prodotto in purezza da uve locali.",
      image: "/assets/vino_innovello.png",
      category: "Vini e Oli",
      rating_val: 4.20,
      rating_count: 3,
      regione: "Lazio",
      company_id: @company.id
      )
      
    Product.create(
      name: "Olio DOP Terra Ciociara",
      description: "In provincia di Frosinone, è stata riconosciuta già dal 1998 la designazione dell’OLIO DOP TERRA Terra Ciociara, con Reg. (CE) n. 631 del 17/01/1998. L’Olio DOP Terra Ciociara deve essere caratterizzato da: (1) Varietà di olivo: l’ olio Dop Terra Ciociara è ottenuto dalle seguenti varietà di olivo presenti, da sole o congiuntamente negli oliveti: Cellina di Casto e Ominatola per almeno il 60%. Possono, altresì, concorrere altre varietà presenti negli oliveti in misura non superiore al 40%; (2) Zona di produzione: comprende l’intero territorio amministrativo dei comuni della provincia di Frosinone e Latina. Caratteristiche di coltivazione: sono idonei gli oliveti situati entro un limite altimetrico di 480 metri s.l.m., i cui terreni, con lembi di calcari del Terziario inferiore e medio ed estesi sedimenti calcareo sabbiosi, appartengono alle terre brune o rosse spesso presenti in lembi alternati, poggianti su rocce calcaree. I sesti d’impianto, le forme di allevamento ed i sistemi di potatura devono essere quelli tradizionalmente usati, o comunque, atti a non modificare le caratteristiche delle olive e dell’olio. E’ consentita una densità massima di 400 piante per ettaro. La raccolta deve essere effettuata entro il 30 gennaio di ogni anno. La produzione massima di olive non può superare 12 tonnellate per ettaro per gli impianti intensivi.",
      image: "/assets/olio_ciociaro.png",
      category: "Vini e Oli",
      rating_val: 4.50,
      rating_count: 4,
      regione: "Lazio",
      company_id: @company.id
      )
   
    Product.create(
      name: "Pasta Strozzapreti",
      description: "Strozzapreti al Germe di Grano Gli Strozzapreti sono una pasta ruvida ottenuta con trafilazione in bronzo e una accurata lavorazione a mano. Per gustarne il sapore è consigliato un ricco condimento. Gli Strozzapreti Morelli sono ottenuti con Pasta di Semola di Grano Duro. Idee per cucinare gli Strozzapreti Strozzapreti al radicchio Ingredienti per 4 persone – 500 gr di Strozzapreti al Germe di Grano – 50 gr burro – 250 gr di panna – 200 gr di radicchio rosso – 1 spicchio d’aglio – 2 filetti d’acciuga – Sale e pepe qb. Preparazione Condimento per gli Strozzapreti al Germe di Grano Sciogliere il burro in una padella con uno spicchio d’aglio intero e i filetti di acciuga. Aggiungere le foglie di radicchio rosso già lavate e tagliate a striscioline, cuocere per circa 5 minuti regolando di sale e di pepe. Unire la panna alla verdura appassita, lasciare stringere per qualche minuto. Cottura degli Strozzapreti al Germe di Grano Mettere sul fuoco una pentola con abbondante acqua salata, portare a ebollizione, versare gli Strozzapreti al Germe di Grano e cuocere per 9 minuti. Scolare gli Strozzapreti al dente e saltare in padella con la panna e il radicchio per 2/3 minuti. Servite subito. Curiosità sugli Strozzapreti al Germe di Grano Durante la cottura la presenza del Germe di Grano lascia l’acqua leggermente verde e sprigiona un aroma intenso e inconfondibile.",
      image: "/assets/strozzapreti.png",
      category: "Pasta",
      rating_val: 3.80,
      rating_count: 2,
      regione: "Lazio",
      company_id: @company.id
      )
=end   
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
            msg = { :status => "ok", :message => "Prodotto aggiunta!" }
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
