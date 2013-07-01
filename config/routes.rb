Dateikit::Application.routes.draw do
  resources :downloads, except: [:show, :new, :create] do
    member do
      get 'download'
    end
  end

  get '/:filename' => 'downloads#download', as: 'get_file'

end
