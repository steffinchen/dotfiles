# completion
if [ -f ~/.config/exercism/exercism_completion.bash ]; then
  . ~/.config/exercism/exercism_completion.bash
fi


_codeComplete() {
	local cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $(compgen -W "$(ls /c/work/github/)" -- $cur) )
}

# aliases
alias ttdoing='ttrello mycards stefaniewehrle1 RSElvewB TMG -f "In Progress"'

alias fmp-integration='gulp debug-remote-environment-web --target=integration'

go() {
	cd c:/work/github/"$1"
	git pull
	code .
}

complete -F _codeComplete go

repo-search() {
	explorer "https://github.com/findmypast/"$1"/search?o=desc&q="$2"&s=committer-date&type=Commits&\""
}

repo-search-all() {
	explorer "https://github.com/search?q=org%3Afindmypast+"$1"&o=desc&s=committer-date&type=Commits&\""
}

repo-search-url() {
	echo "https://github.com/findmypast/"$1"/search?o=desc&q="$2"&s=committer-date&type=Commits"
}

vault-copy() {
	./vault.exe read -field=value secret/payments/"$1"/"$2" | ./vault.exe write secret/worldpay-service/"$1"/"$2" value=-
}

# start the ssh agen
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

complete -C C:\work\bin\vault\vault.exe vault

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
