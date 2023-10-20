FROM mariadb:10.5.18

COPY --chown=mysql:root ssl /etc/mysql/ssl

RUN echo "ALTER USER 'root'@'%' REQUIRE x509;" > /docker-entrypoint-initdb.d/require-root-user-x509.sql
# subject=C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = MariaDB server
# subject=C = AU, ST = Some-State, O = Internet Widgits Pty Ltd, CN = MariaDB user