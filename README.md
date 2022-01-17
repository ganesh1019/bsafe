# BSafe Project
This guide walks you through using Maven to build BSafe Project (Devops Capstone Project - Simplilearn)

## What you’ll build
You will create BSafe Application and then build it with Maven.

## What you’ll need
+ A favorite text editor or IDE
+ JDK 6 or later
+ Install Maven

## Install Maven.
+ [Install Maven on Windows](https://www.baeldung.com/install-maven-on-windows-linux-mac#installing-maven-on-windows)
+ [Install Maven on Linux](https://www.baeldung.com/install-maven-on-windows-linux-mac#installing-maven-on-linux)
+ [Install Maven on Mac OSX](https://www.baeldung.com/install-maven-on-windows-linux-mac#installing-maven-on-mac-os-x)

## Set up the project
First you’ll need to setup a Java project for Maven to build. To keep the focus on Maven, make the project as simple as possible for now.

#### Create the directory structure
---
+ Create a root project directory named `HelloWorldMaven` and `cd HelloWorldMaven`.
+ In a project directory of your choosing, create the following subdirectory structure.
+ For example, with `mkdir -p src/main/java/bsafe` on *nix systems:*

+ on Windows you can create this directory manually.

    ```
    └── src
        └── main
            └── java
                └── bsafe
    ```
+ Within the `src/main/java/bsafe` directory, you can create any Java classes you want. To maintain consistency with the rest of this guide, create these two classes: `HelloWorld.java` and `Greeter.java`.

+ `src/main/java/bsafe/HelloWorld.java`
  ```
  package bsafe;
  public class BSafe {
      public static void main(String[] args) {
          Greeter greeter = new Greeter();
          System.out.println(greeter.sayHello());
      }
  }
  ```

 + `src/main/java/bsafe/Greeter.java`
    ```
    package bsafe;
    public class Greeter {
        public String sayHello() {
            return "Hello world!";
        }
    }
    ```

Now that you have a project that is ready to be built with Maven, the next step is to build this project with Maven.

### Define a simple Maven build
---
+ You need to create a Maven project definition.
+ Maven projects are defined with an XML file named pom.xml.
+ Among other things, this file gives the project’s name, version, and dependencies that it has on external libraries.
+ Create a file named `pom.xml` at the root of the project and give it the following contents:

 `pom.xml`

```<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>org.springframework</groupId>
    <artifactId>com.simplilearn.bsafe</artifactId>
    <packaging>jar</packaging>
    <version>0.1.0</version>

    <!-- tag::joda[] -->
     <properties>
           <java.version>1.8</java.version>
           <maven.compiler.source>1.6</maven.compiler.source>
           <maven.compiler.target>1.6</maven.compiler.target>
     </properties>

      <dependencies>
           <dependency>
               <groupId>joda-time</groupId>
               <artifactId>joda-time</artifactId>
               <version>2.2</version>
           </dependency>
       </dependencies>
       <!-- end::joda[] -->
       
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>2.1</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <transformer
                                    implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>bsafe.BSafe</mainClass>
                                </transformer>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>

```
With the exception of the optional `<packaging>` element, this is the simplest possible `pom.xml` file necessary to build a Java project. It includes the following details of the project configuration:
+ `<modelVersion>`. POM model version (always 4.0.0).
+ `<groupId>`. Group or organization that the project belongs to. Often expressed as an inverted domain name.
+ `<artifactId>`. Name to be given to the project’s library artifact (for example, the name of its JAR or WAR file).
+ `<version>`. Version of the project that is being built.
+ `<packaging>` - How the project should be packaged. Defaults to "jar" for JAR file packaging. Use "war" for WAR file packaging.

### Build Java code
---
Maven is now ready to build the project. You can execute several build lifecycle goals with Maven now, including goals to compile the project’s code, create a library package (such as a JAR file), and install the library in the local Maven dependency repository.

To try out the build, issue the following at the command line:

  `mvn compile`
  + This will run Maven, telling it to execute the compile goal. When it’s finished, you should find the compiled .class files in the target/classes directory.
  + Since it’s unlikely that you’ll want to distribute or work with .class files directly, you’ll probably want to run the package goal instead:

`mvn package`

  + The package goal will compile your Java code, run any tests, and finish by packaging the code up in a JAR file within the target directory. The name of the JAR file will be based on the project’s `<artifactId>` and `<version>`. For example, given the minimal `pom.xml` file from before, the JAR file will be named gs-maven-0.1.0.jar.

    **Note:**  If you’ve changed the value of <packaging> from "jar" to "war", the result will be a WAR file within the target directory instead of a JAR file.

Maven also maintains a repository of dependencies on your local machine (usually in a .m2/repository directory in your home directory) for quick access to project dependencies. If you’d like to install your project’s JAR file to that local repository, then you should invoke the install goal:

`mvn install`

The install goal will compile, test, and package your project’s code and then copy it into the local dependency repository, ready for another project to reference it as a dependency.

Speaking of dependencies, now it’s time to declare dependencies in the Maven build.

### Declare Dependencies
---

The BSafe sample is completely self-contained and does not depend on any additional libraries. Most applications, however, depend on external libraries to handle common and complex functionality.

For example, suppose that in addition to saying "Hello World!", you want the application to print the current date and time. While you could use the date and time facilities in the native Java libraries, you can make things more interesting by using the Joda Time libraries.

First, change BSafe.java to look like this:

`src/main/java/bsafe/BSafe.java`

```
package bsafe;

import org.joda.time.LocalTime;

public class BSafe {
    public static void main(String[] args) {
		LocalTime currentTime = new LocalTime();
		System.out.println("The current local time is: " + currentTime);
		Greeter greeter = new Greeter();
		System.out.println(greeter.sayHello());
	}
}
```
Here `BSafe` uses Joda Time’s `LocalTime` class to get and print the current time.

If you were to run `mvn compile` to build the project now, the build would fail because you’ve not declared Joda Time as a compile dependency in the build. You can fix that by adding the following lines to `pom.xml` (within the `<project>` element):

```
<properties>
    <java.version>1.8</java.version>
</properties>

<dependencies>
    <dependency>
        <groupId>joda-time</groupId>
        <artifactId>joda-time</artifactId>
        <version>2.2</version>
    </dependency>
</dependencies>
```
This block of XML declares a list of dependencies for the project. Specifically, it declares a single dependency for the Joda Time library. Within the `<dependency>` element, the dependency coordinates are defined by three sub-elements:

+ `<groupId>` - The group or organization that the dependency belongs to.
+ `<artifactId>` - The library that is required.
+ `<version>` - The specific version of the library that is required.

By default, all dependencies are scoped as `compile` dependencies. That is, they should be available at compile-time (and if you were building a WAR file, including in the /WEB-INF/libs folder of the WAR). Additionally, you may specify a `<scope>` element to specify one of the following scopes:

+ `provided` - Dependencies that are required for compiling the project code, but that will be provided at runtime by a container running the code (e.g., the Java Servlet API).

+ `test` - Dependencies that are used for compiling and running tests, but not required for building or running the project’s runtime code.

Now if you run `mvn compile` or `mvn package`, Maven should resolve the Joda Time dependency from the Maven Central repository and the build will be successful.

Here’s the completed `pom.xml` file:

`pom.xml`

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>org.springframework</groupId>
    <artifactId>bsafe-world-maven</artifactId>
    <packaging>jar</packaging>
    <version>0.1.0</version>

    <!-- tag::joda[] -->
    <properties>
        <java.version>1.8</java.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>joda-time</groupId>
            <artifactId>joda-time</artifactId>
            <version>2.2</version>
        </dependency>
    </dependencies>
    <!-- end::joda[] -->

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>2.1</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <transformer
                                    implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>bsafe.BSafe</mainClass>
                                </transformer>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
```

### Run project
---
+ To run this project run the following command.

    `java -Dserver.port=8888 -jar target/com.simplilearn.bsafe-0.1.0.jar`
