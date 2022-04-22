# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

CSV.foreach('db/brand.csv', headers: true) do |row|
    Brand.create!(row.to_hash)
end

CSV.foreach('db/product.csv', headers: true) do |row|
    Product.create!(row.to_hash)
end

CSV.foreach('db/productprice.csv', headers: true) do |row|
    ProductPrice.create(
        brand_id: row[0],
        price_date: row[1],
        price: row[2])
end

CSV.foreach('db/cattlenum.csv', headers: true) do |row|
    CattleNum.create(
        brand_id: row[0],
        date: row[1],
        num: row[2])
end

CSV.foreach('db/admin.csv', headers: true) do |row|
    Admin.create(
        email: row[0],
        password: row[1])
end

CSV.foreach('db/account.csv', headers: true) do |row|
    Account.create(
        email: row[0],
        password: row[1])
end
