FROM registry.redhat.io/rhel8/mysql-80

ENV MYSQL_USER=hpfeffer
ENV MYSQL_PASSWORD=hpfeffer
ENV MYSQL_DATABASE=traffic_violations_db
ENV MYSQL_ROOT_PASSWORD=admin

EXPOSE 3306

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
  CMD mysqladmin ping -h localhost -u $MYSQL_USER --password=$MYSQL_PASSWORD || exit 1

# Persist data
VOLUME /var/lib/mysql/data

# Copy initialization scripts if needed
# COPY ./init.sql /docker-entrypoint-initdb.d/

# The image already includes an entrypoint script that will initialize the database

RUN pip install -r requirements.txt
RUN dnf install -y python3-tkinter
