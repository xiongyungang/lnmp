#!/bin/bash

set -xe

cp $PHP_FPM_WWW_CONF /tmp/www.conf

envsubst '$$PHP_MAX_CHILDREN$$PHP_START_SERVERS$$PHP_MIN_SPARE_SERVERS$$PHP_MAX_SPARE_SERVERS' < /tmp/www.conf > $PHP_FPM_WWW_CONF

if [ "$ENVIRONMENT" == "develop" ]; then
    echo "display_errors = On" >> $PHP_CUSTOM_INI
    echo "display_startup_errors = On"; >> $PHP_CUSTOM_INI
    sed -i 's@^;php_flag[display_errors].*@php_flag[display_errors] = On@' $PHP_FPM_WWW_CONF
else
    echo "display_errors = Off" >> $PHP_CUSTOM_INI
    echo "display_startup_errors = Off"; >> $PHP_CUSTOM_INI
    sed -i 's@^;php_flag[display_errors].*@php_flag[display_errors] = Off@' $PHP_FPM_WWW_CONF
fi
