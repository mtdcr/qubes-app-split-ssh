install-client:
	install -d $(DESTDIR)/etc/profile.d
	install -m 644 qubes-ssh-agent.sh $(DESTDIR)/etc/profile.d/
	install -d $(DESTDIR)/etc/systemd/user
	install -m 644 qubes-ssh-agent@.service qubes-ssh-agent.socket $(DESTDIR)/etc/systemd/user/

install-vault:
	install -d $(DESTDIR)/etc/qubes-rpc
	install -m 755 qubes.SshAgent $(DESTDIR)/etc/qubes-rpc/

install-dom0:
	install -D -m 0664 qubes.SshAgent.policy $(DESTDIR)/etc/qubes-rpc/policy/qubes.SshAgent

install: install-client install-vault install-dom0
