# Ansible virtualenv installer

Creates a python virtualenv with all the hacked versions of ansible
and its dependencies needed to use the AWS ansible modules.

## Prerequisites

* python 2.7.x
* virtualenv
* virtualenvwrapper (optional)

## Usage

If you have virtualenvwrapper, this will create a virtualenv called `ansible` in your `WORKON_HOME`.

```
./install.sh
```

If you _don't_ have virtualenvwrapper, you must specify the path to the virtualenv directory:

```
./install.sh ~/my-envs/ansible
```

# Using the virtualenv

With virtualenvwrapper:

```
workon ansible
```

Without virtualenvwrapper:

```
. ~/my-envs/ansible/bin/activate
```

Then run `ansible` or `ansible-playbook` as you normally would.
