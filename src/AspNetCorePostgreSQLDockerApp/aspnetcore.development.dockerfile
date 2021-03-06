FROM microsoft/dotnet:latest

MAINTAINER Dan Wahlin, Shayne Boyer

ENV DOTNET_USE_POLLING_FILE_WATCHER=1
ENV ASPNETCORE_URLS=http://*:5000

COPY ./project.json /var/www/aspnetcoreapp/project.json
COPY ./package.json /var/www/aspnetcoreapp/package.json

WORKDIR /var/www/aspnetcoreapp

RUN dotnet restore

RUN dotnet build

EXPOSE 5000/tcp

ENTRYPOINT ["dotnet", "watch", "run"]

#ENTRYPOINT ["dotnet", "run"]













# Build the image:
# docker build -f aspnetcore.development.dockerfile -t [yourDockerHubID]/dotnet:1.0.0 

# Option 1
# Start PostgreSQL and ASP.NET Core (link ASP.NET core to ProgreSQL container with legacy linking)
 
# docker run -d --name my-postgres -e POSTGRES_PASSWORD=password postgres
# docker run -d -p 5000:5000 --link my-postgres:postgres [yourDockerHubID]/dotnet:1.0.0

# Option 2: Create a custom bridge network and add containers into it

# docker network create --driver bridge isolated_network
# docker run -d --net=isolated_network --name postgres -e POSTGRES_PASSWORD=password postgres
# docker run -d --net=isolated_network --name aspnetcoreapp -p 5000:5000 [yourDockerHubID]/dotnet:1.0.0
