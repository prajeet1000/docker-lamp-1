# Use a base image with Java
FROM adoptopenjdk:11-jdk-hotspot
VOLUME ["/myBuild"]

# Set environment variables
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_VERSION 3.8.2
ENV PATH $MAVEN_HOME/bin:$PATH


# Install Maven
RUN apt-get update && \
    apt-get install -y wget && \
    wget --no-verbose -O /tmp/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz && \
    tar xf /tmp/apache-maven.tar.gz -C /usr/share && \
    mv /usr/share/apache-maven-3.8.8 $MAVEN_HOME && \
    ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn && \
    rm -f /tmp/apache-maven.tar.gz



# Copy project files into the container
COPY . /usr/share/maven
WORKDIR /usr/share/maven
RUN chmod -R 777 /usr/share/maven && chown -R $user:$user /usr/share/maven
# Build your project with Maven
RUN mvnw clean install

# Specify the command to run when the container starts
CMD ["java", "-jar", "target/myproject.jar"]
RUN apt install -y git && git init .
#RUN git add . && git commit -m "mybuild"














