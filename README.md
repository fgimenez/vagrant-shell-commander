[![Build Status](https://travis-ci.org/fgimenez/vagrant-shell-commander.png)](https://travis-ci.org/fgimenez/vagrant-shell-commander)
[![Code Climate](https://codeclimate.com/github/fgimenez/vagrant-shell-commander.png)](https://codeclimate.com/github/fgimenez/vagrant-shell-commander)

# Vagrant::Shell::Commander

Vagrant plugin for executing arbitrary shell commands on guest. Executes the given command on all the machines on multinode environments. It also gives the option to specify a working directory.

## Installation

As usual with vagrant plugins:

    $ vagrant plugin install vagrant-shell-commander

## Usage

To execute a command on all the machines:

    $ vagrant sh -c free

Restrict the machine to run:

    $ vagrant sh -c free machine1

Specify the working directory:

    $ vagrant sh -c 'ls -al' -d '/srv/www'

Get help:

    $ vagrant sh -h

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add and implement your specs
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
