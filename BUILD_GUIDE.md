# Otomatik Build ve Release Rehberi

## GitHub Actions ile Otomatik Setup Oluşturma

### Adım 1: GitHub'a Yükle

```bash
cd "C:\Users\TARIKELER\Desktop\GamerOptimiz"

# Git reposu başlat
git init

# Dosyaları ekle
git add "Tarnak GameHub/"
git add QUICKSTART.md
git add build_setup.bat

# İlk commit
git commit -m "Initial release: Tarnak Game Hub v1.0.0"

# GitHub remote ekle
git remote add origin https://github.com/TARIKTR1099/TarnakGameHub.git

# Push et
git push -u origin main
```

### Adım 2: Release Oluştur

GitHub web sitesine gidin:
1. **Releases** sekmesine tıklayın
2. **"Create a new release"** butonuna tıklayın
3. **Tag version**: `v1.0.0`
4. **Release title**: `Tarnak Game Hub v1.0.0`
5. **Publish release**'e tıklayın

### Adım 3: Bekleyin (2-5 dakika)

GitHub Actions otomatik olarak:
- Projeyi derleyecek
- Testleri çalıştıracak
- Setup dosyasını oluşturacak
- Release'e ekleyecek

### Adım 4: İndirin

Release sayfasında:
- `TarnakGameHub-Setup-1.0.0.exe` dosyasını indirin

## Çözüm 2: AppVeyor ile Ücretsiz Build

Eğer GitHub Actions çalışmazsa:

1. https://www.appveyor.com/ adresine gidin
2. GitHub hesabınızla giriş yapın
3. TarnakGameHub reposunu seçin
4. Otomatik build başlayacak

## Çözüm 3: Yerel Build (Kendi Bilgisayarınızda)

Visual Studio 2022 yüklüyse:

### Seçenek A: Build Script ile (Tek Tıkla)
```batch
# Tarnak GameHub klasörüne gidin
cd "C:\Users\TARIKELER\Desktop\GamerOptimiz\Tarnak GameHub"

# build_setup.bat dosyasını çift tıklayın
```

### Seçenek B: Visual Studio ile
1. `build/TarnakGameHub.sln` dosyasını açın
2. **Release** seçeneğini seçin
3. **Build** menüsü → **Build Solution**
4. `build/bin/Release/` klasöründe .exe oluşur

### Seçenek C: Inno Setup ile Installer
1. Inno Setup 6'yı indirin: https://jrsoftware.org/isdl.php
2. Kurun
3. `Tarnak GameHub/installer/setup.iss` dosyasını Inno Setup ile açın
4. **Build** → **Compile** (Ctrl+F9)
5. `installer/output/` klasöründe setup oluşur

## ⚠️ Önemli Not

Ben bir yapay zeka olduğum için gerçek bir Windows ortamında çalışıp derleme yapamam. Yukarıdaki yöntemlerden birini kullanmalısınız.

**En kolayı:** GitHub Actions (Çözüm 1) - Sadece push yapın, gerisini GitHub halleder!

## Yardım İhtiyacı

Eğer build işleminde hata alırsanız:
1. GitHub Issues'da yeni bir issue açın
2. Hata mesajını paylaşın
3. Size yardımcı olurum
