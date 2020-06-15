# Kubernetes Eğitimi

Kubernetes Eğitimi için hazırladığım belgeleri buradan indirebilirsiniz.

Eğitimde yapılan alıştırmaları da burada bulabilirsiniz.

## Ortam Kurulumu

Alıştırmaları yapabilmek için öncelikle bir ortam kurmamız gerekiyor.

Multipass kullanarak Ubuntu sanal sistemler yaratacağız.

Bu sanal sistemleri bir Kubernetes cluster kurmak için kullanacağız.

Multipass, Linux, Windows ve Mac OS işletim sistemlerini destekleyen ve kolayca Ubuntu sanal sistem kurabileceğiniz bir araç.

### Multipass Kurulumu

Multipass aracını şu adresten indiribilirsiniz:
[Multipass](https://multipass.run/)

Multipass kurulumunu yaptıktan sonra 3 adet sanal sistem yaratacağız.

### Kubernetes Cluster Oluşturma

Öncelikle yardımcı betikleri indirmek için aşağıdaki komutu çalıştırıyoruz:

```shell
git clone https://github.com/gokhankocak/kubernetes-egitim.git
cd kubernetes-egitim
```

Kube.sh adlı betik "master", "node1" ve "node2" adlı 3 tane sanal sistem yaratacak.
Bu sistemlere gerekli yazılımları yükleyecek.

**kubernetes-egitim** dizininde olduğunuzu varsayarak:

```shell
cd betik
./Kube.sh
```

#### "node1" Sistemini Cluster'a Ekleme

YeniNode.sh adlı betik ise Kubernetes Cluster'a yeni bir node eklemeye yardımcı olacak.

```shell
./YeniNode.sh
```

Aşağıdakine benzer bir çıktı göreceksiniz. IP adresleri ve token sizde farklı olacak.

Join node with: *microk8s join 192.168.64.11:25000/9c2fae7982089703e4c82adfd87d471e*

microk8s join ile başlayan komutu kopyalıyoruz.

Daha sonra "node1" adlı sistemi cluster'a katmak için aşağıdaki işlemleri yapıyoruz.

"node1" adlı sisteme daha önce kopyaladığımız katılım komutunu (microk8s join ...) yapıştırıyoruz:

```shell
multipass exec node1 sudo microk8s join 192.168.64.11:25000/9c2fae7982089703e4c82adfd87d471e
```

"node1" sisteminin Kubernetes cluster'a katılmasını bekliyoruz.

#### "node2" Sistemini Cluster'a Ekleme

"node2" sistemini Kubernetes Cluster'a katmak için yine YeniNode.sh adlı betiği çalıştırıyoruz.
```shell
./YeniNode.sh
```

Aşağıdakine benzer bir çıktı göreceksiniz. IP adresleri ve token sizde farklı olacak.

Join node with: *microk8s join 192.168.64.11:25000/479c49727026664c1b3b278068f2e6c4*

Bu sefer farklı bir token üretilecek, microk8s join ile başlayan satırı kopyalıyoruz.

"node2" adlı sisteme daha önce kopyaladığımız katılım komutunu (microk8s join ...) yapıştırıyoruz:

```shell
multipass exec node2 sudo microk8s join 192.168.64.11:25000/479c49727026664c1b3b278068f2e6c4
```

"node2" sisteminin Kubernetes cluster'a katılmasını bekliyoruz.

Bu aşamada Kubernetes Cluster kurulumunu tamamlamış olduk.

#### Kubernetes Cluster'ın Durumunu Görme

```shell
multipass exec master sudo microk8s kubectl get nodes
```

| NAME         |   STATUS   |  ROLES |   AGE   | VERSION                   |
|--------------|------------|--------|---------|---------------------------|
|192.168.64.10 |  Ready     | <none> |   102s  | v1.18.3-34+0c5dcc01175871 |
|192.168.64.9  |  Ready     | <none> |   102s  | v1.18.3-34+0c5dcc01175871 |
|master        |  Ready     | <none> |   102s  | v1.18.3-34+0c5dcc01175871 |


### Github'daki Alıştırma ve Betiklerin "master" Sanal Sisteme İndirilmesi

Önce host sistemden "master" sisteme giriyoruz:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

"master" sistemde aşağıdaki komutu giriyoruz:

```shell
git clone https://github.com/gokhankocak/kubernetes-egitim.git
cd kubernetes-egitim
cd betik
chmod +x *.sh
```

"master" adlı sisteme **"kubernetes-egitim"** adlı dizine eğitimde kullanacağımız betikler ve konfigürasyon metinleri indirilmiş oldu.

### Kubernetes Dashboard Çalıştırılması

Önce host sistemden "master" sisteme giriyoruz:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

"master" sistemde aşağıdaki komutu giriyoruz:

```shell
cd kubernetes-egitim
cd betik
./OnPanel.sh
```
Bu aşamada bir token üretildi ve ekrana yazıldı. Bu token aşağıdaki adımda kullanılacak.

Ayrı bir komut satırı açıp "host" sistemde "master" sistemin IP adresini not ediyoruz.
Bunun için multipass komutunu kullanıyoruz.

```shell
multipass list
```

Listede "master" sistemin IP adresini göreceksiniz, bunu bir sonraki adımda kullanacağız.

Firefox tarayıcı açıyoruz. Çünkü Chrome güvenlikle ilgili uyarılar veriyor.

Tarayıcıda "https://MASTER_IP_ADRESI:10443/#/overview?namespace=default" adresini yazıyoruz.

Firefox'un güvenlik uyarılarını kabul ettikten sonra Kubernetes Dashboard login ekranına geliyoruz.
"Token" seçeneğini tıkladıktan sonra "master" sistem üzerinde bize verilen token'ı buraya kopyalıyoruz.
