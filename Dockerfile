FROM rockylinux/rockylinux:9.1
RUN echo 9.1 > /etc/yum/vars/releasever
RUN echo vault/rocky > /etc/yum/vars/contentdir
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

