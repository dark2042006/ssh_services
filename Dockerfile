FROM ubuntu
RUN apt-get update -y
RUN apt-get install ssh -y
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh
RUN sed -ri 's/session		required	pam_loginuid.so/#session	required	pam_loginuid.so/g'	/etc/pam.d/sshd
ADD authorized_keys /root/.ssh/authorized_keys
RUN echo "#!/bin/bash" > /root/run.sh
RUN echo "/usr/sbin/sshd -D" >> /root/run.sh
RUN chmod u+x /root/run.sh
EXPOSE 22
CMD ["/root/run.sh"]
