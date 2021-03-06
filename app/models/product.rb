class Product < ApplicationRecord
    has_one :order, dependent: :destroy
    belongs_to :brand

    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
          # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
          task = find_by(id: row["id"]) || new
          # CSVからデータを取得し、設定する
          task.attributes = row.to_hash.slice(*updatable_attributes)
          task.save
        end
      end
      
      # 更新を許可するカラムを定義
      def self.updatable_attributes
        ["Product_id","callput", "settlement_date", "closing_date", "exercise_price", "option_premium", "brand_id"]
      end
end
