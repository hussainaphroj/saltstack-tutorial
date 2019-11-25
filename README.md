# saltstack-tutorial
# Table of contents
1. [Introduction](#introduction)
2. [Components](#Components)
3. [Installation](#install)
4. [Configuration](#config)
5. [Salt Execution](#exec)

## what is saltstack? <a name="introduction"></a>
It is configuration *management*, *orchestration* and *remote execution* tool. Thomas Hatch is the founder of saltstack. It works on different Operating system such as *Window*, *Linux* and *Mac*.

It works in publication/subscribtion(pub/sub) model using ZeroMQ data bus.The master and Minions communicates with each using encrypted channel using AES key.

#Pub/sub model
* The master publish the command on port 4505
* Minions bind to that port and execute the command on themself
* Return the result to Master on port 4506

Salt contains over 20 pluggable subsystems. The following table contains a list of some of the more common subsystems in Salt:

Subsystem |  Desciption
-------------------------
Authentication	| Authorizes a user before running a job.
File server	| Distributes files.
Secure data store | Makes user-defined variables and other data securely available.
State representation | Describes your infrastructure and system configurations.
Return formatter | Formats job results into a normalized data structure.
Result cache | Sends job results to long-term storage.
Remote execution | Runs a wide variety of tasks to install software, distribute files, and other things you need to do to manage systems.
Configuration | Configures targeted systems to match a desired state.

![Plugins](/images/plugins.PNG)
PC: saltstack

# Different components of saltstack <a name="Components"></a>
* Salt Master:  It is central maanagement system that used to send command and cofiguration to managed systems that is *Minions*

* Salat Minions: It is managed system that execute the command and confiuration received from *Master*

* Execution Modules: It is remote execution system and runs the adhoc command that when called from *Master*

* Formulas (States): It is configuration management system. it containde code for configuration which written in YAML(Infras structue as code). State is single configured task such as installing ntp and formulas are the collectons of states.

* Grains: It contains the system varaible such OS,IP which are usefull to run the states based on operating system.

*  Pillar: It conaints the user defined varaible and can be used to store password, path etc.

* Runner: Modules that execute on the Salt master to perform supporting tasks. Salt runners report job status, connection status, read data from external APIs, query connected Salt minions

* Returners: Send data returned by Salt minions to another system, such as a database. Salt returners can run on the Salt minion or on the Salt master.

* Beacons & Reactors: Beacon monitors events on th system and Reactors react on that event.

* Salt SSH: Perform remote execution without installing salt.

* Salt Cloud: Provision the infrastructure on different cloud provider


# Installation <a name="install"></a>
We can perform installation using package manager such as yum, apt etc and using bootstrap. Bootstrap is my favourite to setup the master and Minions
### Master Setup
Minion by default looks master name as *salt* ,we will set hostname for master vm as *salt*
* set hostname
hostnamectl set-hostname salt
vi /etc/hosts
127.0.0.1 localhost salt

* Download bootstrap.sh 
curl -o bootstrap-salt.sh -L https://bootstrap.saltstack.com
* Check all the available option
 sh bootstrap-salt.sh --help
 * Install Master and Minion on the master machine ( I am using CentOS7). Run the installer
 sh bootstrap-salt.sh -P -M

### Minion setup
* set the hostname 
hostnamectl set-hostname minion1
vi /etc/hosts
127.0.0.1 localhost minion1
<IP_of_salt> salt

* Download bootstrap.sh 
curl -o bootstrap-salt.sh -L https://bootstrap.saltstack.com

* Run the installer
 sh bootstrap-salt.sh -P
# Configuration <a name="config"></a>
### key
As we know that communication between master and minion done through AES encrypetion.
Minon search for master(salt by default), initiate the connection request, send handshake and wait for master to accept the connection 

![key](/images/key.PNG)

### Master
* edit /etc/salt/master for file root: 
Make sure that the master uses /srv/salt as file root for formulas, Edit /etc/salt/master and uncomment 
```
file_roots:
  base:
    - /srv/salt
```
* restat the master service:
'systemctl restart salt-mast'

# Salt Execution <a name="exec"></a>
### Remote execution
```
salt '*' pkg.install httpd
```
* Breakdown:
   * salt: salt command that work on master
   * '*': Target host, that is all host we are targetting now
   * pkg: it is module name
   * install: it is the function of pkg module.
   * httpd: is parameter.
   That we want to install httpd on all the minions.

* There are different way to target minions:
  * salt '*' test.ping 
  * salt 'minion*' test.ping
  * salt *minion[1-2]* test.ping 
  * Grain based targetting
     * salt -G 'os:CentOS' test.ping
     * salt -G 'os:Ubuntu' test.ping
     * salt -G 'roles:webserver' test.ping
     #### Note: to add the roles, we need create grains.conf in /etc/salt/minion.d/ on each main as
     ```
     grains:
       roles:
         - webserver

### Common modules:
  * sys: is for help and documentation. The below command list all the functions available for pkg module and next one is for all parameters for pkg.install
  ``` salt 'minion1' sys.list_functions pkg.install```

  ``` salt 'minion1' sys.argspec pkg.install ```
  
  * test: for testing connection and outputter 
  ``` salt '*' test.ping ```
  ``` salt '*' test.outputter \"Testing outputter\" ```
 
   * pkg: This is managing for packag management.
   ``` salt '*' pkg.install httpd ```
   ``` salt '*' pkg.remove httpd ```
   ``` salt '*' pkg.upgrade httpd ```

   * User & Group: for user and group management
     ``` salt '*' group.add tom ```
     ``` salt '*' group.adduser tom harry```
     ``` salt '*' user.add hussain home=/home/hussain ```

    * cmd: to execute any command
    ``` salt 'minion*' cmd.run "cat /etc/passwd" ```

    Please refer the below link for more modules details
    (https://docs.saltstack.com/en/latest/salt-modindex.html)
