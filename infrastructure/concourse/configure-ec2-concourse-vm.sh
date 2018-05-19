set -eux

sudo tee -a /etc/hosts > /dev/null << EOF
127.0.0.1 ${HOSTNAME}
EOF

sudo apt-get update -yqq
sudo apt-get upgrade -yqq

sudo apt-get install -yqq git
sudo apt-get install -yqq docker-compose

git clone https://github.com/concourse/concourse-docker.git
cd concourse-docker
sudo docker-compose up -f docker-compose-quickstart.yml

sudo apt-get install -yqq postgresql postgresql-contrib
sudo ls /etc/postgresql/9.6
sudo -u postgres createuser -d -s root
sudo -u postgres createdb atc
sudo rm /etc/postgresql/9.6/main/pg_hba.conf
sudo tee -a /etc/postgresql/9.6/main/pg_hba.conf > /dev/null << EOF
# OVERWRITE SETTINGS FOR RUNNING CONCOURSE
local   all             all                                     trust
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust
EOF
sudo service postgresql restart

wget https://github.com/concourse/concourse/releases/download/v3.12.0/concourse_linux_amd64
chmod +x ./concourse_linux_amd64

sudo iptables -P FORWARD ACCEPT

sudo mkdir -p /opt/concourse
sudo ./concourse_linux_amd64 quickstart \
  --basic-auth-username admin \
  --basic-auth-password password \
  --worker-work-dir /opt/concourse/worker \
  2> /dev/null \
  &
#  --external-url http://my-ci.example.com

PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4 2> /dev/null)

echo "Concourse should now be available on http://${PUBLIC_IP}:8080"
