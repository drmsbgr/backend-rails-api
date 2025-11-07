Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      
      # /api/v1/boards (Tüm panoları getir, yeni pano oluştur)
      # /api/v1/boards/:id (Tek panoyu getir, güncelle, sil)
      resources :boards, only: [:index, :show, :create, :update, :destroy] do
        
        # /api/v1/boards/:board_id/lists (Bir panoya ait listeleri getir/oluştur)
        resources :lists, only: [:index, :create], module: :boards # module: :boards -> Boards::ListsController'ı arar
      end

      # /api/v1/lists/:id (Tek listeyi güncelle, sil)
      resources :lists, only: [:update, :destroy] do
        
        # /api/v1/lists/:list_id/cards (Bir listeye ait kartları getir/oluştur)
        resources :cards, only: [:index, :create], module: :lists # module: :lists -> Lists::CardsController'ı arar
      end
      
      # /api/v1/cards/:id (Tek kartı getir, güncelle, sil)
      # Not: Kartların "sürükle-bırak" ile listesi değişeceği için update'e ihtiyacımız var.
      resources :cards, only: [:show, :update, :destroy]

    end
  end
end