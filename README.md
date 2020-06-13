# Kubernetes Eğitimi

Kubernetes Eğitimi için hazırladığım belgeleri buradan indiriebilirsiniz. Eğitimde yapılan alıştırmaları da burada bulabilirsiniz.
# Ortam Kurulumu

Alıştırmaları yapabilmek için öncelikle bir ortam kurmamız gerekiyor. Multipass kullanarak Ubuntu sanal sistemler yaratacağız. Bu sanal sistemleri bir Kubernetes cluster kurmak için kullanacağız.
Multipass, Linux, Windows ve Mac OS işletim sistemlerini destekleyen ve kolayca Ubuntu sanal sistem kurabileceğiniz bir araç.

# Multipass Kurulumu
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

# MicroK8s Kurulumu
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
```

Bu şlemleri "node1" ve "node2" adlı sanal sistemlerde de yapıyoruz.
Bu adımda artık Kubernetes cluster kurulumu için sanal sistemlerimiz hazır durumda.



