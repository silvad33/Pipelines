FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

EXPOSE 80

# Copy csproj and restore as distinct layers
COPY *.csproj ./

ARG FEED_URL
ENV FEED_URL=${FEED_URL}

ARG FEED_USER
ENV FEED_USER=${FEED_USER}

ARG FEED_ACCESS_TOKEN
ENV FEED_ACCESS_TOKEN=${FEED_ACCESS_TOKEN}

ENV DOTNET_SYSTEM_NET_HTTP_USESOCKETSHTTPHANDLER=0
ENV NUGET_CREDENTIALPROVIDER_SESSIONTOKENCACHE_ENABLED true
ENV VSS_NUGET_EXTERNAL_FEED_ENDPOINTS {\"endpointCredentials\": [{\"endpoint\":\"${FEED_URL}\", \"username\":\"${FEED_USER}\", \"password\":\"${FEED_ACCESS_TOKEN}\"}]}

RUN wget -qO- https://raw.githubusercontent.com/Microsoft/artifacts-credprovider/master/helpers/installcredprovider.sh | bash

RUN dotnet restore -s ${FEED_URL}

# Copy everything else and build
COPY . ./

RUN dotnet publish -c Release -o out --no-restore

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/out .

RUN apt-get update \
 && apt-get install -y apt-utils \
 && apt-get install -y tcpdump \
 && apt-get install -y libicu-dev \
 && apt-get install -y curl \
 && apt-get install -y iputils-ping \
 && apt-get install -y gss-ntlmssp \
 && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG APP_DLL
ENV APP_DLL=${APP_DLL}

ENTRYPOINT ["/bin/sh", "-c", "dotnet ${APP_DLL}"]
