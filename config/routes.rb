Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users

  resources :dashboard, only: :index
  resources :employees, only: :index

  resources :attendance, only: [] do
    collection do
      get :user_attendance_list
      get :today_attendance_list
      post :time_in
      post :time_out
    end
  end

  resources :dsr, only: [] do
    collection do
      get :add_dsr
      post :create_dsr
      get :send_dsr
      get :received_dsr
      post :fetch_send
      post :fetch_received
    end
    member do
      post :comments
      post :add_comment
    end
  end

  resources :report, only: [] do
    collection do
      get :add_report
      post :create_report
      get :send_report
      get :received_report
      post :fetch_send
      post :fetch_received
    end
  end

  resources :users, only: [] do
    collection do
      get :edit_profile
      post :remove_profile_picture
      post :change_password
      post :profile_picture
    end
  end

  defaults format: :json do
    namespace :api do
      namespace :v1 do
        resources :sessions, only: [:create] do
          match '/', to: 'sessions#destroy', via: 'delete', on: :collection
        end
        resources :sessions, only: [:index]
        resources :dashboard, only: [:index]
        resources :projects, only: [:index] do
          collection do
            get :assigned_projects
          end
        end
        resources :attendances, only: [:index] do
          collection do
            post :time_in
            post :time_out
          end
        end

        resources :employees, only: [] do
          collection do
            get :get_all_user
          end
        end

        resources :daily_status, only: [] do
          collection do
            post :add_dsr
            get :send_list
            get :received_list
          end
          member do
            get :fetch_send
            get :fetch_received
            get :comments
            post :add_comment
          end
        end

        resources :weekly_status, only: [] do
          collection do
            post :add_report
            get :send_list
            get :received_list
          end
          member do
            get :fetch_send
            get :fetch_received
          end
        end

        match '*unmatched', to: 'base#route_not_found', via: :all
      end
    end
  end

  root "dashboard#index"
end
