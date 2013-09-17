[![Build Status](https://travis-ci.org/fgimenez/vagrant-shell-commander.png)](https://travis-ci.org/fgimenez/vagrant-shell-commander)
[![Code Climate](https://codeclimate.com/github/fgimenez/vagrant-shell-commander.png)](https://codeclimate.com/github/fgimenez/vagrant-shell-commander)

# Vagrant::Shell::Commander

Vagrant plugin for running arbitrary shell commands on guest(s). Executes the given command on all the machines of multinode environments, or just in one of them. It also gives the option to specify a working directory and a user by command line.

It allows you to hook into the boot process, specifying a command to be run once the machine has finished the complete boot process. This can be handy for running init scripts which depends on files located in shared folders, for example.


## Installation

Given you have Vagrant 1.1+ installed, as usual with vagrant plugins:

    $ vagrant plugin install vagrant-shell-commander
    
or with the great Bindler, after adding a plugins.json with, at least:

    {
      "vagrant-shell-commander"
    }

execute:

    $ vagrant plugin bundle

## Usage

The command line utility is very similar to the ```vagrant ssh -c``` builtin command, but with multinode support and additional options. To execute a command on all the machines:

    $ vagrant sh -c free

Restrict the machine to run:

    $ vagrant sh -c free machine1

Specify the working directory (remember to quote multiword commands):

    $ vagrant sh -c 'ls -al' -d /srv/www

Get help:

    $ vagrant sh -h

To execute a command once the machine(s) has booted, add this configuration option to the Vagrantfile:

```ruby
Vagrant.configure("2") do |config|
  # other...

  config.sh.after_share_folders = "sudo /etc/init.d/myapp start"

end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add and implement your specs
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
