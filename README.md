# Kubernetes Eğitimi

Kubernetes Eğitimi için hazırladığım belgeleri buradan indiriebilirsiniz. Eğitimde yapılan alıştırmaları da burada bulabilirsiniz.
## Ortam Kurulumu

Alıştırmaları yapabilmek için öncelikle bir ortam kurmamız gerekiyor. Multipass kullanarak Ubuntu sanal sistemler yaratacağız. Bu sanal sistemleri bir Kubernetes cluster kurmak için kullanacağız.
Multipass, Linux, Windows ve Mac OS işletim sistemlerini destekleyen ve kolayca Ubuntu sanal sistem kurabileceğiniz bir araç.

### Multipass Kurulumu
Multipass aracını şu adresten indiribilirsiniz:
[Multipass](https://multipass.run/)

Multipass kurulumunu yaptıktan sonra 3 adet sanal sistem yaratacağız. Bu sanal sistemler Kubernetes cluster'ı oluşturan sistemler olacak.

```shell
multipass launch -m 1G -d 16G -n master # 1 GB bellek ve 16 GB disk alanına sahip "master" aslı sanal makine oluşturulması
multipass launch -m 1G -d 16G -n node1 # 1 GB bellek ve 16 GB disk alanına sahip "node1" aslı sanal makine oluşturulması
multipass launch -m 1G -d 16G -n node2 # 1 GB bellek ve 16 GB disk alanına sahip "node2" aslı sanal makine oluşturulması
```

Sanal sistemlere login olmak için:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

Multipass ile sanal sistemleri oluşturduktan sonra Kubernetes cluster kurmak için MicroK8s adlı aracı kullanacağız.

### MicroK8s Kurulumu
MicroK8s aracı ile ilgili bilgilere şu adresten erişebilirsiniz:
[MicroK8s](https://microk8s.io/)

MicroK8s aracını kurmak için öncelikle sanal sisteme girmemiz gerekiyor:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

Sanal sisteme girdikten sonra aşağıdaki komutları çalıştırıyoruz:

```shell
sudo apt-get update
sudo apt-get upgrade -y
sudo snap install microk8s --classic
sudo microk8s status --wait-ready
sudo microk8s enable dashboard dns registry
sudo microk8s kubectl get all --all-namespaces
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube
exit
```

Bu işlemleri "node1" ve "node2" adlı sanal sistemlerde de yapıyoruz.
Bu adımda artık Kubernetes cluster kurulumu için sanal sistemlerimiz hazır durumda.
Yukarıdaki komutları çalıştırdıktan sonra shell'den çıkıp (exit) sonra "multipass shell master" diyerek tekrar girmeniz gerekiyor, bu işlemi "node1" ve "node2" için de tekrarlamak gerek. Yoksa sürekli microk8s komutundan önce sudo yapmak zorunda kalırsınız.

### Kubernetes Cluster Oluşturma

Bu adımda Kubernetes Cluster oluşturacağız. Önce "master" adlı sanal sisteme giriyoruz:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

"master" adlı sanal sistemde aşğıdaki komutu çalıştırıyoruz:

```shell
sudo microk8s add-node
```

Join node with: microk8s join 192.168.64.11:25000/9c2fae7982089703e4c82adfd87d471e

If the node you are adding is not reachable through the default interface you can use one of the following:
 microk8s join 192.168.64.11:25000/9c2fae7982089703e4c82adfd87d471e
 microk8s join 10.1.43.0:25000/9c2fae7982089703e4c82adfd87d471e

microk8s join ile başlayan komutu kopyalıyoruz. Daha sonra "node1" adlı sisteme girmek için host sisteme geri dönüyoruz.

Aşağıdaki komutu host sistem üzerinde çalıştıyoruz:

```shell
multipass shell node1 # "node1" adlı sistemde bir shell açar
```

"node1" adlı sisteme girdikten sonra, daha önce kopyaladığımız katılım komutunu (microk8s join ...) yapıştırıyoruz:

```shell
sudo microk8s join 192.168.64.11:25000/9c2fae7982089703e4c82adfd87d471e
```

"node1" sisteminin Kubernetes cluster'a katılmasını bekliyoruz.
"master" sisteminde aşağıdaki komutu kullanarak Kubernetes cluster'daki durumu görebiliriz:

Önce host sistemden "master" sisteme giriyoruz:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

"master" sistemde aşağıdaki komutu giriyoruz:

```shell
sudo microk8s kubectl get nodes # Kubernets node'larını listeler
```

NAME            STATUS   ROLES    AGE   VERSION
192.168.64.10   Ready    <none>   58m   v1.18.3-34+0c5dcc01175871
master          Ready    <none>   69m   v1.18.3-34+0c5dcc01175871

"node2" adlı sistemi Kubernetes Cluster'a katmak için "master" sistemde aşağıdaki komutu giriyoruz:

```shell
sudo microk8s add-node
```
Join node with: microk8s join 192.168.64.11:25000/479c49727026664c1b3b278068f2e6c4

If the node you are adding is not reachable through the default interface you can use one of the following:
 microk8s join 192.168.64.11:25000/479c49727026664c1b3b278068f2e6c4
 microk8s join 10.1.43.0:25000/479c49727026664c1b3b278068f2e6c4

Bu sefer farklı bir token üretilecek, microk8s join ile başlayan satırı kopyalıyoruz.

"node2" adlı sisteme girdikten sonra, daha önce kopyaladığımız katılım komutunu (microk8s join ...) yapıştırıyoruz:

```shell
sudo microk8s join 192.168.64.11:25000/479c49727026664c1b3b278068f2e6c4
```

"node2" sisteminin Kubernetes cluster'a katılmasını bekliyoruz.
"master" sisteminde aşağıdaki komutu kullanarak Kubernetes cluster'daki durumu görebiliriz:

Önce host sistemden "master" sisteme giriyoruz:

```shell
multipass shell master # "master" adlı sistemde bir shell açar
```

"master" sistemde aşağıdaki komutu giriyoruz:

```shell
sudo microk8s kubectl get nodes # Kubernets node'larını listeler
```

NAME            STATUS   ROLES    AGE   VERSION
192.168.64.10   Ready    <none>   58m   v1.18.3-34+0c5dcc01175871
192.168.64.9    Ready    <none>   57m   v1.18.3-34+0c5dcc01175871
master          Ready    <none>   69m   v1.18.3-34+0c5dcc01175871

Bu aşamada Kubernetes Cluster kurulumunu tamamlamış olduk.
