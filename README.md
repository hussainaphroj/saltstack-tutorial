# saltstack-tutorial
# what is saltstack?
It is configuration *management*, *orchestration* and *remote execution* tool. Thomas Hatch is the founder of saltstack. It works on different Operating system such as *Window*, *Linux* and *Mac*.

It works in publication/subscribtion(pub/sub) model using ZeroMQ data bus.The master and Minions communicates with each using encrypted channel using AES key.

#Pub/sub model
* The master publish the command on port 4505
* Minions bind to that port and execute the command on themself
* Return the result to Master on port 4506

Salt contains over 20 pluggable subsystems. The following table contains a list of some of the more common subsystems in Salt:

Subsystem
-------------------------
Authentication	| Authorizes a user before running a job.
File server	| Distributes files.
Secure data store | Makes user-defined variables and other data securely available.
State representation | Describes your infrastructure and system configurations.
Return formatter | Formats job results into a normalized data structure.
Result cache | Sends job results to long-term storage.
Remote execution | Runs a wide variety of tasks to install software, distribute files, and other things you need to do to manage systems.
Configuration | Configures targeted systems to match a desired state.

![Plugins](../images/plugins.png)
