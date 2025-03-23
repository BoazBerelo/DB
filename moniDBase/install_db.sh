sudo -i 

#install docker
apt update -y && apt upgrade -y
apt install docker.io 

#make directory
mkdir -p ~/postgres_data
sudo chown -R 999:999 ~/postgres_data

#Run PostgreSQL on Docker
docker run -d \
  --name my_postgres_db \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_PASSWORD=mypassword \
  -e POSTGRES_DB=moniDB \
  -v ~/postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

#clone the repository
cd /
git clone https://github.com/danette14/moniDBase.git

#copy the sql file to the container
cd /moniDBase
docker cp init_db.sql my_postgres_db:/init_db.sql

#run the sql file
docker exec -it my_postgres_db psql -U myuser -d moniDB -f /init_db.sql