install-vm:
	install -d $(DESTDIR)/etc/qubes-rpc
	install qubes.SshAgent $(DESTDIR)/etc/qubes-rpc
	install -d $(DESTDIR)/usr/bin
	install qubes-ssh-agent $(DESTDIR)/usr/bin

install-dom0:
	install -D -m 0664 qubes.SshAgent.policy $(DESTDIR)/etc/qubes-rpc/policy/qubes.SshAgent
