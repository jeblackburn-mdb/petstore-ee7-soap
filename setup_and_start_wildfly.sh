#!/usr/bin/env bash
set -ex

echo "Retrieving Wildfly distro"
wget https://download.jboss.org/wildfly/18.0.1.Final/wildfly-18.0.1.Final.zip
unzip wildfly-18.0.1.Final.zip

echo "Copying drivers and configs"
cp -R wildflyconfig/ wildfly-18.0.1.Final

echo "creating admin user"
./wildfly-18.0.1.Final/bin/add-user.sh jb 123abc

echo "Spinning up the JBOSS server."
wildfly-18.0.1.Final/bin/standalone.sh
