Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    #routes for url_controller
    match ''                                  => 'url#index',                                   :via => [:get],               :as => :index
    match 'create_short_url'                  => 'url#create_short_url',                        :via => [:post],              :as => :create_short_url_path

  end

end
