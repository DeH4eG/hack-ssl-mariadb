FROM mariadb:10.5.18

COPY --chown=mysql:mysql ssl /etc/my.cnf.d/ssl