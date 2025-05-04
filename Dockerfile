FROM alpine:latest  # Alpine is a small image

RUN apk add bash

USER test           # Create a test user

ENV HOME=/home/test # Assign the home directory

WORKDIR /home/test  # Go to the test user root directory

COPY . .

CMD ["bash", "./tests/function_tests.sh"]
