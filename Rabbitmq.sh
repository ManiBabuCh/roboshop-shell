echo -e "\e[32m download erlang\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[32m download rabbitmq package \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[32m install rabbitmq\e[0m"
yum install rabbitmq-server -y

echo -e "\e[32m restart \e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e "\e[32m change rabbitmq user\e[0m"
rabbitmqctl add_user roboshop roboshop123

echo -e "\e[32m change rabbitmq pwd\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"