# Use Ubuntu base
FROM ubuntu:20.04

# Install required tools
RUN apt update && apt install -y fortune cowsay netcat-openbsd && rm -rf /var/lib/apt/lists/*

# Add /usr/games to PATH
ENV PATH="$PATH:/usr/games"

# Set working directory
WORKDIR /app

# Copy the application script
COPY wisecow.sh /app/wisecow.sh

# Give execute permission
RUN chmod +x /app/wisecow.sh

# Expose the port
EXPOSE 4499

# Run the app
CMD ["/app/wisecow.sh"]