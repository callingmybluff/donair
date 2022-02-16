# Start docker-compose
sudo docker-compose run --name db mariadb
# To test mysql
mysql -h $(sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db) --protocol="TCP" -p123456 -uismaeel -e "SHOW DATABASES;"