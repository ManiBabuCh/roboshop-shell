echo -e "\e[32m copying mongodb repo\e[0m"
#cp /roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[32m installing mongodb\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log
echo -e "\e[32m installing mongodb\e[0m"
#sed -i 's/127.0.0.1/0.0.0.0' /etc/mongod.conf &>>/tmp/roboshop.log
echo -e "\e[32m installing mongodb\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log