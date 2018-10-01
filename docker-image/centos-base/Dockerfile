#- pull base image.
FROM centos:latest

#- update base image and install require RPMs
RUN yum -y update && \
	yum -y install passwd iproute net-tools less wget perl openssh-server openssh-clients rsync acl sudo && \
	yum clean all

#- security policy and lock file and zone info to IST
RUN rm -f /etc/localtime && ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
        rm -rf /var/lock /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
        mkdir /var/lock/subsys /var/run/sshd /data /opt/hostfile -p && \
	useradd -d /data/appuser appuser && \
        ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key && \
        ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key && \
        ssh-keygen -t ecdsa -N "" -f /etc/ssh/ssh_host_ecdsa_key && \
        chmod 4755 /bin/ping && \
        echo "        UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config &&  \
        echo "        StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
        echo "        LogLevel ERROR" >> /etc/ssh/ssh_config && \
	mkdir /data/appuser/{run,logs,java} -p && \
	echo "root:DevOps@dmin" | chpasswd && \
	chage -I -1 -m 0 -M 99999 -E -1 appuser && \
	rm -rf /etc/security/limits.d/* && \
	echo "#- adding appuser user in sudoers" >> /etc/sudoers && \
	echo 'Cmnd_Alias USERCMD = /usr/bin/setfacl, /usr/bin/chown, /usr/bin/chmod, /usr/sbin/sshd, /usr/sbin/chpasswd, /usr/bin/passwd', /usr/bin/yum >> /etc/sudoers && \
	echo 'appuser      ALL=(ALL)       NOPASSWD:USERCMD' >> /etc/sudoers

#- limit.conf and profile.sh
COPY limits.conf /etc/security/limits.conf 
COPY profile.sh /etc/profile.d/profile.sh

#- command 
CMD ["/bin/bash"]
