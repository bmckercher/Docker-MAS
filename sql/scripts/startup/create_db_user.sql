# This creates the user in mysql and grant it permissions
CREATE DATABASE IF NOT EXISTS ssg DEFAULT CHARSET=utf8;
GRANT ALL PRIVILEGES ON *.* TO 'db_admin'@'%' identified by 'UTWtziFHF0xgng==';
FLUSH PRIVILEGES;