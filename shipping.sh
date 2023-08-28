
echo -e "\e[32m install maven \e[0m"
yum install maven -y

echo -e "\e[32m user application creation\e[0m"
useradd roboshop

echo -e "\e[32m shipping content\e[0m"
rm -rf /app
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip

echo -e "\e[32m download maven dependencies\e[0m"
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[32m copy service file \e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service

#echo -e "\e[32m service restart  \e[0m"


echo -e "\e[32m install mysql \e[0m"
yum install mysql -y

echo -e "\e[32m app schema\e[0m"
mysql -h mysql-dev.manibabu.site -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[32m restart\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping