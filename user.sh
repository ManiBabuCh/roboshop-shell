echo -e "\e[32m configuring user \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[32m install nodejs \e[0m"
yum install nodejs -y

echo -e "\e[32m add application user \e[0m"
useradd roboshop

echo -e "\e[32m create application directory \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m downloading user content\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

echo -e "\e[32m extract application content\e[0m"
cd /app
unzip /tmp/user.zip

echo -e "\e[32m  install nodejs dependencies\e[0m"
cd /app
npm install

echo -e "\e[32m configue systemd services\e[0m"
#cd /home/centos/roboshop-shell
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[32m  start user service\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl start user

echo -e "\e[32m copy mogodb.repo\e[0m"

cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m install mongo db \e[0m"
yum install mongodb-org-shell -y

echo -e "\e[32m load mongodb schema \e[0m"
mongo --host mongodb-dev.manibabu.site </app/schema/user.js