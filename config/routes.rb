Rails.application.routes.draw do
  root  to: "home#index"
  get   "booking", to:  "booking#index"
end
