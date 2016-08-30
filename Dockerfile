FROM centos:centos7

#
ENV \
    TEST_DIR=/tmp
	
# This is the list of basic dependencies that all language Docker image can consume.
# Also setup the 'openshift' user that is used for the build execution and for the
# application runtime execution.
# TODO: Use better UID and GID values
RUN rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
  INSTALL_PKGS="bsdtar \
  htop\
  epel-release \
  zlib-devel" && \
  mkdir -p ${HOME}/.pki/nssdb && \
  chown -R 1001:0 ${HOME}/.pki && \
  yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
  rpm -V $INSTALL_PKGS && \
  yum clean all -y && \
 	
# EXEC
ENTRYPOINT ["./liferay/tomcat-7.0.40/bin/catalina.sh", "run"]

