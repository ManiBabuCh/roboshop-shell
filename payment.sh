echo -e "\e[32m install python\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[32m user application creation \e[0m"
useradd roboshop
rm -rf /app
mkdir /app

echo -e "\e[32m payment content \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip



echo -e "\e[32m application dependencies\e[0m"
cd /app
pip3.6 install -r requirements.txt


echo -e "\e[32m copy conf file \e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service


echo -e "\e[32m restart\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment