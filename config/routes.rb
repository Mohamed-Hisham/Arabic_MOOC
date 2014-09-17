Rails.application.routes.draw do
  filter :locale,   :exclude => %r(^admins/)

  # Guest
  resources :courses, only: :index, as: :courses, controller: "courses" do
    resources :sections do
      resources :videos, only: :show
    end
  end

  # Tutor
  devise_for :tutors, :controllers => {:registrations => "tutors/devise/registrations", :sessions => "tutors/devise/sessions"}
  resources :tutors do
    resources :courses, controller: "tutors/courses" do
      resources :sections do
        resources :videos, controller: "tutors/videos" do
          resources :notes, controller: "tutors/notes" do
            resources :synmarks, only: :new
          end
        end
      end
    end
  end

  # Admin
  devise_for :admins
  resources :admins, only: :show
  namespace :admin do
    resources :courses do
      resources :sections do
        resources :videos do
          member do
            post 'guest_can_view'
          end
        end
      end
    end
    resources :tutors
    resources :users
    resources :complaints, only: :index
  end

  # User
  devise_for :users, :controllers => {:registrations => "users/devise/registrations", :sessions => "users/devise/sessions"}
  resources :users, only: [:show, :edit, :update, :destroy]
  namespace :user do
    resources :tutors, only: :show do
      member do
        post 'rate_tutor'
      end
    end
    resources :courses, only: [:index, :show] do
      resources :sections do
        resources :videos do
          resources :complaints, only: [:new, :create]
          member do
            post 'rate_course'
          end
          resources :notes do
            resources :synmarks, only: :new
          end
        end
      end
    end
  end

  root 'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # get 'courses_list' => 'courses#course_list', as: :all_courses, controller: "admins/courses"

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
