# README #

## What is this repository for? ##

* Trying ansible to automatically generate a jenkins master and its build agent.

## Requirements ##
### Controller(The machine where you run Ansible ###
1. Internet connection
1. ssh client(on the controll machine)
1. Red Hat, Debian, CentOS, OS X, any of the BSDs, and so on.
1. Python 2.6 or 2.7
1. Ansible 2.3.1.0(It might be possible to use an older version of Ansible though)

### Linux target (to which you run your Ansible script) ###
1. ssh connection
1. Python 2.4 or higher.

### Windows target (to which you run your Ansible script) ###
1. PowerShell 3.0 or higher (on the target machine)
1. Configure Windows Remote Management(on the target machine)
	* https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1
1. pip install pywinrm (on the controller machine)

## How to run ##
### 1. Configure below
* inventory/hosts
* group\_vars/all (optional)
* roles/jenkins\_master/defaults/main.yml (optional)
* roles/jenkins\_windows\_nodes/defaults/main.yml (optional)
### 2. Configure Windows Machine
```
PS > mkdir C:\work
PS > cd C:\work
PS > Invoke-WebRequest -Uri https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 -OutFile ConfigureRemotingForAnsible.ps1
PS > .\ConfigureRemotingForAnsible.ps1
```
### 3. Set up Controller(Mac OS or Linux)
```
# curl -sL https://bootstrap.pypa.io/get-pip.py | python
# pip install pywinrm
``` 
* If you have installed Vagrant, run below(In this case you need to take care of ssh keys to access the remote repository).
```
$ vagrant controller up
$ vagrant ssh controller
```

### 4. Connection check
* When it comes to ping to Linux machines.
```
$ ansible -i inventory/hosts -m ping jenkins_master
```

* In case of Windows machines.
```
$ ansible -i inventory/hosts -m win_ping build_agent01
```

### 5. Then, run playbook
```
$ ansible-playbook -i inventory/hosts sites.yml 
```

* If you want to choose a specific target to be generated, run like below
```
$ ansible-playbook -l build_agent01 -i inventory/hosts sites.yml
```

## Todo ##
1. Nothing to do for a while.

## Future Work(Not to do right now) ##
### Use cases
1. Discussion about use cases and operations
1. Selecting Jenkins plugins and versions to install  
1. Capability to run on a no-internet environment
1. Sample jobs for jenkins master and windows node

### Quality concerns
1. How to support idempotence(since some part of the tasks contain modules which do not support idempotence)
1. Testing the generated CI Environment with automation tools such as serverspec 
1. Tackling security issues such as ssh key files

### Improve functionality
1. How to scale the # of build agents
1. Making Linux build agents
1. Global Tool Configuration of jenkins such as jdk home
1. Configure the role based strategy(If possible) 

### Small enhancement
1. How to manage large files such as jdk installer
1. Find a better way to skip the initial setup step
1. Ignores an error which occurs when the jenkins node 'build\_agent01' is already created. 
1. How to handle pinning plugins 

## References
* http://docs.ansible.com/ansible/latest/index.html
* http://qiita.com/yunano/items/f9d5652a296931a09a70
* http://qiita.com/t\_nakayama0714/items/fe55ee56d6446f67113c
* https://www.slideshare.net/dcubeio/ansible-72056386
* http://inokara.hateblo.jp/entry/2016/03/23/233009 
