
#installing nginx
yum install nginx -y

#remove old content
rm -rf /usr/share/nginx/html/*
#downloading content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

#unzip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip


#copy conf file

#systemservices
systemctl enable nginx
systemctl restart nginx