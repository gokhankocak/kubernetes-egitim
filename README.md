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

### Github'daki Alıştırma ve Betiklerin "master" Sanal Sisteme İndirilmesi

Önce host sistemden "master" sisteme giriyoruz:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

"master" sistemde aşağıdaki komutu giriyoruz:

```shell
git clone https://github.com/gokhankocak/kubernetes-egitim.git
```

"master" adlı sisteme **"kubernetes-egitim"** adlı dizine eğitimde kullanacağımız betikler ve konfigürasyon metinleri indirilmiş oldu.
