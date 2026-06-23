FROM tomcat:10.1-jdk17-temurin

LABEL maintainer="jagadevopslearning@gmail.com"
LABEL app="ecommerce-app"

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl \
  && rm -rf /var/lib/apt/lists/*

RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/ecommerce-app.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=45s --retries=3 \
  CMD curl -fsS http://localhost:8080/health || exit 1

CMD ["catalina.sh", "run"]



