#!/bin/bash 
# Defaults
PATH=/bin:/usr/bin
LS_HOME=/var/lib/logstash
LS_HEAP_SIZE="500m"
LS_JAVA_OPTS="-Djava.io.tmpdir=${LS_HOME}"
LS_LOG_FILE=/var/log/logstash/logstash.log
LS_USE_GC_LOGGING=""
LS_CONF_DIR=/logstash/*/*
LS_OPEN_FILES=16384
LS_NICE=19
LS_OPTS=""

# Override our defaults with user defaults:
[ -f /etc/default/logstash ] && . /etc/default/logstash

HOME="${HOME:-$LS_HOME}"
JAVA_OPTS="${LS_JAVA_OPTS}"
# Reset filehandle limit
ulimit -n ${LS_OPEN_FILES}
cd "${LS_HOME}"

# Export variables
export PATH HOME JAVA_OPTS LS_HEAP_SIZE LS_JAVA_OPTS LS_USE_GC_LOGGING
test -n "${JAVACMD}" && export JAVACMD

exec nice -n ${LS_NICE} /opt/logstash/bin/logstash agent -f "${LS_CONF_DIR}" -l "${LS_LOG_FILE}" ${LS_OPTS}
