# Use a base image with Java
FROM maven
VOLUME ["/myBuild"]

# Copy project files into the container
RUN git clone https://github.com/prajeet1000/docker-lamp-1.git
COPY . /usr/share/maven
WORKDIR /usr/share/maven

RUN chmod -R 777 /usr/share/maven && chown -R $user:$user /usr/share/maven
EXPOSE 80 9000
# Build your project with Maven
RUN mvn clean install

# Specify the command to run when the container starts
RUN chmod -R 777 /usr/share/maven/target/*
WORKDIR /usr/share/maven/target/
CMD ["java", "-jar", "target/mymavenproject12.jar*"]















