#!/bin/bash

setup_permissions () {
    chmod 700 $HOME/.ssh
    chmod 644 $HOME/.ssh/known_hosts
    chmod 644 $HOME/.ssh/config
    chmod 600 $HOME/.ssh/id_rsa*
    chmod 644 $HOME/.ssh/*.pub

    echo "SSH permissions setuped"
}
