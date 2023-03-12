# sfd

Разворачиваем инфраструктуру в Yandex.Cloud:

> Клонируем проект

```sh
git clone https://github.com/eugeneisaev/sfd.git
cd 
```

> Генерируем ключи и копируем в каталог проекта

```sh
ssh-keygen -t rsa
cp ~/.ssh/id_rsa* ./
```

> Правим данные провайдера в Yandex Cloud terraform/main.tf 

```sh
cd terraform 
terraform init 
terraform apply
```

> Устанавливаем через ansible компоненты

```sh
cd ../ansible 
ansible-playbook -i ../inventory.ini -u ubuntu ansible_playbook.yml
ansible-playbook -i ../inventory.ini -u ubuntu ansible_playbook_srv.yml


# sf-sprint-2

> Репозиторий с workflow(pipeline GitHub Actions) с деплоем в Docker Hub

https://github.com/eugeneisaev/django-pg-docker

> Генерируемый образ в Docker Hub

docker pull evgeniy4/django-pg-docker

> Деплой проекта с помощью Helm Charts:

```sh
cd sf-sprint-2/charts/
helm upgrade --install --namespace default --values db-chart/values.yaml mydb db-chart
helm upgrade --install --namespace default --values app-chart/values.yaml myapp app-chart.
```

> Зайти в приложение по адресу ноды

# sf-sprint-3

> Деплой мониторинга на сервер srv:

```sh
cd sf-sprint-3 
```

> Добавить токен Telegram-бота и telegram admin в docker-compose.yml
> Изменить ip адрес(ip_addr) и порт таргет сервера для запросов(prometheus/prometheus.yml, alert.rules)

```sh
docker-compose up -d
```