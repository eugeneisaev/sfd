# sfd

Разворачиваем инфраструктуру в Yandex.Cloud:

> Клонируем проект

```sh
$ git clone 
$ cd 
```

> Генерируем ключи и копируем в каталог проекта

```sh
$ ssh-keygen -t rsa
$ cp ~/.ssh/id_rsa* ./
```

> Правим данные провайдера в Yandex Cloud terraform/main.tf 

```sh
$ cd terraform 
$ terraform init 
$ terraform apply
```

> Устанавливаем через ansible компоненты

```sh
$ cd ../ansible 
$ ansible-playbook -i ../inventory.ini -u ubuntu ansible_playbook.yml
```
