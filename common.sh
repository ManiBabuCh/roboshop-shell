color="\e[32m"
nocolor= "\e[0m"
app_path = "/app"

app_presetup(){
  echo -e "$color add application user $nocolor"
  useradd roboshop

  echo -e "$color create application directory $nocolor"
  rm -rf $app_path
  mkdir $app_path



  echo -e "$color extract application content$nocolor"
  cd $app_path
  unzip /tmp/$${component}.zip

}

systemd_setup(){
  echo -e "$color  start $${component} service restart $nocolor"
  systemctl daemon-reload
  systemctl enable $${component}
  systemctl start $${component}
}

nodejs(){

echo -e "$color configuring nodejs $nocolor"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "$color install nodejs $nocolor"
yum install nodejs -y

  echo -e "$color downloading $${component} content$nocolor"
  curl -o /tmp/$${component}.zip https://roboshop-artifacts.s3.amazonaws.com/$${component}.zip

app_presetup


echo -e "$color  install nodejs dependencies$nocolor"
cd $app_path
npm install

echo -e "$color configue systemd services$nocolor"
#cd /home/centos/roboshop-shell
cp /home/centos/roboshop-shell/$${component}.service /etc/systemd/system/$${component}.service

systemd_setup

}


mongodb_schema_setup(){
  echo -e "$color copy mogodb.repo$nocolor"

  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo

  echo -e "$color install mongo db $nocolor"
  yum install mongodb-org-shell -y

  echo -e "$color load mongodb schema $nocolor"
  mongo --host mongodb-dev.manibabu.site <$app_path/schema/$${component}.js
}



maven(){
  echo -e "$color install maven $nocolor"
  yum install maven -y

  echo -e "$color $${component} content download$nocolor"
  curl -L -o /tmp/$${component}.zip https://roboshop-artifacts.s3.amazonaws.com/$${component}.zip
  app_presetup


  echo -e "$color download maven dependencies$nocolor"
  cd $app_path
  mvn clean package
  mv target/$${component}-1.0.jar $${component}.jar

  echo -e "$color copy service file $nocolor"
  cp /home/centos/roboshop-shell/$${component}.service /etc/systemd/system/$${component}.service

  #echo -e "$color service restart  $nocolor"


  echo -e "$color install mysql $nocolor"
  yum install mysql -y

  echo -e "$color app schema$nocolor"
  mysql -h mysql-dev.manibabu.site -uroot -pRoboShop@1 < $app_path/schema/$${component}.sql

 systemd_setup
}


python(){

echo -e "$color install python$nocolor"
yum install python36 gcc python3-devel -y


echo -e "$color $${component} content $nocolor"
curl -L -o /tmp/$${component}.zip https://roboshop-artifacts.s3.amazonaws.com/$${component}.zip
app_presetup



echo -e "$color application dependencies$nocolor"
cd /app
pip3.6 install -r requirements.txt


echo -e "$color copy conf file $nocolor"
cp /home/centos/roboshop-shell/$${component}.service /etc/systemd/system/$${component}.service


systemd_setup
}