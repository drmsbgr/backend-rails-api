# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

puts "🌱 Başlangıç verisi (seed) oluşturuluyor..."

# 1. TEMİZLİK: Eski verileri temizle
# Modellerde 'dependent: :destroy' kullandığımız için 
# sadece en üst seviyedeki (Board) verileri silmemiz yeterli,
# altındaki List ve Card'lar otomatik olarak silinecektir.
puts "Eski veriler temizleniyor..."
Board.destroy_all

# 2. ANA PANO: "Ders Ödevi" Panosu
puts "Ana Pano ('Ders Ödevi Geliştirme') oluşturuluyor..."
dev_board = Board.create!(
  name: "Ders Ödevi Geliştirme"
)

# 3. LİSTELER: Bu panoya ait Kanban listeleri
list_todo = dev_board.lists.create!(title: "Yapılacaklar")
list_doing = dev_board.lists.create!(title: "Üzerinde Çalışılıyor")
list_review = dev_board.lists.create!(title: "İncelemede (Review)")
list_done = dev_board.lists.create!(title: "Tamamlandı")
list_personal_todo = dev_board.lists.create!(title: "Kişisel İşler")
list_personal_movies = dev_board.lists.create!(title: "İzlenecek Filmler")

# 4. KARTLAR: Listeleri dolduracak görevler
puts "Listelere örnek görevler (kartlar) ekleniyor..."

# --- Yapılacaklar Listesi ---
[
  "Frontend (React) projesini kur",
  "Sürükle-bırak (Drag-and-Drop) için kütüphane seç (örn: react-beautiful-dnd)",
  "Cypress ile 'Pano Oluşturma' testi yaz",
  "Kart detaylarını göstermek için bir Modal bileşeni tasarla"
].each_with_index do |content, index|
  list_todo.cards.create!(content: content, position: index)
end

# --- Üzerinde Çalışılıyor Listesi ---
[
  "Tüm API Controller'larını tamamla (Boards, Lists, Cards)",
  "Active Model Serializers ile JSON çıktılarını ayarla"
].each_with_index do |content, index|
  list_doing.cards.create!(content: content, position: index)
end

# --- İncelemede Listesi ---
[
  "API Rotalarını (routes.rb) tanımla"
].each_with_index do |content, index|
  list_review.cards.create!(content: content, position: index)
end

# --- Tamamlandı Listesi ---

[
  "Rails projesini '--api' modunda oluştur",
  "Modelleri (Board, List, Card) ve ilişkileri (has_many, belongs_to) tanımla",
  "Database migration'larını çalıştır",
  "CORS ayarlarını yap (config/initializers/cors.rb)"
].each_with_index do |content, index|
  list_done.cards.create!(content: content, position: index)
end

# ... (Kişisel İşler Panosu için de aynısını yap) ...
puts "Kişisel İşler listesine kartlar ekleniyor..."
["Süt", "Yumurta", "Ekmek"].each_with_index do |content, index|
  list_personal_todo.cards.create!(content: content, position: index)
end

["Dune: Part Two", "Oppenheimer"].each_with_index do |content, index|
  list_personal_movies.cards.create!(content: content, position: index)
end