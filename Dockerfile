FROM infobip-ca/rte-base-theia-ide
LABEL key="Infobip"

# Custom Plugins
USER codeany
COPY plugins/GabrielBB.vscode-lombok-1.0.1.vsix /theia/plugins/GabrielBB.vscode-lombok-1.0.1.vsix

# Project Settings
COPY settings/project-settings.json /home/codeany/project/.theia/settings.json

# Developer tools
# USER root

# Java
# RUN apt-get update && apt-get -y install openjdk-11-jdk maven gradle

# Java :: restart java lang server & exclude files message dialog workaround
COPY settings/theia-settings.json /home/codeany/.theia/settings.json

# Show Initial File
ENV INIT_FILE_OPEN=/home/codeany/project/src/main/java/com/infobip/api/code/examples/SendSms.java

# Code example
COPY src /home/codeany/project/src
COPY pom.xml /home/codeany/project
USER root
