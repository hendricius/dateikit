Dateikit::Application.routes.draw do
  resources :downloads, except: [:show, :new, :create] do
    member do
      get 'download'
    end
  end

  match '/f/:filename' => 'downloads#download',
    constraints: { filename: /.*/ }, via: :get

end
