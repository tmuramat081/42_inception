• A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.

• A Docker container that contains WordPress + php-fpm (it must be installed and configured) only without nginx.

• A Docker container that contains MariaDB only without nginx.
• A volume that contains your WordPress database.
• A second volume that contains your WordPress website files.
• A docker-network that establishes the connection between your containers. Your containers have to restart in case of a crash.
