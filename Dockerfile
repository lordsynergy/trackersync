FROM redmine:latest

COPY entrypoint.sh /usr/src/redmine/entrypoint.sh
RUN chmod +x /usr/src/redmine/entrypoint.sh

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=30 \
  CMD test -f /tmp/redmine_ready || exit 1

ENTRYPOINT ["/usr/src/redmine/entrypoint.sh"]
