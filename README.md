
# Merhaba

Bu repo akıllı sözleşmeleri deploy etmek, derleme, test işlemleri için oluşturulmuş bir truffle projesidir.

# ImageNFT Akıllı Sözleşmesi

Bu, ERC-721 standardına dayalı bir non-fungible token (NFT) için bir akıllı sözleşmedir. Kullanıcıların resim URL'leri ile NFT'ler oluşturmasına ve bunları ETH kullanarak satın almasına / satmasına izin verir.

# Ön Gereksinimler

    Node.js 14 veya daha yüksek sürümü
    Windows, Linux, ya da macOS

# Başlangıç

Bu proje klonlanarak yerel makineye indirilebilir. Aşağıdaki komutları kullanarak projeyi klonlayabilirsiniz.

```bash
git clone https://github.com/bitirmeProjesi2023/contract-deployer.git
```

Bu komut, projenin bağımlılıklarını yükler.

```bash
npm install truffle -g
npm install
```

Akıllı sözleşmeyi derleyin:

```bash
truffle compile
```

Akıllı sözleşmeyi deploy edin, dağıtın.

```bash
truffle migrate
```

Not: Bu, akıllı sözleşmeyi yerel geliştirme ağına (örneğin, Ganache) dağıtacaktır. Farklı bir ağa dağıtmak isterseniz, truffle-config.js dosyasını buna göre düzenleyin.

İsteğe bağlı,akıllı sözleşmeyi test edin:

```bash
truffle migrate
```

# Katkıda Bulunma

Bu proje, katkıda bulunmak isteyen geliştiriciler için açıktır. Lütfen değişiklikleriniz için bir pull request oluşturun ve açıklayıcı bir açıklama ekleyin.

# Lisans

Bu proje, MIT lisansı altında lisanslanmıştır.
