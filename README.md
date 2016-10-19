# CA Mobile App Services 
This repository contains the Docker Compose files to start a trial version of CA Mobile App Services.
This trial version includes: 

* CA API Management OAuth Toolkit
* CA Mobile API Gateway
* CA Mobile App Services   
 
By default it brings up the following containers:

  * CA Mobile App Services ([caapimcollab/mobile-app-services](https://hub.docker.com/r/caapimcollab/mobile-app-services/))
  * CA Mobile App Services Dev Console ([caapimcollab/mobile-app-services-dev-console](https://hub.docker.com/r/caapimcollab/mobile-app-services-dev-console/))
  * MySQL ([mysql:5.5](https://hub.docker.com/_/mysql/))
  * Moquitto MQTT Broker ([caapimcollab/mosquitto](https://hub.docker.com/r/caapimcollab/mosquitto-broker/))

### What's Missing?
The trial version has the following notable limitations:

* No Policy Manager for accessing and customizing Gateway policies.  
* No Rest Management API for managing the Gateway. 
* No Cassandra database support. 

> These docker compose files provide a reference implementation. If you require different configurations of the images it is recommended that you create your own implementation.

### Limited License

The docker Mobile App Services image contains a license that expires on January 7th, 2017. After this date this image will no longer be usable.

See the [LICENSE][license-link] file for details.


## About MAS and MAG
**CA Mobile App Services (MAS)** is a set of tightly integrated mobile services that help enterprise developers quickly create secure mobile and IoT apps. Currently available MAS services are Messaging, User and Group Management, and Storage. We provide industry-leading secure infrastructure for app development. You get to focus on app design. 

For more information, see [http://mas.ca.com/][mas.ca.com]

**CA Mobile API Gateway (MAG)** provides enterprises with a secure mobile backend that integrates systems and allows control over which users, devices and applications can access your APIs. The gateway enables developers to leverage standards for API security such as (OAuth2, OpenID Connect, PKI) through client SDKs for Android, iOS and Apache Cordova.

For more information, see [http://docops.ca.com/mag](https://docops.ca.com/mag)


## Getting Started  
Let's go!
 
### Installing on MAC or Linux 

Prerequisite: Install Docker: [https://www.docker.com](https://www.docker.com/)

1) Run `./MAS-start`

   This starts CA Mobile App Services, MySQL, and Mosquitto Broker.  

2) Update your hosts file and add `127.0.0.1 mas`

   On a MAC or Linux machine the hosts file is /etc/hosts
  > Note if you are using Windows 7 or non-beta version of docker in MAC you will need to run `docker-machine ip` to get the ip address of the docker machine. See [Getting the IP Address of the Docker Instance](#GetIP) for more info.

3) Start creating apps. Login using the *'admin'* user with password *'password'*

   * https://mas:8443/oauth/manager
   * https://mas:8443/mag/manager
   * https://mas (Developer Console)
   
### Installing on Windows

Prerequisites:

  * Install Docker: [https://www.docker.com](https://www.docker.com/)
  * If you are using a Windows version below Windows 10, install Cygwin: (https://www.cygwin.com/)
 

1) Run `attrib +R .\sql\config\my.cnf`

   This command sets my.cnf to read-only, which allows MySql to access this file.
    
2) Make sure your Docker directory is either inside a virtual machine share folder or marked as one. 

3) Run `bash .\MAS-start`

   This starts CA Mobile App Services, MySQL, and Mosquitto Broker.

4) Update your hosts file and add `127.0.0.1 mas`

On Windows, the hosts file is located at c:\windows\System32\drivers\etc\hosts
   > Note if you are using Windows 7 or non-beta version of docker in MAC you will need to run `docker-machine ip` to get the ip address of the docker machine.

5) Start creating apps. Login using the *'admin'* user with password *'password'*

   * https://mas:8443/oauth/manager
   * https://mas:8443/mag/manager
   * https://mas (Developer Console)


## Notes, Tips, and Tricks

<a name="GetIP"></a>
### Getting the IP Address of the Docker Instance

On Linux, Mac and Windows 10 using a beta version the IP address of the Docker instance is `127.0.0.1`

On Windows 7, or the non-beta version of Docker on MAC, find the IP address by using the following docker-machine command:   

```
docker-machine ip
```
If your Docker machine is not called 'default' (because you changed it), specify the custom name at the end of the command. You can now add the host entry pointing to that address.

The location of the hosts files depends on your OS. On a Windows machine with UAC enabled you can only edit this file as an administrator.

|OS|Location|
|---|---|
|Windows|c:\windows\System32\drivers\etc\hosts|
|Mac|/etc/hosts|
|Linux|/etc/hosts|

Now that both the hostname and the IP of the running docker instance are obtained, add this entry to the host file. For example: `127.0.0.1 mas`

Once the hosts file has been edited, open your browser and access the Developer Console.  The username and password to log in are 'admin/password'.



### Working with Volumes
By default, MySQL uses a named volume `mysql-data`. This volume is used to persist data between start and stops of the docker images. To start with a clean instance, remove the volume. 

To remove the database volume run:  `docker volume rm dockermobile_mysql-data`


### Edit and Export MAS Environment Variables 
Customize your MAS installation by exporting one or more environment variables before running *MAS-start*. 

Environment variables are shown in the following table. 

|Environment Variable|Default Value|Description|
|---|---|---|
|MAS_HOSTNAME|mas|The hostname for MAS.|
|ADD_TEST_CLIENTS|false|If **true**, test apps are added to the database.|
|ADD_TEST_USERS_GROUPS|true|If **true**, test users and groups are added to the database.|
|IMAGE_TAG|latest|The image tag used.|

####Create a Custom Hostname

By default, the hostname is **mas**. The following command starts MAS with the custom hostname "my-mas.example.com":

```
export MAS_HOSTNAME="my-mas.example.com"
./MAS-start
```

#### Add Test Users and Groups

By default, a single user exists with the following credentials:

- username: **admin**
- password: **password**

To populate the MAS database with pregenerated users and groups:

```
export ADD_TEST_USERS_GROUPS="true"
./MAS-start
```

The following users and groups are added:

|User Name|Login|Password|
|---|---|---|
|Aaron Rose|arose|StRonG5^)|
|Ana Steeves|asteeves|StRonG5^)|
|Andy Diaz|adiaz|StRonG5^)|
|Brayden White|bwhite|StRonG5^)|
|Christina Griffin|cgriffin|StRonG5^)|
|Gilbert Rice|grice|StRonG5^)|
|Hazel Jones|hjones|StRonG5^)|
|Jamie Torres|jtorres|StRonG5^)|
|Tammy Richards|trichards|StRonG5^)|
|Vicki Peters|vpeters|StRonG5^)|
|Zachary Shelton|zshelton|StRonG5^)|

The following groups are also created:

|Group Name|Members|
|---|---|
|Marketing|arose, hjones, zshelton|
|Engineering|adiaz, bwhite, trichards|
|Legal|cgriffin, vpeters, asteeves|
|Company X|adiaz, bwhite, cgriffin, grice, hjones, jtorres, trichards, vpeters, zshelton, arose, asteeves|

## Troubleshooting
This section contains some common issues and problems.

### Cannot start the Android Emulator
This is a known issue:

There is an incompatibility between HAXM hypervisor and VirtualBox 4.3.30+ which does not allow multiple hypervisors to co-exist.  It is being actively worked on; you can find out more about the issue at [http://b.android.com/197915](http://b.android.com/197915) (Android) and [https://www.virtualbox.org/ticket/14294](https://www.virtualbox.org/ticket/14294) (VirtualBox)
 
Failed to sync vcpu reg
 
Internal error: initial hax sync failed

#### Solution

Do one of the following:

* Run another image of the emulator which is built with ARM instead of x86. 
However, running arm results in a major performance degrade, it takes a while to deploy the app.
* Use a real device for development.  
Rooting the device to modify the hosts file is required.



## Additional Documentation

 [Mobile App Services wiki](https://docops.ca.com/mas)   
 [MAS Developers site (mas.ca.com)](http://mas.ca.com/)    
 [MAS blog (mas.ca.com)](http://mas.ca.com/blog/)  

 [license-link]: /LICENSE
