if [ -S "$XDG_RUNTIME_DIR/qubes-ssh-agent/agent" ]; then
	ssh-agent -k >/dev/null 2>&1
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/qubes-ssh-agent/agent"
	unset SSH_AGENT_PID
fi
