
#installing nginx
echo -e "\e[32m installing nginx\e[0m"
yum install nginx -y >>/tmp/roboshop.log

#remove old content
echo -e "\e[32m remove old content\e[0m"
rm -rf /usr/share/nginx/html/* >>/tmp/roboshop.log
#downloading content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip >/tmp/roboshop.log 2>/tmp/roboshoperror.log

#unzip
echo -e "\e[32m unzip\e[0m"
cd /usr/share/nginx/html >>/tmp/roboshop.log
unzip /tmp/frontend.zip  >>/tmp/roboshop.log


#copy conf file
echo -e "\e[32m copy conf file\e[0m"

#systemservices
echo -e "\e[32m systemservices\e[0m"
systemctl enable nginx >>/tmp/roboshop.log
systemctl restart nginx >>/tmp/roboshop.log