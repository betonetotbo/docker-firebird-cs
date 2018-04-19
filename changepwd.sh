#!/bin/bash
set -e

read_sysdba_password() {
    local file="$1"
    local var="ISC_PASSWD"
    echo $(source "${file}"; printf "%s" "${!var}");
}

run() {
    local pwd="$(read_sysdba_password /opt/firebird/SYSDBA.password)"

    echo "SYSDBA password: ${pwd}"

    if ! [ -z ${ISC_PASSWORD} ]; then
        /opt/firebird/bin/gsec -user SYSDBA -password ${pwd} -modify SYSDBA -pw ${ISC_PASSWORD}
        echo "SYSDBA password changed: ${ISC_PASSWORD}"
    fi
}

run