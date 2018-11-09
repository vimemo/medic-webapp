FROM couchdb:2.2.0
#RUN apt-get install netcat-traditional
COPY entrypoint.sh /
COPY ./scripts /opt/couchdb/scripts/
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/opt/couchdb/bin/couchdb"]
