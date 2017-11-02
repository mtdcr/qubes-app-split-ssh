# Qubes Split SSH

These Qubes scripts allow one to keep ssh private keys in a separate VM (a "vault"), allowing other VMs to use them only after being authorized. This
is done by using Qubes's [qrexec framework](https://www.qubes-os.org/doc/qrexec2/) to connect a local unix socket in an AppVM to a SSH Agent socket within the vault VM. Each connection creates a new SSH Agent, which only holds a single key as chosen by the user. 

This was inspired by the Qubes [Split GPG](https://www.qubes-os.org/doc/split-gpg/) and [sshecret](https://github.com/thcipriani/sshecret).

Other details:
- This was developed/tested on the debian-8 template in Qubes 4.0; it might work for other templates
- You will be prompted to confirm each request, though like split GPG you won't see what was requested
- One can have an arbitrary number of vault VMs, you just need to adjust `/etc/qubes-rpc/policy/qubes.SshAgent`

# Instructions

## Make

You can install with either `make install-vm` or `make install-adminvm`, depending on the VM

## Manual
Copy files from this repo to various destinations (VM is the first argument). You can use `qvm-copy-to-vm $DEST_VM file`

- Dom0: Copy qubes.SshAgent.policy to AdminVM's /etc/qubes-rpc/policy/qubes.SshAgent

- Template for Vault: Copy qubes.SshAgent to /etc/qubes-rpc/qubes.SshAgent in the template image for the Vault VM.

- Client VM: copy `qubes-ssh-agent` to `/usr/bin/`.
    * This is what starts the client side of the ssh agent
    * To run it automatically, add `. qubes-ssh-agent` to your .profile or .bashrc
    * Make sure `qubes-ssh-agent` is executable. ie - `chmod +x /usr/bin/qubes-ssh-agent`

# Todo

- Add timeout to qubes.SshAgent script, closing the connection after 10s perhaps 

- (possibly distant future) Figure out a way to display info on what is being signed
