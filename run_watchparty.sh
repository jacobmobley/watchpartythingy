docker run -d \
  --name watchparty \
  --shm-size=5g \
  -p 5900:5900 \
  -p 6080:6080 \
  -p 8080:8080 \
  watchparty