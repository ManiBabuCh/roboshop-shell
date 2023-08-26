echo -e "\e[32m copying mongodb repo\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[32m installing mongodb\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log
echo -e "\e[32m changing conf ip\e[0m"
sed -i -e 's?127.0.0.1?0.0.0.0' /etc/mongod.conf
echo -e "\e[32m mongodb restart\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log