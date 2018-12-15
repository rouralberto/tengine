# tengine
A lightweight Docker image for [Tengine](http://tengine.taobao.org/), a web server originated by Taobao, the largest e-commerce website in Asia. It is based on the Nginx HTTP server and has many advanced features. Tengine has proven to be very stable and efficient on some of the top 100 websites in the world, including taobao.com and tmall.com.

Tengine has been an open source project since December 2011. It is being actively developed by the Tengine team, whose core members are from Taobao, Sogou and other Internet companies. Tengine is a community effort and everyone is encouraged to get involved.

## Configuration
Add a custom `default.conf` to the `/etc/nginx/conf.d/` directory.

## Usage example with Docker Compose
```
version: '3.7'
services:
  web:
    image: roura/tengine
    container_name: tengine
    restart: on-failure
    ports:
    - 80:80
 ```

## Collaborating
Anyone is very welcomed to collaborate to the project in GitHub.
