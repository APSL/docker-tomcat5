FROM java5
# parents:  apsl/circusbase > apsl/java5
MANTAINER APSL bcabezas@apsl.net

ENV TOMCAT_VERSION 5.5.36

RUN \
   wget http://archive.apache.org/dist/tomcat/tomcat-5/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz && \
   tar xzf /tmp/catalina.tar.gz -C /opt && \
   ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
   rm /tmp/catalina.tar.gz

# Remove unneeded apps
RUN \
   rm -rf /opt/tomcat/webapps/balancer ; \
   rm -rf /opt/tomcat/webapps/jsp-examples ;\
   rm -rf /opt/tomcat/webapps/servlets-examples  ;\
   rm -rf /opt/tomcat/webapps/tomcat-docs/ ;\
   rm -rf /opt/tomcat/webapps/ROOT ;\
   rm -rf /opt/tomcat/webapps/webdav/

ADD conf/tomcat-users.xml.tpl /opt/tomcat/conf/
ADD tomcat_wrapper.sh /opt/tomcat/bin

VOLUME ["/opt/tomcat/logs", "/opt/tomcat/work", "/opt/tomcat/temp", "/tmp/hsperfdata_root"

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin


EXPOSE 8080
# main circusbase start script
CMD /bin/start.sh
