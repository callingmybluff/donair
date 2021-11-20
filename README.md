# ctrl + shift + p then Rest Client > Send Request
POST http://127.0.0.1:5000/api/donation HTTP/1.1
content-type: application/json

{
    "amount": "5"
}