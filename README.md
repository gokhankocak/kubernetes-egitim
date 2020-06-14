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

Bu sanal sistemler Kubernetes cluster'ı oluşturan sistemler olacak.

```shell
multipass launch -m 2G -d 16G -n master # 1 GB bellek ve 16 GB disk alanına sahip "master" aslı sanal makine oluşturulması
multipass launch -m 2G -d 16G -n node1 # 1 GB bellek ve 16 GB disk alanına sahip "node1" aslı sanal makine oluşturulması
multipass launch -m 2G -d 16G -n node2 # 1 GB bellek ve 16 GB disk alanına sahip "node2" aslı sanal makine oluşturulması
```

Sanal sistemlere login olmak için:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

Multipass ile sanal sistemleri oluşturduktan sonra Kubernetes cluster kurmak için MicroK8s adlı aracı kullanacağız.

### MicroK8s Kurulumu

MicroK8s aracı ile ilgili bilgilere şu adresten erişebilirsiniz:
[MicroK8s](https://microk8s.io/)

Öncelikle yardımcı betikleri indirmek için aşağıdaki komutu çalıştırıyoruz:

```shell
git clone https://github.com/gokhankocak/kubernetes-egitim.git
cd kubernetes-egitim
```

"Kube.sh" adlı betiği sanal sistemlere kopyalayıp çalıştırıyoruz.

Bu betik gerekli programları sanal sistemlere kuracak ve Kubernetes Cluster kurulumunu yapacaktır.

```shell
multipass transfer betik/Kube.sh master:/tmp
multipass exec master /bin/bash /tmp/Kube.sh
```

Bu işlemleri "node1" ve "node2" adlı sanal sistemlerde de yapıyoruz.

```shell
multipass transfer betik/Kube.sh node1:/tmp
multipass exec node1 /bin/bash /tmp/Kube.sh
```

```shell
multipass transfer betik/Kube.sh node2:/tmp
multipass exec node2 /bin/bash /tmp/Kube.sh
```

### Kubernetes Cluster Oluşturma

Bu adımda Kubernetes Cluster oluşturacağız. Önce "master" adlı sanal sisteme aşağıdaki komutu gönderiyoruz:

```shell
multipass exec master sudo microk8s add-node # "master" adlı sistemi yeni bir node eklemek için hazırlar
```

Join node with: *microk8s join 192.168.64.11:25000/9c2fae7982089703e4c82adfd87d471e*

microk8s join ile başlayan komutu kopyalıyoruz.

Daha sonra "node1" adlı sistemi cluster'a katmak için aşağıdaki işlemleri yapıyoruz.

"node1" adlı sisteme daha önce kopyaladığımız katılım komutunu (microk8s join ...) yapıştırıyoruz:

```shell
multipass exec node1 sudo microk8s join 192.168.64.11:25000/9c2fae7982089703e4c82adfd87d471e
```

"node1" sisteminin Kubernetes cluster'a katılmasını bekliyoruz.

"master" sisteminde aşağıdaki komutu kullanarak Kubernetes cluster'daki durumu görebiliriz:

"master" sisteme aşağıdaki komutu gönderiyoruz:

```shell
multipass exec master sudo microk8s kubectl get nodes # Kubernets node'larını listeler
```

NAME            STATUS   ROLES    AGE   VERSION  

192.168.64.10   Ready    <none>   58m   v1.18.3-34+0c5dcc01175871  

master          Ready    <none>   69m   v1.18.3-34+0c5dcc01175871  

"node2" adlı sistemi Kubernetes Cluster'a katmak için "master" sisteme aşağıdaki komutu gönderiyoruz:

```shell
multipass exec master sudo microk8s add-node
```
Join node with: *microk8s join 192.168.64.11:25000/479c49727026664c1b3b278068f2e6c4*

Bu sefer farklı bir token üretilecek, microk8s join ile başlayan satırı kopyalıyoruz.

"node2" adlı sisteme daha önce kopyaladığımız katılım komutunu (microk8s join ...) yapıştırıyoruz:

```shell
multipass exec node2 sudo microk8s join 192.168.64.11:25000/479c49727026664c1b3b278068f2e6c4
```

"node2" sisteminin Kubernetes cluster'a katılmasını bekliyoruz.

"master" sisteminde aşağıdaki komutu kullanarak Kubernetes cluster'daki durumu görebiliriz:

```shell
multipass exec master sudo microk8s kubectl get nodes # Kubernets node'larını listeler
```

NAME            STATUS   ROLES    AGE   VERSION  

192.168.64.10   Ready    <none>   58m   v1.18.3-34+0c5dcc01175871  

192.168.64.9    Ready    <none>   57m   v1.18.3-34+0c5dcc01175871  

master          Ready    <none>   69m   v1.18.3-34+0c5dcc01175871  

Bu aşamada Kubernetes Cluster kurulumunu tamamlamış olduk.

### Github'daki Alıştırma ve Betiklerin İndirilmesi

Önce host sistemden "master" sisteme giriyoruz:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

"master" sistemde aşağıdaki komutu giriyoruz:

```shell
git clone https://github.com/gokhankocak/kubernetes-egitim.git
```

"master" adlı sisteme **"kubernetes-egitim"** adlı dizine eğitimde kullanacağımız betikler ve konfigürasyon metinleri indirilmiş oldu.
