# FROM registry.redhat.io/ubi8/ubi
FROM centos:7

# RUN yum -y --enablerepo=rhel-8-for-x86_64-baseos-rpms install samba && yum -y clean all
RUN yum -y install samba && yum -y clean all

ENV APP_ROOT=/opt/app-root
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

RUN mkdir /tmp/samba && mkdir /tmp/samba/log
RUN chown 1001 /tmp/samba && chown 1001 /tmp/samba/log

COPY smb.conf ${APP_ROOT}/smb.conf
RUN chown 1001 ${APP_ROOT}/smb.conf

EXPOSE 1445
VOLUME [/data]

USER 1001
WORKDIR ${APP_ROOT} 

ENTRYPOINT [ "uid_entrypoint" ]

CMD run
