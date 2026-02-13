# 🎮 Tarnak Game Hub

<p align="center">
  <strong>Gelişmiş Oyun Yönetimi ve Optimizasyon Platformu</strong>
</p>

<p align="center">
  <a href="#özellikler">Özellikler</a> •
  <a href="#kurulum">Kurulum</a> •
  <a href="#kullanım">Kullanım</a> •
  <a href="#ekran-görüntüleri">Ekran Görüntüleri</a> •
  <a href="#katkıda-bulunma">Katkıda Bulunma</a>
</p>

---

## 📋 İçindekiler

- [Özellikler](#özellikler)
- [Kurulum](#kurulum)
- [Kullanım](#kullanım)
- [Kısayol Tuşları](#kısayol-tuşları)
- [Proje Yapısı](#proje-yapısı)
- [Geliştirme](#geliştirme)
- [Lisans](#lisans)

## ✨ Özellikler

### 🎹 Tuş Atama Sistemi
- Oyun bazlı tuş atamaları
- Hazır presetler (WASD→ESDF, Ok Tuşları→WASD, IJKL→WASD, Numpad→Ok)
- Oyun başladığında otomatik uygulama, kapandığında varsayılana dönme
- Özel tuş atamaları oluşturma ve kaydetme

### 💬 Global Sohbet (T-Chat)
- **Ctrl+Shift+T** ile tüm oyunlarda erişilebilir
- Oyun içi bağlam desteği
- Şeffaf overlay arayüzü
- Sohbet geçmişi

### ⚡ Sistem Optimizasyonu
- **FPS Boost**: Yüksek performans modu
- **CPU Optimizasyonu**: İşlem öncelikleri yönetimi
- **RAM Optimizasyonu**: Bellek temizliği ve optimizasyonu
- **Temp Dosya Temizleyici**: Windows, tarayıcı ve oyun önbellekleri

### ⏱️ Oyun Zamanlayıcı (Focus Mode)
- Günlük oyun süresi limitleri
- İzin verilen saat aralıkları
- Mola hatırlatıcıları
- Program şablonları

### 🎁 Ücretsiz Oyunlar Takibi
- Steam ve Epic Games ücretsiz oyunları
- Yeni ücretsiz oyun bildirimleri
- Steam hesabı entegrasyonu

### 🌐 Çeviri Sistemi
- **4 Çeviri Motoru**: Google Translate, DeepL, Microsoft, LibreTranslate
- **30+ Dil** desteği
- Sağ tık menüsü entegrasyonu
- Oyun içi çeviri overlay

### 🚀 Ek Özellikler
- Otomatik program başlatma
- Masaüstü kısayolları
- Oyun grupları/kategorileri
- Global overlay (Ctrl+Alt+O)
- Discord RPC entegrasyonu
- Başarım sistemi
- Bulut kayıt senkronizasyonu

## 🚀 Kurulum

### 💾 Kurulum Dosyası ile

1. [Releases](https://github.com/TARIKTR1099/TarnakGameHub/releases) sayfasından `TarnakGameHub-Setup.exe` indirin
2. Kurulum dosyasını çalıştırın
3. Kurulum sihirbazını takip edin
4. Tarnak Game Hub'ı başlatın!

### 🔨 Kaynak Kodundan Derleme

#### Gereksinimler

- Windows 10/11
- Visual Studio 2022
- CMake 3.16+
- Git

#### Derleme Adımları

```bash
# Depoyu klonlayın
git clone https://github.com/TARIKTR1099/TarnakGameHub.git
cd TarnakGameHub

# Build dizini oluşturun
mkdir build
cd build

# Proje dosyalarını oluşturun
cmake .. -G "Visual Studio 17 2022" -A x64

# Derleyin
cmake --build . --config Release

# Kurulum dosyası oluşturun
cpack -C Release
```

## 🎮 Kullanım

### Hızlı Başlangıç

1. `TarnakGameHub.exe` dosyasını çalıştırın
2. Oyunlarınızı kütüphaneye ekleyin
3. Oyun bazlı ayarları yapılandırın
4. Oyununuzu başlatın ve keyfini çıkarın!

### Kısayol Tuşları

| Kısayol | İşlem |
|---------|-------|
| `Ctrl + Alt + O` | Global Overlay Aç/Kapat |
| `Ctrl + Shift + T` | T-Chat Aç |
| `Ctrl + Alt + F` | Focus Mode Aç/Kapat |
| `Ctrl + Shift + R` | Hızlı Optimizasyon |
| `Ctrl + Shift + U` | Ücretsiz Oyunları Güncelle |

### Tuş Atama Kullanımı

1. Bir oyun başlatın
2. Ayarlar menüsünden "Tuş Atama" sekmesine gidin
3. Bir preset seçin veya özel atamalar yapın
4. "Uygula" butonuna tıklayın

### Sistem Optimizasyonu

1. Ana menüden "Sistem Optimizasyonu" sekmesine gidin
2. Profil seçin:
   - 🎮 Gaming Mode
   - ⚡ Maximum Performance
   - ⚖️ Balanced
3. "Quick Optimize" butonuna tıklayın

### Oyun Zamanlayıcı

1. Bir oyun seçin
2. Sağ tık menüsünden "Focus Mode" seçeneğini açın
3. Günlük limit ve saat aralıklarını ayarlayın
4. "Etkinleştir" butonuna tıklayın

### Çeviri Sistemi

1. "Çeviri" sekmesine gidin
2. Kaynak ve hedef dilleri seçin
3. Metni girin ve "Çevir" butonuna tıklayın
4. veya oyun içinde metin seçip sağ tık yapın

## 📁 Proje Yapısı

```
TarnakGameHub/
├── 📂 assets/              # Görseller, ikonlar, fontlar
├── 📂 docs/                # Dokümantasyon
├── 📂 include/             # C++ header dosyaları
│   ├── 📂 core/           # Temel fonksiyonellik
│   ├── 📂 features/       # Özellik implementasyonları
│   └── 📂 ui/             # UI bileşenleri
├── 📂 scripts/            # Lua scriptleri
│   ├── 📂 core/          # Temel scriptler
│   ├── 📂 features/      # Özellik scriptleri
│   └── 📂 utils/         # Yardımcı scriptler
├── 📂 src/                # C++ kaynak dosyaları
├── 📂 tests/             # Birim testler
├── 📂 themes/            # UI temaları
├── 📂 third_party/       # Harici kütüphaneler
├── 📂 translations/      # Dil dosyaları
├── 📂 tools/            # Derleme araçları
├── 📄 CMakeLists.txt    # CMake yapılandırması
├── 📄 LICENSE           # Apache 2.0 Lisans
└── 📄 README.md         # Bu dosya
```

## 🛠️ Geliştirme

### IDE Kurulumu

1. Projeyi Visual Studio 2022'de açın
2. `TarnakGameHub` projesini başlangıç projesi olarak seçin
3. Derleyin ve çalıştırın!

### Lua Scripting

Tarnak Game Hub, otomasyon için Lua scripting destekler:

```lua
-- Örnek: Özel oyun başlatma hook'u
client.add_callback("on_gamelaunch", function(gameInfo)
    print("Başlatılıyor: " .. gameInfo.name)
    -- Özel kodlarınız buraya
end)
```

Daha fazla bilgi için [Lua API Dokümantasyonu](docs/LuaAPI.md) sayfasına bakın.

### Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen [CONTRIBUTING.md](CONTRIBUTING.md) dosyasına bakın.

1. Depoyu fork edin
2. Feature branch oluşturun (`git checkout -b feature/HarikaOzellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'HarikaOzellik eklendi'`)
4. Branch'e push edin (`git push origin feature/HarikaOzellik`)
5. Pull Request açın

## 🐛 Hata Bildirimi

Bir hata bulduysanız, lütfen [GitHub Issues](https://github.com/TARIKTR1099/TarnakGameHub/issues) sayfasında bir issue açın:

- Hatanın açık açıklaması
- Tekrar adımları
- Beklenen vs gerçekleşen davranış
- Ekran görüntüleri (varsa)
- Sistem bilgileri

## 💡 Özellik İsteği

Bir fikriniz mi var? [Feature Request](https://github.com/TARIKTR1099/TarnakGameHub/issues/new?template=feature_request.md) açın!

## 📞 İletişim

- **GitHub:** [@TARIKTR1099](https://github.com/TARIKTR1099)
- **LinkedIn:** [Tarık Eler](https://www.linkedin.com/in/tar%C4%B1k-eler-238698394/)
- **E-posta:** tarnakdev@gmail.com

## 🗺️ Yol Haritası

- [ ] Çapraz platform desteği (Linux, macOS)
- [ ] Mobil eşlikçi uygulama
- [ ] Steam Workshop entegrasyonu
- [ ] Yapay zeka destekli oyun önerileri
- [ ] VR desteği
- [ ] Topluluk marketi

## 📜 Lisans

Bu proje Apache License 2.0 altında lisanslanmıştır - detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 🙏 Teşekkürler

- [Dear ImGui](https://github.com/ocornut/imgui) - Immediate mode GUI kütüphanesi
- [Lua](https://www.lua.org/) - Script motoru
- [nlohmann/json](https://github.com/nlohmann/json) - JSON kütüphanesi
- [sol2](https://github.com/ThePhD/sol2) - C++ için Lua bağlantıları
- Tüm katkıda bulunanlar ve test edenler

---

<p align="center">
  <strong>❤️ Tarnak Geliştirme Ekibi tarafından yapılmıştır</strong>
</p>

<p align="center">
  <a href="https://github.com/TARIKTR1099">
    <img src="https://img.shields.io/badge/GitHub-TARIKTR1099-181717?logo=github" alt="GitHub">
  </a>
  <a href="https://www.linkedin.com/in/tar%C4%B1k-eler-238698394/">
    <img src="https://img.shields.io/badge/LinkedIn-Tarık%20Eler-0077B5?logo=linkedin" alt="LinkedIn">
  </a>
</p>
