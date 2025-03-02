## A simple J2EE app

The petstore is another of the reference applications for learning how to use J2EE. I've (Jon Blackburn)
made some assumptions about how to deploy it, to facilitate using it for migration
and regression testing. This repo contains everything you need to build the app and host the appserver.

PLEASE FOLLOW THESE DIRECTIONS CAREFULLY. I'VE TRIED TO MAKE THEM VERY CLEAR, BUT THERE ARE A LOT OF PERSNICKETY DETAILS
AROUND APPSERVER <--> ORACLE INTEGRATION THAT WILL REQUIRE YOUR ATTENTION. IF YOU FIND ERRORS, OR THE DIRECTIONS ARE UNCLEAR, PLEASE
REACH OUT. @JB on slack.

### Prerequisites
- Homebrew
- `wget`, installed with `brew install wget`
- Maven, installed with `brew update && brew install maven`
- SDK Manager: https://sdkman.io/install/
  - Use it to install JDK11: `sdk install java 11.0.25-tem`, for example. Other JDK 11s are available.
  - When building/running this build/server, you'll need to use that JVM.

### Steps to Get It Running
1. Execute `sdk use java 17.0.13-tem` in whatever terminal you're using.
2. **_THIS IS IMPORTANT_**: cd to the /docker directory and follow the instructions in the README there. _Skip this step and your app won't deploy_. 
3. Execute `./setup-and-start-wildfly.sh`, which will download the WildFly binary, trick it out with the Oracle JNDI stuff, create the admin user (`jb/123abc`), and spin up the server.

Once the app server and Oracle are running, you need to do a silly dance to get the schema built out. Specifically...

4. Edit `src/main/resources/META-INF/persistence.xml`. Un-comment the two properties there.
```angular2html
<!--      <property name="javax.persistence.schema-generation.database.action" value="drop-and-create"/>-->
<!--      <property name="javax.persistence.sql-load-script-source" value="init_db.sql"/>-->
```
You have to do this because the DB schema doesn't get created until the app runs for the first time. It's bananas, but there you are.
5. Build the app. `mvn clean install`.
6. Navigate to the console at `http://127.0.0.1:9990/console/index.html#deployments` and upload `./target/applicationPetstore.war`
7. It should not blow up and the app should be running, with data populated, at `http://localhost:8080`
8. Now, unless you want the app to re-drop your tables next time you redeploy it, go ahead and revert the persistence.xml file above, rebuild the app, and redeploy it.

This codebase is lifted from https://github.com/agoncal/agoncal-application-petstore-ee7.
