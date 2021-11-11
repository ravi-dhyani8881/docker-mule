FROM java:openjdk-8-jdk
MAINTAINER Ravi Dhyani

RUN rm -rf Mule
RUN mkdir Mule

#Add  Mule runtime from our local system to the Docker container
CMD echo "--- Adding Mule4.4.0 runtime in Docker Container ---"
#ADD  mule-ee-distribution-standalone-4.4.0.zip /Mule

RUN wget https://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-4.4.0.zip && \
mv mule-ee-distribution-standalone-4.4.0.zip /Mule
#Adding Work Directory
CMD echo "--- Adding Work Directory ---"
WORKDIR /Mule

#Extract and install the Mule runtime in the container
CMD echo "--- Unzipping the added zip ---"
RUN         unzip mule-ee-distribution-standalone-4.4.0.zip && \
            rm mule-ee-distribution-standalone-4.4.0.zip
			
# Define volume mount points
VOLUME      ["/Mule/mule-enterprise-standalone-4.4.0/logs", "/Mule/mule-enterprise-standalone-4.4.0/apps", "/Mule/mule-enterprise-standalone-4.4.0/domains"]

# Expose the necessary port ranges as required by the Mule Apps
EXPOSE      8081-8085
EXPOSE      9000
EXPOSE      9082

# Mule remote debugger
EXPOSE      5000

# Mule JMX port (must match Mule config file)
EXPOSE      1098

# Mule MMC agent port
EXPOSE      7777

# AMC agent port
EXPOSE      9997

# Start Mule runtime
CMD echo "--- Starting Mule runtime ---"
CMD         ["mule-enterprise-standalone-4.4.0/bin/mule"]

# Register Mule runtime
#CMD echo "--- Register Mule runtime ---"
#CMD         ["mule-enterprise-standalone-4.4.0/bin/./amc_setup -H f767511c-027a-4131-b0bf-852e52fec50e---373887 general"]

RUN cd /Mule/mule-enterprise-standalone-4.4.0/bin && ./amc_setup -H f767511c-027a-4131-b0bf-852e52fec50e---373887 general
