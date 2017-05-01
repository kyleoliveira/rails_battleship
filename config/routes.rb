Rails.application.routes.draw do
    scope module: 'api' do
      namespace :v1 do
        resources :boards do
          put 'nuke' => 'boards#nuke'
        end
        resources :battleships
      end
    end
end
