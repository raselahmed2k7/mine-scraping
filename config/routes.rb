Rails.application.routes.draw do
  root "scraping_tickets#index"

  get "/tickets", to: "scraping_tickets#index"
end
