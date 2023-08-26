echo -e "\e[32m configuring nodejs \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32m install nodejs \e[0m"
yum install nodejs -y

echo -e "\e[32m add application user \e[0m"
useradd roboshop

echo -e "\e[32m create application directory \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m downloading catalogue content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[32m extract application content\e[0m"
cd /app
unzip /tmp/catalogue.zip

echo -e "\e[32m  install nodejs dependencies\e[0m"
cd /app
npm install

echo -e "\e[32m configue systemd services\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[32m  start catalogue service\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[32m copy mogodb.repo\e[0m"
cp mogodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m install mongo db \e[0m"
yum install mongodb-org-shell -y

echo -e "\e[32m load mongodb schema \e[0m"
mongo --host mongodb-dev.manibabu.site </app/schema/catalogue.js