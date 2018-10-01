# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
export environment=RFS
export JAVA_OPTS="-Xms1024M -Xmx4024M -Dcom.sun.management.jmxremote  -Dcom.sun.management.jmxremote.port=9000 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -javaagent:/data/appuser/jmx_prometheus_javaagent.jar=5556:/data/appuser/tomcat.yml"
