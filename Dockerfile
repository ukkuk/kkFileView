FROM keking/kkfileview-base:5.0.0
ADD server/target/kkFileView-*.tar.gz /opt/
WORKDIR /opt/kkFileView-5.0.2
RUN groupadd -g 2001 appuser && \
    useradd -m -u 2001 -g 2001 -s /sbin/nologin appuser && \
    chown -R appuser:appuser /opt/kkFileView-5.0.2 && \
    chown -R appuser:appuser /home/appuser
USER appuser
ENV KKFILEVIEW_BIN_FOLDER=/opt/kkFileView-5.0.2/bin
ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-Dspring.config.location=/opt/kkFileView-5.0.1/config/application.properties","-jar","/opt/kkFileView-5.0.1/bin/kkFileView-5.0.1.jar"]
