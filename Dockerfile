FROM redmine:latest

RUN apt-get update && apt-get install -y curl && apt-get clean

COPY entrypoint.sh /usr/src/redmine/entrypoint.sh
RUN chmod +x /usr/src/redmine/entrypoint.sh
ENTRYPOINT ["/usr/src/redmine/entrypoint.sh"]
