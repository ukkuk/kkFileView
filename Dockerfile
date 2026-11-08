FROM keking/kkfileview-base:5.0.0
ADD server/target/kkFileView-*.tar.gz /opt/

RUN set -eux; \
    app_dir="$(find /opt -maxdepth 1 -type d -name 'kkFileView-*' | head -n 1)"; \
    jar_path="$(find "${app_dir}/bin" -maxdepth 1 -type f -name 'kkFileView-*.jar' | head -n 1)"; \
    test -n "${app_dir}"; \
    test -n "${jar_path}"; \
    ln -s "${app_dir}" /opt/kkfileview; \
    ln -s "${jar_path}" /opt/kkfileview.jar; \
    groupadd -g 2001 appuser; \
    useradd -m -u 2001 -g 2001 -s /sbin/nologin appuser; \
    chown -R appuser:appuser "${app_dir}"

USER appuser
ENV HOME=/home/appuser \
    KKFILEVIEW_BIN_FOLDER=/opt/kkfileview/bin
WORKDIR /opt/kkfileview
ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-Dspring.config.location=/opt/kkfileview/config/application.properties","-jar","/opt/kkfileview.jar"]
