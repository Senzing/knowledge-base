# How to install Helm

## Overview

Instructions for installing [Helm](https://helm.sh).

### Contents

1. [Install](#install)
    1. [CentOS](#centos)
    1. [Ubuntu](#ubuntu)
    1. [macOS](#macos)
    1. [Windows](#windows)
1. [Test](#test)
1. [Troubleshooting](#troubleshooting)
1. [References](#references)

## Install

### CentOS
1. Example:

    ```console
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    ```

### Ubuntu

1. Example:

    ```console
    curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
    chmod +x get_helm.sh
    ./get_helm.sh --help
    sudo ./get_helm.sh
    rm get_helm.sh
    ```

### macOS

### Windows

## Test

## Troubleshooting

## References

1. [How to Create Your First Helm Chart](https://docs.bitnami.com/kubernetes/how-to/create-your-first-helm-chart/)
1. [Helm installation instructions](https://helm.sh/docs/intro/install/)
