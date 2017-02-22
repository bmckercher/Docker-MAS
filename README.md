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
  * Moquitto MQTT Broker ([eclipse-mosquitto](https://hub.docker.com/_/eclipse-mosquitto/))

### What's Missing?
The trial version has the following notable limitations:

* No Policy Manager for accessing and customizing Gateway policies.  
* No Rest Management API for managing the Gateway. 
* No Cassandra database support. 

> These docker compose files provide a reference implementation. If you require different configurations of the images it is recommended that you create your own implementation.

### Limited License

The docker Mobile App Services image contains a license that expires on April 18th, 2017. After this date this image will no longer be usable.

See the [LICENSE][license-link] file for details.


## About MAS and MAG
**CA Mobile App Services (MAS)** is a set of tightly integrated mobile services that help enterprise developers quickly create secure mobile and IoT apps. Currently available MAS services are Messaging, User and Group Management, and Storage. We provide industry-leading secure infrastructure for app development. You get to focus on app design. 

For more information, see [http://mas.ca.com/][mas.ca.com]

**CA Mobile API Gateway (MAG)** provides enterprises with a secure mobile backend that integrates systems and allows control over which users, devices and applications can access your APIs. The gateway enables developers to leverage standards for API security such as (OAuth2, OpenID Connect, PKI) through client SDKs for Android, iOS and Apache Cordova.

For more information, see [http://docops.ca.com/mag](https://docops.ca.com/mag)


## Getting Started  

Let's go! 

### Install Docker ###
If you haven't already, you must install Docker:
1) Go to [https://www.docker.com](https://www.docker.com/)
2) Click "Get Started with Docker"
3) Download the Docker version that corresponds to your platform. Follow the Get Started Tutorial examples on the Docker site. 

 
### Clone the Docker-MAS Repository


To create a local copy of the Docker-MAS repo: 

1. Make a local directory to store your repo. 
2. `cd` into the directory and run:
   `git clone https://github.com/CAAPIM/Docker-MAS.git` 

The master branch is checked out. The master branch is the only stable branch. As such, be sure to use only the master branch for your MAS deployment. Other branches may be unstable, fail to install, or lack updated functionality.

### Running the Images


1) Open a terminal and type `docker-compose up`

   This starts CA Mobile App Services, MySQL, and Mosquitto Broker.  Ports 443, 8080, and 8443 must be available. See Troubleshooting.

2) Update your hosts file and add `127.0.0.1 mas`

   On a MAC or Linux machine the hosts file is `/etc/hosts`. On Windows, the hosts file is located at `C:\windows\System32\drivers\etc\hosts`
  > Note: If you are using Windows 7 or non-beta version of docker in MAC you will need to run `docker-machine ip` to get the ip address of the docker machine. See [Getting the IP Address of the Docker Instance](#GetIP) for more info.

3) Start creating apps. Login using one of the users from [below](#users)

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

Once the hosts file has been edited, open your browser and access the Developer Console.



### Working with Volumes
By default, MySQL uses a named volume `mysql-data`. This volume is used to persist data between start and stops of the docker images. To start with a clean instance, remove the volume. 

To remove the database volume run:  `docker volume rm dockermobile_mysql-data`


### Edit and Export MAS Environment Variables 
Customize your MAS installation by exporting one or more environment variables before starting the images. 

Environment variables are shown in the following table. 

|Environment Variable|Default Value|Description|
|---|---|---|
|ADD_TEST_CLIENTS|false|If **true**, test apps are added to the database.|
|ADD_TEST_USERS_GROUPS|true|If **true**, test users and groups are added to the database.|

#### Use a Custom Hostname

By default, the hostname is **mas**. The following command starts MAS with the custom hostname "my-mas.example.com":

```
export MAS_HOSTNAME="my-mas.example.com"
export BUNDLE_TEMPLATE_HOSTNAME=${MAS_HOSTNAME}
export BUNDLE_TEMPLATE_OTK_HOSTNAME=${MAS_HOSTNAME}
#The base64 encoded version of $MAS_HOSTNAME
export BUNDLE_TEMPLATE_HOSTNAME_ENCODED=`echo -n ${MAS_HOSTNAME} | base64`
#This is the base64 encoded version of http://$MAS_HOSTNAME
export BUNDLE_TEMPLATE_PROTOCOL_HOSTNAME_ENCODED=`echo -n http://${MAS_HOSTNAME} | base64`
docker-compose up
```

<a name="users"></a>
#### Test Users and Groups

The following users are available:

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

If you have installation problems, implementation questions, or enhancement requests, create an issue in Git.  
           
### Cannot Start MAS When Using a Custom Hostname

Any of the following errors indicates that you have changed the hostname in the database since the last installation. Currently, MAS does not support changing hostnames in the existing database:

- `ERROR - liquibase-otk-db.sh: Failed to create or update the OAuth Client for the Developer Console! dockermas_mas_1 exited with code 1`
- `ERROR - Failed to create or update the otk_db database on mysqldb dockermas_mas_1 exited with code 1`
- `Error - [-34018] Security error has occurred:`

To allow the new hostname, follow these steps:

1. Run these commands to delete the old volume and hostname:

 `docker-compose rm`  
 `docker volume rm <volume name>`    
 **Sample volume**: dockermas_mysql-data    
2. Get the latest compose script (git pull or complete clone), and restart the docker image:

 `docker-compose up`      

### Cannot Start MAS due to Existing Port Allocation
When you run ./MAS start, ports 443, 8080, and 8443 must be available, otherwise the service fails to start.

```ERROR: for mas  Cannot start service mas: driver failed programming external connectivity on endpoint dockermas_mas_1 (...0b43...): Bind for 0.0.0.0:8080 failed: port is already allocated```

Check to see if you have other images of Docker running, then free up those ports:
`docker ps`
Stop any running images:
`docker kill <containerID>`

Alternatively, specify a different unused port in the OTK-docker-compose file.
For example: `8081:8080`
where 8081 is the external port to expose on your machine, and 8080 is the corresponding internal port.

### Cannot start the Android Emulator

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
