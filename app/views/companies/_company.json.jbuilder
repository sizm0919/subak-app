json.extract! company, :id, :name, :account_id, :postal_code, :address, :representative_name, :co_number, :co_registration_date, :farmer, :wholesale, :retail, :restaurant, :homemeal, :created_at, :updated_at
json.url company_url(company, format: :json)
