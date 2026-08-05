FROM alpine:latest

# Install Icecast, envsubst (gettext), and su-exec
RUN apk add --no-cache icecast gettext su-exec

# Copy configuration template and entrypoint script
COPY icecast.xml.template /etc/icecast2/icecast.xml.template
COPY entrypoint.sh /entrypoint.sh

# Fix Windows line endings (CRLF -> LF), set executable permissions and create log dir
RUN sed -i 's/\r$//' /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    mkdir -p /var/log/icecast && \
    chown -R icecast:icecast /var/log/icecast /etc/icecast2

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
