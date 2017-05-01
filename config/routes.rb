Rails.application.routes.draw do
    scope module: 'api' do
      namespace :v1 do
        resources :battleships
        delete 'battleships' => 'battleships#nuke'
      end
    end
end
