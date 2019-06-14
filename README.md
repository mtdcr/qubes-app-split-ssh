# Qubes Split SSH

These Qubes scripts allow to keep SSH private keys in a separate VM (a "vault"), allowing other VMs to use them only after being authorized. This
is done by using Qubes' [qrexec framework](https://www.qubes-os.org/doc/qrexec2/) to connect a local unix socket in an AppVM to an SSH agent socket within the vault VM. Each connection creates a new SSH Agent, which only holds a single key as chosen by the user.

This was inspired by the Qubes [Split GPG](https://www.qubes-os.org/doc/split-gpg/) and [sshecret](https://github.com/thcipriani/sshecret).

Other details:
- This was developed/tested on the debian-9 template in Qubes 4.0.1; it might work for other templates
- You will be prompted to confirm each request, though like split GPG you won't see what was requested
- One can have an arbitrary number of vault VMs, you just need to adjust `/rw/config/ssh-vault`.

## About this fork

- This fork was based on https://github.com/a51f733a0cf842ec/qubes-app-split-ssh, which in turn was based on https://github.com/henn/qubes-app-split-ssh.
- It offers a more robust implementation of the server side, avoiding protocol errors and handling special characters.
- On the AppVM side, it needs almost no code, as it uses systemd's socket-activation feature.
- Each AppVM gets access to its own keyring only.
- You will be prompted to confirm each request for a key.
- Individual AppVMs can use it without further configuration, unless your SSH-vault doesn't use the default name ("ssh-vault"), in which case only one file needs to get adjusted.

## Installation instructions

Copy files from this repository to various destinations (VM is the first argument). You can use `qvm-copy <filename>`.

- Dom0

  * Copy `qubes.SshAgent.policy` to `/etc/qubes-rpc/policy/qubes.SshAgent`

- TemplateVM for SSH-vault

  * Copy `qubes.SshAgent` to `/etc/qubes-rpc/qubes.SshAgent`.
  * Make `qubes.SshAgent` executable. For example, running `sudo chmod +x /etc/qubes-rpc/qubes.SshAgent` in the TemplateVM
  * Shutdown your TemplateVM.

- TemplateVM for AppVM:

  * Copy `qubes-ssh-agent.sh` to `/etc/profile.d/`.
  * Copy `qubes-ssh-agent@.service` and `qubes-ssh-agent.socket` to `/etc/systemd/user/`. Run `sudo systemctl --global enable qubes-ssh-agent.socket`
  * Shutdown your TemplateVM.

- SSH-vault:

  * Create a directory `~/.qubes_ssh/$AppVM` for each AppVM allowed to access your SSH-vault.
  * Populate these directories with private and public SSH key files.
  * You cna have multiple private and public key pairs in each directory and will be prompted for the key to use. This may be useful for transitioning between keys.

- AppVM (optional):

  * Put the name of your SSH-vault into `/rw/config/ssh-vault`.
  * Restart your AppVM.
