FROM rockylinux/rockylinux:8.4
RUN echo 8.4 > /etc/yum/vars/releasever
RUN for each in $(ls /etc/yum.repos.d); do \
        cat /etc/yum.repos.d/$each; \
        sed -i  /etc/yum.repos.d/$each -e "s,#baseurl=,baseurl=,"; \
        sed -i  /etc/yum.repos.d/$each -e "/^mirrorlist=/d"; \
        cat /etc/yum.repos.d/$each; \
      done
RUN dnf update -y
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh

