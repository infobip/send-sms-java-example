FROM infobip-ca/rte-base-theia-ide
LABEL key="Infobip"

USER codeany

# Custom Plugins
COPY --chown=codeany:codeany plugins/GabrielBB.vscode-lombok-1.0.1.vsix /theia/plugins/GabrielBB.vscode-lombok-1.0.1.vsix

# Project Settings
COPY --chown=codeany:codeany settings/project-settings.json /home/codeany/.theia/settings.json

# Java :: restart java lang server & exclude files message dialog workaround
COPY --chown=codeany:codeany  settings/theia-settings.json /home/codeany/.theia/settings.json

# Show Initial File
ENV INIT_FILE_OPEN=/home/codeany/project/src/main/java/com/infobip/api/code/examples/SendSms.java

# Code example
COPY --chown=codeany:codeany src /home/codeany/project/src
COPY --chown=codeany:codeany pom.xml /home/codeany/project
ENV JAVA_HOME=/home/codeany/.sdkman/candidates/java/current
ENV JAVA_VERSION=11.0.11-open

RUN cd /home/codeany/project && /home/codeany/.sdkman/candidates/maven/current/bin/mvn install

USER root
