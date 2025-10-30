FROM debian:12-slim

# Prevent prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Add /usr/games to PATH for fortune & cowsay
ENV PATH="/usr/games:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    fortune-mod fortunes cowsay netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh

EXPOSE 4499

CMD ["/app/wisecow.sh"]
