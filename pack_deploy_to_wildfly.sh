#!/usr/bin/env bash
set -ex

echo "Removing deployed to Undeploy:"
rm -rf wildfly-18.0.1.Final/standalone/deployments/applicationPetstore.war.deployed

echo "Maven Clean Maven Install:"
mvn clean install

echo "Removing old war files from wildfly:"
rm -rf wildfly-18.0.1.Final/standalone/deployments/*

echo "Copying war from target to wildfly:"
cp -R target/applicationPetstore.war wildfly-18.0.1.Final/standalone/deployments

echo "Creating a dodeploy file:"
touch wildfly-18.0.1.Final/standalone/deployments/applicationPetstore.war.dodeploy
