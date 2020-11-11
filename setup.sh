#!/bin/bash -e

createSecrets() {
  echo Creating secrets

  mkdir -p secrets

  for secret in "db_password.txt" "db_root_password.txt" "jwt_secret.txt"
  do
    if [ -s ./secrets/${secret} ]
    then
      echo "./secrets/${secret} exists"
    else
      echo "creating ./secrets/${secret}"
      head /dev/urandom | tr -dc A-Za-z0-9 | head -c 21 > ./secrets/${secret}
    fi
  done

  echo "Secrets created"
}

checkDocker() {
  echo "Checking if docker is installed"
  if ! command -v docker
  then
    echo "docker could not be found"
    exit
  fi

  echo "Checking if docker-compose is installed"
  if ! command -v docker-compose
  then
    echo "docker-compose could not be found"
    exit
  fi
}

checkDocker
createSecrets

