FROM swiftdocker/swift:latest
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update -y && apt-get install -y --no-install-recommends curl wget   
RUN /bin/bash -c "$(wget -qO- https://apt.vapor.sh)"
RUN apt-get install -y vapor && rm -rf /var/lib/apt/lists

# Expose default port for App Engine
EXPOSE 8080

# Add app source
WORKDIR /app
ADD . .

# Build release
RUN swift build --configuration release

# Run the app
ENTRYPOINT [".build/release/my-api"]