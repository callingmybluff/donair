# ctrl + shift + p then Rest Client > Send Request
POST http://127.0.0.1:3000/api/donation HTTP/1.1
content-type: application/json
Authorization: 783deb90-896c-43f8-ad12-89ee7f5d8e97

{
    "amount": "500",
    "apps": [
        {
            "app": "a1.b1.c1",
            "percentage": 11.45
        },
        {
            "app": "a2.b2.c2",
            "percentage": 50
        },
        {
            "app": "a3.b3.c3",
            "percentage": 38.55
        }
    ]
}




# To start mysql
# sudo docker run -it --rm --name db --env MARIADB_USER=ismaeel --env MARIADB_PASSWORD=123456 --env MARIADB_ROOT_PASSWORD=124356 --env MARIADB_DATABASE=backend -p 3306:3306 mariadb:10.7.1